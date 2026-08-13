/**
usage: clang -fpass-plugin=/path-to-kernel.so
**/
#include "CFGPass.hh"
#include "DFGPass.hh"
#include "InjectPass.hh"
#include "IRGenPass.hh"
#include <vector>

namespace {
struct HipPass : llvm::PassInfoMixin<HipPass> {
  std::vector<cm::SubPass *> passes;

  // register pass
  HipPass() {
    addPass(new cm::IRGenPass());
    addPass(new cm::DFGPass(true));
    addPass(new cm::DFGPass(false));
    addPass(new cm::CFGPass(true));
    addPass(new cm::CFGPass(false));
    addPass(new cm::InjectPass());
  }

  // helper function to register pass
  void addPass(cm::SubPass *passRegister) {
    passes.push_back(passRegister);
  }

  // traverse all registered pass
  llvm::PreservedAnalyses run(llvm::Function& F, llvm::FunctionAnalysisManager& FAM) {
    for (auto passRegister : passes) {
      passRegister->runSubPass(F);
    }
    return llvm::PreservedAnalyses::all();
  }

  static bool isRequired() {
    return true;
  }
};

} // namespace

llvm::PassPluginLibraryInfo getKernelPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HipPass", LLVM_VERSION_STRING, [](llvm::PassBuilder& PB) {
            PB.registerVectorizerStartEPCallback(
                [](llvm::FunctionPassManager& FAM, llvm::OptimizationLevel) { FAM.addPass(HipPass()); });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return getKernelPluginInfo();
}
