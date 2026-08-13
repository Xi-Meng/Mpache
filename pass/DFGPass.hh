#pragma once

#include "SubPass.hh"
#include "DAG.hh"

namespace cm {

struct DFGPass : public SubPass, DAG {
  DFGPass(bool onlyForLS) : DAG("DFG", onlyForLS) {
  }

  void runSubPass(llvm::Function& F) override {
    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      edges.clear();
      nodes.clear();
      critcal_edges.clear();
      for (auto BB = F.begin(), BEnd = F.end(); BB != BEnd; ++BB) {
        llvm::BasicBlock *curBB = &*BB;
        for (auto II = curBB->begin(), IEnd = curBB->end(); II != IEnd; ++II) {
          llvm::Instruction *curII = &*II;
          switch (curII->getOpcode()) {
          // special process for load/store due to their operations of memory
          case llvm::Instruction::Load: {
            llvm::LoadInst *loadInst = llvm::dyn_cast<llvm::LoadInst>(curII);
            llvm::Value *loadValPtr = loadInst->getPointerOperand();
            if (onlyForLS) {
              edges[loadValPtr].push_back(curII);
              nodes.insert(curII);
            } else {
              critcal_edges.insert(std::make_pair(loadValPtr, curII));
            }
            break;
          }
          case llvm::Instruction::Store: {
            llvm::StoreInst *storeInst = llvm::dyn_cast<llvm::StoreInst>(curII);
            llvm::Value *storeValPtr = storeInst->getPointerOperand();
            llvm::Value *storeVal = storeInst->getValueOperand();
            if (onlyForLS) {
              edges[storeVal].push_back(curII);
              edges[storeValPtr].push_back(curII);
              nodes.insert(curII);
            } else {
              critcal_edges.insert(std::make_pair(storeVal, curII));
              critcal_edges.insert(std::make_pair(storeValPtr, curII));
            }
            break;
          }
          default: {
            for (auto op = curII->op_begin(), opEnd = curII->op_end(); op != opEnd; ++op) {
              if (llvm::dyn_cast<llvm::Instruction>(*op)) {
                if (onlyForLS) {
                  edges[op->get()].push_back(curII);
                } else {
                  critcal_edges.insert(std::make_pair(op->get(), curII));
                }
              }
            }
            break;
          }
          }
        }
      }
      if (onlyForLS) {
        genLoadStoreEdges();
      } else {
        for (auto edge : critcal_edges) {
          nodes.insert(edge.first);
          nodes.insert(edge.second);
        }
      }
      printDAG(F);
    }
    return;
  }
};

} // namespace cm
