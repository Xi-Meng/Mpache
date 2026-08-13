#pragma once

#include "SubPass.hh"
#include <cstdlib>

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
// VOLATILE    |    0     0     1     1
// NONTEMPORAL |    0     1     0     1
// glc(L/S)    |   0/0   1/1   1/0   1/0
// slc(L/S)    |   0/0   1/1   0/0   0/0

struct InjectPass_brute: public SubPass {
  // int setting_mask;
  // static constexpr bool VOLATILE = false;
  // static constexpr bool NONTEMPORAL = true;

  // 新的构造函数，接受设置mask
  // InjectPass_brute(int mask): setting_mask(mask) {}
  // int bit[12];
  char* bitString;
  int cnt; // counting counter
  char* app_name;
  // Determine whether instrument is needed
  bool check(llvm::Instruction& inst) {
    // AddressSpace: https://www.llvm.org/docs/AMDGPUUsage.html#address-spaces
    // global / private
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      return load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5;
    }
    // else if (llvm::isa<llvm::StoreInst>(&inst)) {
    //   auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
    //   return store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5;
    // }
    return false;
  }

  // https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
  // we can set glc slc dlc through volatile or nontemporal attribute
  void instrument(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {   // bypass L1 L2
    // file << "instrument" <<"\n";
    if (check(inst)) { // satisfy the requirement
      // if (llvm::isa<llvm::LoadInst>(&inst)) {
      //   llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(false);
      // } else if (llvm::isa<llvm::StoreInst>(&inst)) {
      //   llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(false);
      // }
      // inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      
      int policy = bitString[cnt] - '0';
      file << cnt << ":" << policy << "\n";
      llvm::Value* pointer = llvm::dyn_cast<llvm::LoadInst>(&inst)->getPointerOperand();
      llvm::Value* object = llvm::getUnderlyingObject(pointer);
      file << pointer << " --- " << object << ":" << policy << "\n";
      if (policy == 0){ // baseline
        // llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(false);
      } else if (policy == 1) // 只设置nontemporal
      {
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(false);
        inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      } else if (policy == 2){ // 
        llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(true);
      } else{
        file << "error!\n";
      }
      cnt += 1;
    }
  }

  void runSubPass(llvm::Function& F) override {
    app_name = std::getenv("APP_NAME");
    std::string pathToFile = "/workspace/Inst-level-cache-management/scripts/" + std::string(app_name) + "/" + std::string(app_name) + ".log";
    int fd = open(pathToFile.c_str(), O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    // int fd = open("/workspace/Inst-level-cache-management/scripts/sssp/sssp.log", O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    if (fd == -1) {
        llvm::errs() << "Error opening file\n";
        return;
    }
    llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);

    bitString = std::getenv("INJECT_BIT");
    file << "runSubPass:" << bitString << "\n";
    // std::cout << "runSubPass:" << bitString << "\n";
    cnt = 0;
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          instrument(Inst, file);
        }
      }
    }
    
    // file.close();
  }
};

} // namespace cm
