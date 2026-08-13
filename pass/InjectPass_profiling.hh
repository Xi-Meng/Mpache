#pragma once

#include "SubPass.hh"
#include <stdio.h>
#include "llvm/Analysis/ValueTracking.h"
#include <iostream>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sstream>


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

struct InjectPass_profiling : public SubPass {
  // static constexpr bool VOLATILE = true;
  // static constexpr bool NONTEMPORAL = true;
  // bool VOLATILE = std::strcmp(std::getenv("VOLATILE"), "true") == 0 ? true : false;
  // bool NONTEMPORAL = std::strcmp(std::getenv("NONTEMPORAL"), "true") == 0 ? true : false;

  std::vector<std::string> strSearch_vec;
  bool VOLATILE;
  bool NONTEMPORAL;
 
  int cache_num = 0;
  int bypass_num = 0;
  int load_require = 0;
  char* search;
  char* kernel;
  char* store_bypass;

  std::vector<std::string> split(std::string str, std::string delimiter) {
    size_t pos = 0;
    std::vector<std::string> res;
    while ((pos = str.find(delimiter)) != std::string::npos) {
        res.push_back(str.substr(0, pos));
        str.erase(0, pos + delimiter.length());
    }
    res.push_back(str);
    return res;
  }

  // Determine whether instrument is needed
  bool check(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
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

        // 取出结果寄存器
        std::string str;
        llvm::raw_string_ostream rso(str);
        inst.print(rso);
        // 查找'='符号之前的子串，也就是"%20"
        size_t pos = str.find('=');
        std::string result;
        if (pos != std::string::npos)
        {
            result = str.substr(0, pos);  // 从0到'='位置的子串，注意此时包含了一些额外的空格
            result.erase(std::remove(result.begin(), result.end(), ' '), result.end());  // 移除子串中的空格
        }
        // std::cout << "Result: " << result << "\n";  // 输出 "%20"
        file << result << " ";
        
        // return false;
        // return true;
        // search = std::getenv("SEARCH");
        // std::string strSearch = std::string(search);
        // file << "strSearch: " << strSearch << "\n";
        // auto strSearch_vec = split(strSearch, ",");

        bool found = false; 
        for(auto &s: strSearch_vec){
            if(s == result){
              found = true;

              file << "bypass: " << *load_inst <<"\n";
              bypass_num+=1;
              return false; // bypass
            }
        }
        if(!found){
          // file << "cache: " << *load_inst <<"\n";
          cache_num+=1;
          return true; // cache
        }
        // return true;
        // if( result == search )
        // {
        //   file << "bypass: " << *load_inst <<"\n";
        //   bypass_num+=1;
        //   return false; // bypass
        // }
        // else {
        //   // file << "cache: " << *load_inst <<"\n";
        //   cache_num+=1;
        //   return true; // cache
        // }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);

        // file << "bypass: " << *store_inst <<"\n";
        // return false;
        // return true;
        char* store_bypass = std::getenv("STOREBYPASS");
        if (store_bypass == std::string("true"))
        {
          file << "bypass: " << *store_inst <<"\n";
          return false;
        }
        else return true; //cache
        
      }
    }
    return true; //cache
  }

  // https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
  // we can set glc slc dlc through volatile or nontemporal attribute
  void instrument(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check(inst, file)) { // cache
      
    }
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
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
        // bypass_num+=1;
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE);
        if (NONTEMPORAL) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE);
        if (NONTEMPORAL) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }


  void runSubPass(llvm::Function& F) override {
    int fd = open("/workspace/Inst-level-cache-management/system/injectPass.log", O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        llvm::errs() << "Error opening file\n";
        return;
    }
    llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);

    // cache that
    cache_num = 0;
    bypass_num = 0;
    load_require = 0;

    // pre work ------------------------
    search = std::getenv("SEARCH");
    std::string strSearch = std::string(search);
    // file << "strSearch: " << strSearch << "\n";
    strSearch_vec = split(strSearch, ",");

    char* volatile_value = std::getenv("VOLATILE");
    // file << "volatile_value: " << volatile_value << "\n";
    if (volatile_value == std::string("true")) VOLATILE = true;
    else VOLATILE = false;

    char* nontemporal_value = std::getenv("NONTEMPORAL");
    // file << "nontemporal_value: " << nontemporal_value << "\n";
    if (nontemporal_value == std::string("true")) NONTEMPORAL = true;
    else NONTEMPORAL = false;
    // file << "NONTEMPORAL: " << NONTEMPORAL << "\n";
    

    // file << "F.getName():" << F.getName() << "\n";
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      file << "F.getName():" << F.getName() << "\n";
      // std::cout << "Function name: " << F.getName().str() << std::endl;
      // if (F.getName()=="_Z9conv_colsPfPKfS1_iii"){
      kernel = std::getenv("KERNEL");
      if (F.getName() == kernel){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument(Inst, file);
          }
        }
      }

      // if (F.getName()=="_Z8spmv_jdsPfPKfPKiS3_S1_S3_i"){
      //   for (auto& BB : F) {
      //     for (auto& Inst : BB) {
      //       // file << "Inst: " << Inst << "\n";
      //       instrument2(Inst, file);
      //     }
      //   }
      // }

      // if (F.getName()=="_Z13DCT8x8_kernelPfPKfjjj"){
      //   for (auto& BB : F) {
      //     for (auto& Inst : BB) {
      //       // file << "Inst: " << Inst << "\n";
      //       instrument3(Inst, file);
      //     }
      //   }
      // }
      
      file << "cache_num:" << cache_num << ", " << "bypass_num:" << bypass_num << "\n";
      file << "load_require:" << load_require << "\n";
      file << "strSearch: " << strSearch << "\n";
      file << "VOLATILE:" << VOLATILE <<"\n";
      file << "NONTEMPORAL:" << NONTEMPORAL <<"\n";
      file << "----\n";
    }
      
    
    
    file.close();
  }
  
};

} // namespace cm
