#pragma once

#include "SubPass.hh"

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

struct InjectPass : public SubPass {
  static constexpr bool VOLATILE = false;
  static constexpr bool NONTEMPORAL = true;

  // Determine whether instrument is needed
  bool check(llvm::Instruction& inst) {
    // AddressSpace: https://www.llvm.org/docs/AMDGPUUsage.html#address-spaces
    // global / private
    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      return load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5;
    } else if (llvm::isa<llvm::StoreInst>(&inst)) {
      auto store_inst = llvm::dyn_cast<llvm::StoreInst>(&inst);
      return store_inst->getPointerAddressSpace() == 1 || store_inst->getPointerAddressSpace() == 5;
    }
    return false;
  }

  // https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table
  // we can set glc slc dlc through volatile or nontemporal attribute
  void instrument(llvm::Instruction& inst) {
    if (check(inst)) {
      if (VOLATILE) {
        if (llvm::isa<llvm::LoadInst>(&inst)) {
          llvm::dyn_cast<llvm::LoadInst>(&inst)->setVolatile(true);
        } else if (llvm::isa<llvm::StoreInst>(&inst)) {
          llvm::dyn_cast<llvm::StoreInst>(&inst)->setVolatile(true);
        }
      }
      if (NONTEMPORAL) {
        inst.setMetadata("nontemporal", llvm::MDNode::get(inst.getContext(), {}));
      }
    }
  }

  void runSubPass(llvm::Function& F) override {
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          instrument(Inst);
        }
      }
    }
  }
};

} // namespace cm
