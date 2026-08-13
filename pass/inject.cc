/**
This pass is used to change load store flag(such as glc dlc slc)
usage: clang -fpass-plugin=/path-to-kernel.so
**/
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include <llvm/IR/Constants.h>
#include <filesystem>
#include <string>

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

namespace {
struct HipPass : llvm::PassInfoMixin<HipPass> {
  static constexpr bool VOLATILE = false;
  static constexpr bool NONTEMPORAL = true;

  // number of eligible insts
  int load_inst_count = 0, store_inst_count = 0;

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
      if (llvm::isa<llvm::LoadInst>(&inst)) {
        load_inst_count++;
      } else {
        store_inst_count++;
      }
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

  llvm::PreservedAnalyses run(llvm::Function& F, llvm::FunctionAnalysisManager& FAM) {
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      std::error_code EC;
      std::string path;
      if (auto cm_proj_path = getenv("CM_PROJ_PATH")) {
        path = (std::string(cm_proj_path) + "/tmp/IR/" + F.getName() + ".ll").str();
      } else {
        path = (std::string(std::filesystem::current_path()) + "/" + F.getName() + ".ll").str();
        llvm::outs() << "Warn env CM_PROJ_PATH not set!\n";
      }
      llvm::outs() << path << "\n";
      llvm::raw_fd_ostream ir_buffer = llvm::raw_fd_ostream(path, EC);
      if (getenv("PASS_VIEW_CFG"))
        F.viewCFG();
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          instrument(Inst);
        }
      }
      ir_buffer << "; Load : " << load_inst_count << " Store: " << store_inst_count << "\n";
      ir_buffer << F;
    }
    return llvm::PreservedAnalyses::all();
  }

  static bool isRequired() {
    return true;
  }
};

} // namespace

llvm::PassPluginLibraryInfo getKernelPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "hipkernel", LLVM_VERSION_STRING, [](llvm::PassBuilder& PB) {
            PB.registerVectorizerStartEPCallback(
                [](llvm::FunctionPassManager& FAM, llvm::OptimizationLevel) { FAM.addPass(HipPass()); });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return getKernelPluginInfo();
}
