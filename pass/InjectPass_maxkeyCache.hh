#pragma once

#include "SubPass.hh"
#include <stdio.h>
#include "llvm/Analysis/ValueTracking.h"
#include <iostream>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

namespace cm {

// https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
// Combination (L:Load S:Store)
// ---------------------------------
// VOLATILE    |    0     0     1     1
// NONTEMPORAL |    0     1     0     1
// glc(L/S)    |   0/0   0/1   1/0   1/0
// dlc(L/S)    |   0/0   0/0   1/0   1/0
// slc(L/S)    |   0/0   1/1   0/0   0/0

// https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx6-gfx9-table
// Combination (L:Load S:Store)
// ---------------------------------
// VOLATILE    |    0（L1L2正常cache） 0 (L1L2全bypass)    1     1      
// NONTEMPORAL |    0                 1                   0     1
// glc(L/S)    |   0/0               1/1                  1/0   1/0
// slc(L/S)    |   0/0               1/1                  0/0   0/0

struct InjectPass_maxkeyCache : public SubPass {
  static constexpr bool VOLATILE = false;
  static constexpr bool NONTEMPORAL = false;
  std::map<llvm::Value*, int> array_map;
  std::error_code error;
  std::vector<int> array_flag; // all initialized to zero
  llvm::Value* max_key;
  int cache_num = 0;
  int bypass_num = 0;
  int load_require = 0;
  // llvm::raw_fd_ostream file("/workspace/Inst-level-cache-management/pass/injectPass.log", error);

  // consturc the array_map
  bool construct(llvm::Instruction& inst) {
    // AddressSpace: https://www.llvm.org/docs/AMDGPUUsage.html#address-spaces
    // global / private
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = load_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // llvm::outs() << "load_inst:" << load_inst << "\n";
        // llvm::outs() << "pointer:" << pointer << "\n";
        // llvm::outs() << "object:" << object << "\n";
        if(array_map.find(object)!=array_map.end()){
          array_map[object] +=1;
        }
        else{
          array_map.insert(std::make_pair(object, 1));
        }
        return true;
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) {
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // llvm::outs() << "store_inst:" << store_inst << "\n";
        // llvm::outs() << "pointer:" << pointer << "\n";
        // llvm::outs() << "object:" << object << "\n";
        if(array_map.find(object)!=array_map.end()){
          array_map[object] +=1;
        }
        else{
          array_map.insert(std::make_pair(object, 1));
        }
        return true;
      }
    }
    return false;
  }

  // Determine whether instrument is needed
  bool check(llvm::Instruction& inst) {
    // AddressSpace: https://www.llvm.org/docs/AMDGPUUsage.html#address-spaces
    // global / private
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        // file << "inst----"<<inst<<;
        // std::string InstString;
        // llvm::raw_string_ostream rso(InstString);
        // inst.print(rso);
        llvm::outs() << *load_inst <<"\n";


        llvm::Value* pointer = load_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);

        // if(load_require == 3) {
        //   llvm::outs() << *load_inst << ": false" <<"\n";
        //   return false;
        // }

        if(object == max_key) return true; // cache
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) {
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        if(object == max_key) return true; // cache
      }
    }
    return false; //bypass
  }


  // // https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
  // // we can set glc slc dlc through volatile or nontemporal attribute
  // void instrument(llvm::Instruction& inst) {
  //   if (check(inst)) {
  //     if (VOLATILE) {
  //       if (llvm::isa<llvm::LoadInst>(&inst)) {
  //         llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(true);
  //       } else if (llvm::isa<llvm::StoreInst>(&inst)) {
  //         llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(true);
  //       }
  //     }
  //     if (NONTEMPORAL) {
  //       inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
  //     }
  //   }
  // }


  // https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
  // we can set glc slc dlc through volatile or nontemporal attribute
  void instrument(llvm::Instruction& inst) {
    if (check(inst)) { // cache
      cache_num+=1;
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(false);
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(false);
      }
    }
    else { // bypass，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      // 上面是剔除到非global非private的load Store
      // bypass_num+=1; 不能放在这里，因为还有许多除了load外的其他指令
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        bypass_num+=1;
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(false);
        inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        bypass_num+=1;
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(false);
        inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  void runSubPass(llvm::Function& F) override {
    array_map.clear();
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          construct(Inst);
        }
      }
    }
    
    if (array_map.size() == 0){
      return;
    }
    
    // determine the address which is cached
    max_key = nullptr;
    int max_value = 0;
    int index = 0;
    int max_index = -1;
    array_flag.clear();
    for(const auto& pair : array_map) {
      llvm::Value* key = pair.first;
      int value = pair.second;
      // llvm::outs() << "Key: " << key << ", Value: " << value << "\n";
      array_flag.push_back(0); // only use once, then bypass
      if (value > max_value){ // must greater than 1, so choose the first max to cache
        max_key = key;
        max_value = value;
        max_index = index;
      }
      index += 1;
    }
    if(max_index != -1) array_flag[max_index] = 1;

    // print to see
    // llvm::outs() << max_key << ":" << max_value <<"\n";
    // for(int i=0; i<array_flag.size();i++){
    //   llvm::outs() << array_flag[i] <<"\n";
    // }

    // cache that
    cache_num = 0;
    bypass_num = 0;
    load_require = 0;
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          instrument(Inst);
        }
      }
    }
    // llvm::raw_fd_ostream file("/workspace/Inst-level-cache-management/pass/injectPass.log", error);
    // file<<F.getName()<<" "<<"cache_num:"<<cache_num<<", "<<"bypass_num:"<<bypass_num<<"\n";
    // file.close();
    // std::error_code EC;
    // llvm::raw_fd_ostream file("/workspace/Inst-level-cache-management/pass/injectPass.log", EC, llvm::sys::fs::OpenFlags::F_Append);
    // if(EC){
    //     llvm::errs() << EC.message() << "\n";
    //     return;
    // }
    // file<<F.getName()<<" "<<"cache_num:"<<cache_num<<", "<<"bypass_num:"<<bypass_num<<"\n";
    // file.close();
    int fd = open("/workspace/Inst-level-cache-management/pass/injectPass.log", O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        llvm::errs() << "Error opening file\n";
        return;
    }
    llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);
    file << F.getName() << "----\n";
    for(const auto& pair : array_map) {
      file << "Key: " << pair.first << ", Value: " << pair.second << "\n";
    }
    file << "max_key: " <<  max_key << ":" << max_value <<"\n";
    file << "cache_num:" << cache_num << ", " << "bypass_num:" << bypass_num << "\n";
    file << "load_require:" << load_require << "\n";
    file << "----\n";
    file.close();
  }
  
};

} // namespace cm
