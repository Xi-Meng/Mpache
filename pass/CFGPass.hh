#pragma once

#include "SubPass.hh"
#include "DAG.hh"

namespace cm {

struct CFGPass : public SubPass, DAG {

  CFGPass(bool onlyForLS) : DAG("CFG", onlyForLS) {
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
          auto next = II;
          next++;
          if (next != IEnd) {
            if (onlyForLS) {
              edges[curII].push_back(&*next);
              if (llvm::isa<llvm::LoadInst>(curII) || llvm::isa<llvm::StoreInst>(curII)) {
                nodes.insert(curII);
              }
            } else {
              critcal_edges.insert(std::make_pair(curII, &*next));
            }
          }
        }
        auto terminator = curBB->getTerminator();
        for (auto sucBB : llvm::successors(curBB)) {
          auto first = &*(sucBB->begin());
          if (onlyForLS) {
            edges[terminator].push_back(first);
          } else {
            critcal_edges.insert(std::make_pair(terminator, first));
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