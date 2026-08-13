#pragma once

#include "SubPass.hh"

namespace cm {

struct IRGenPass : public SubPass {
  // number of eligible insts
  int load_inst_count, store_inst_count;
  std::error_code EC;
  std::string path;

  void runSubPass(llvm::Function& F) override {
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      load_inst_count = 0;
      store_inst_count = 0;
      if (auto cm_proj_path = getenv("CM_PROJ_PATH")) {
        path = (std::string(cm_proj_path) + "/tmp/IR/" + F.getName() + ".ll").str();
      } else {
        path = (F.getName() + ".ll").str();
        llvm::outs() << "Warn env CM_PROJ_PATH not set!\n";
      }
      llvm::outs() << "IR: " << path << "\n";
      llvm::raw_fd_ostream ir_buffer = llvm::raw_fd_ostream(path, EC);
      if (getenv("PASS_VIEW_CFG"))
        F.viewCFG();
      for (auto& BB : F) {
        for (auto& Inst : BB) {
          if (llvm::isa<llvm::LoadInst>(Inst)) {
            load_inst_count++;
          } else if (llvm::isa<llvm::StoreInst>(Inst)) {
            store_inst_count++;
          }
        }
      }
      ir_buffer << "; Load : " << load_inst_count << " Store: " << store_inst_count << "\n";
      ir_buffer << F;
    }
  }
};

} // namespace cm
