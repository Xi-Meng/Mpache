#pragma once

#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>
namespace cm {

struct SubPass {
  virtual void runSubPass(llvm::Function&) = 0;
};

} // namespace cm
