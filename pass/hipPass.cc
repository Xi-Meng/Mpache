/**
usage: clang -fpass-plugin=/path-to-kernel.so
**/
#include "CFGPass.hh"
#include "DFGPass.hh"
#include "InjectPass_bypassL1.hh"
#include "InjectPass_bypassAll.hh"
#include "InjectPass.hh"
#include "IRGenPass.hh"
#include "InjectPass_brute.hh"
#include "InjectPass_maxkeyCache.hh"
#include "InjectPass_bfs.hh"
#include "InjectPass_srad.hh"
#include "InjectPass_jacobi1D.hh"
#include "InjectPass_spmv.hh"
#include "InjectPass_3dconv.hh"
#include "InjectPass_backprop.hh"
#include "InjectPass_floyd_warshall.hh"
#include "InjectPass_streamcluster.hh"
#include "InjectPass_epistasis.hh"
#include "InjectPass_ge_spmm.hh"
// #include "InjectPass_sssp.hh"
#include "InjectPass_search.hh"
#include "InjectPass_profiling.hh"
#include "InjectPass_store.hh"
#include "InjectPass_profiling_multicache.hh"
#include "GroupDivisonPass.hh"
#include <vector>
#include <string.h>

namespace {
struct HipPass : llvm::PassInfoMixin<HipPass> {
  std::vector<cm::SubPass *> passes;

  // register pass
  HipPass() {
    addPass(new cm::IRGenPass(), std::getenv("IR_ENABLE"));
    // addPass(new cm::GroupDivisonPass(), "ON");
    // addPass(new cm::DFGPass(true), "ON");
    // addPass(new cm::DFGPass(false));
    // addPass(new cm::CFGPass(true), "ON");
    // addPass(new cm::CFGPass(false));
    // addPass(new cm::InjectPass_bypassL1(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_bypassAll(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass());
    // addPass(new cm::InjectPass_brute(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_maxkeyCache());
    // addPass(new cm::InjectPass_bfs(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_srad());
    // addPass(new cm::InjectPass_jacobi1D());
    // addPass(new cm::InjectPass_spmv(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_3dconv(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_backprop(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_hotspot(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_streamcluster(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_floyd_warshall(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_ge_spmm(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_sssp(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_search(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_store(), std::getenv("BYPASS_ENABLE"));
    // addPass(new cm::InjectPass_profiling(), std::getenv("BYPASS_ENABLE"));
    addPass(new cm::InjectPass_profiling_multicache(), std::getenv("BYPASS_ENABLE"));

  }

  // helper function to register pass
  void addPass(cm::SubPass *passRegister, char* ENABLE) {
    // llvm::outs() << ENABLE << "---------------------------\n";
    if (strcmp(ENABLE, "ON") == 0)
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
