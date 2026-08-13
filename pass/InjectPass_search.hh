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

struct InjectPass_search : public SubPass {
  static constexpr bool VOLATILE = true;
  static constexpr bool NONTEMPORAL = true;
  
  static constexpr bool VOLATILE2 = false;
  static constexpr bool NONTEMPORAL2 = true;

  static constexpr bool VOLATILE3 = true;
  static constexpr bool NONTEMPORAL3 = true;

  static constexpr bool VOLATILE4 = true;
  static constexpr bool NONTEMPORAL4 = true;

  static constexpr bool VOLATILE5 = false;
  static constexpr bool NONTEMPORAL5 = true;

  static constexpr bool VOLATILE6 = true;
  static constexpr bool NONTEMPORAL6 = true;

  int cache_num = 0;
  int bypass_num = 0;
  int load_require = 0;
  char* search;
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
        // load_require: 8 1
        // %14
        // %16 %21 %24 %32 %35 %40 %42 %43
        // !! 具有局部性：%14 %24 %35     %32
        // 流式：%16 %40 %42 %43   %21
        // 不定：%21 %32
        file << "bypass: " << *load_inst <<"\n";
        return false;
        // return true;

        search = std::getenv("SEARCH");
        // if(result == "%47")
        // %23_%29_%35_%41_%47_%53_%59_%65
        // if(result == "%23" || result == "%29" || result == "%35" || result == "%41" || result == "%47" || result == "%53" || result == "%59" || result == "%65")
        if( result == "%153" )
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1;
          return false; // bypass
        }
        else {
          // file << "cache: " << *load_inst <<"\n";
          cache_num+=1;
          return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);

        file << "bypass: " << *store_inst <<"\n";
        return false;
        
        return true;
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

  bool check2(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        std::string str; llvm::raw_string_ostream rso(str); inst.print(rso);
        size_t pos = str.find('='); std::string result;
        if (pos != std::string::npos) {result = str.substr(0, pos); result.erase(std::remove(result.begin(), result.end(), ' '), result.end());}
        file << result << " ";
        // return false;
        // return true;
        search = std::getenv("SEARCH");
        if(result != "%66")
        // if( result == search )
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1; return false; // bypass
        }
        else {
          cache_num+=1; return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // file << "bypass: " << *store_inst <<"\n";
        // return false;
        return true;
      }
    }
    return true; //cache
  }

  void instrument2(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check2(inst, file)) {} //cache
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE2);
        if (NONTEMPORAL2) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE2);
        if (NONTEMPORAL2) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  bool check3(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        std::string str; llvm::raw_string_ostream rso(str); inst.print(rso);
        size_t pos = str.find('='); std::string result;
        if (pos != std::string::npos) {result = str.substr(0, pos); result.erase(std::remove(result.begin(), result.end(), ' '), result.end());}
        // file << result << " ";
        // return false;
        // return true;
        search = std::getenv("SEARCH");
        // if(result == "%62")
        if(result == "%23" || result == "%29" || result == "%35" || result == "%41" || result == "%47" || result == "%53" || result == "%59" || result == "%65")
        // if( result == search )
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1; return false; // bypass
        }
        else {
          cache_num+=1; return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        file << "bypass: " << *store_inst <<"\n";
        return false;
        return true;
      }
    }
    return true; //cache
  }

  void instrument3(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check3(inst, file)) {} //cache
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE3);
        if (NONTEMPORAL3) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE3);
        if (NONTEMPORAL3) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  bool check4(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        std::string str; llvm::raw_string_ostream rso(str); inst.print(rso);
        size_t pos = str.find('='); std::string result;
        if (pos != std::string::npos) {result = str.substr(0, pos); result.erase(std::remove(result.begin(), result.end(), ' '), result.end());}
        file << result << " ";
       
        if(result == "%23")
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1; return false; // bypass
        }
        else {
          cache_num+=1; return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // file << "bypass: " << *store_inst <<"\n";
        // return false;
        return true;
      }
    }
    return true; //cache
  }

  void instrument4(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check4(inst, file)) {} //cache
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE4);
        if (NONTEMPORAL4) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE4);
        if (NONTEMPORAL4) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  bool check5(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        std::string str; llvm::raw_string_ostream rso(str); inst.print(rso);
        size_t pos = str.find('='); std::string result;
        if (pos != std::string::npos) {result = str.substr(0, pos); result.erase(std::remove(result.begin(), result.end(), ' '), result.end());}
        file << result << " ";
       
        if(result == "%153")
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1; return false; // bypass
        }
        else {
          cache_num+=1; return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // file << "bypass: " << *store_inst <<"\n";
        // return false;
        return true;
      }
    }
    return true; //cache
  }

  void instrument5(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check5(inst, file)) {} //cache
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE5);
        if (NONTEMPORAL5) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE5);
        if (NONTEMPORAL5) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  bool check6(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        load_require += 1;
        std::string str; llvm::raw_string_ostream rso(str); inst.print(rso);
        size_t pos = str.find('='); std::string result;
        if (pos != std::string::npos) {result = str.substr(0, pos); result.erase(std::remove(result.begin(), result.end(), ' '), result.end());}
        file << result << " ";
       
        if(result == "%62")
        {
          file << "bypass: " << *load_inst <<"\n";
          bypass_num+=1; return false; // bypass
        }
        else {
          cache_num+=1; return true; // cache
        }
      }
    }
    else if (llvm::isa<llvm::StoreInst>(&inst)) { // store 总是cache
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      if (store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = store_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // file << "bypass: " << *store_inst <<"\n";
        // return false;
        return true;
      }
    }
    return true; //cache
  }

  void instrument6(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (check6(inst, file)) {} //cache
    else { // bypass L1，这里原来的代码把非global非private的也bypass了
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
        if (load_inst->getPointerAddressSpace() != 1 && load_inst->getPointerAddressSpace() != 5) return; 
      } 
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
        if (store_inst->getPointerAddressSpace() != 1 && store_inst->getPointerAddressSpace() != 5) return;
      }
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(VOLATILE6);
        if (NONTEMPORAL6) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
      else if (llvm::isa<llvm::StoreInst>(&inst)) {
        llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(VOLATILE6);
        if (NONTEMPORAL6) inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  void runSubPass(llvm::Function& F) override {
    int fd = open("/workspace/Inst-level-cache-management/pass/injectPass.log", O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        llvm::errs() << "Error opening file\n";
        return;
    }
    llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);

    // cache that
    cache_num = 0;
    bypass_num = 0;
    load_require = 0;
    // file << "F.getName():" << F.getName() << "\n";
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      file << "F.getName():" << F.getName() << "\n";
      // std::cout << "Function name: " << F.getName().str() << std::endl;
      if (F.getName()=="performStreamCollide_kernel" || F.getName()=="_Z13DCT8x8_kernelPfPKfjjj" || F.getName()=="_Z14IDCT8x8_kernelPfPKfjjj"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument(Inst, file);
          }
        }
      }

      if (F.getName()=="_Z8spmv_jdsPfPKfPKiS3_S1_S3_i"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument2(Inst, file);
          }
        }
      }

      if (F.getName()=="_Z9conv_colsPfPKfS1_iii"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument3(Inst, file);
          }
        }
      }

      if (F.getName()=="_Z12bucketprefixPjS_"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument4(Inst, file);
          }
        }
      }

      if (F.getName()=="_Z13mergeSortPassPK15HIP_vector_typeIfLj4EEPS0_PKiiii"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument5(Inst, file);
          }
        }
      }

      if (F.getName()=="_Z9conv_rowsPfPKfS1_iii"){
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            // file << "Inst: " << Inst << "\n";
            instrument6(Inst, file);
          }
        }
      }
      
      file << "cache_num:" << cache_num << ", " << "bypass_num:" << bypass_num << "\n";
      file << "load_require:" << load_require << "\n";
      file << "----\n";
    }
      
    
    
    file.close();
  }
  
};

} // namespace cm
