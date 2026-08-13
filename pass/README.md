# Adding a Pass in LLVM

To add a new pass in LLVM we can references following docs:
- https://llvm.org/docs/WritingAnLLVMPass.html
- https://llvm.org/docs/NewPassManager.html
- https://llvm.org/docs/WritingAnLLVMNewPMPass.html

For convenient, we don't want to rebuild LLVM when adding a new pass. We can register pass as a plugin in Clang using `-fpass-plugin=/path-to-pass.so`.

# CFG : PASS for generating control flow graph

In this pass, the CFG of each function (in the format of `.dot`) will be generated in `tmp/CFG/xxx` which will be print during the compilation. The control flow graph will characterize the dependency relationship of each instructions speicially for `LOAD` and `STORE` instructions.

# DFG : PASS for generating data flow graph

> reference [llvm_DFGPass](https://github.com/bin2415/llvm_DFGPass)

In this pass, the DFG of each function (in the format of `.dot`) will be generated in `tmp/DFG/xxx` which will be print during the compilation. The data flow graph will characterize the dependency relationship of each variable speicially for `LOAD` and `STORE` instructions.

# INJECT: PASS for setting glc slc and dlc

## Setting glc slc and dlc througth Pass

It seems that we can't operate glc,dlc and slc bit straightforward in LLVM IR. Instead, we can set glc slc dlc through volatile or nontemporal attribute(https://www.llvm.org/docs/AMDGPUUsage.html#amdgpu-amdhsa-memory-model-code-sequences-gfx10-gfx11-table). 

The following table is a combinatin effect of `VOLATILE` and `NONTEMPORAL` (L:Load S:Store).

gfx10-11
|  |  |  |  |  |
|-|-|-|-|-|
|VOLATILE    |    0  |   0   |   1   |   1  |
|NONTEMPORAL |    0  |   1   |   0   |   1  |
|glc(L/S)    |   0/0 |  0/1  |  1/0  |  1/0 |
|dlc(L/S)    |   0/0 |  0/0  |  1/0  |  1/0 |
|slc(L/S)    |   0/0 |  1/1  |  0/0  |  0/0 |

gfx6-9
|  |  |  |  |  |
|-|-|-|-|-|
|VOLATILE    |    0  |   0   |   1   |   1  |
|NONTEMPORAL |    0  |   1   |   0   |   1  |
|glc(L/S)    |   0/0 |  1/1  |  1/0  |  1/0 |
|slc(L/S)    |   0/0 |  1/1  |  0/0  |  0/0 |


## IR 

In the pass, we print IR to `tmp/IR/xxx.ll` where the name of file is print to std like this (the second line)
```
[ 50%] Building HIP object src/CMakeFiles/INJECT_floyd_warshall.dir/floyd_warshall.hip.o
/guoty/Inst-level-cache-management/build/src/../../tmp/IR/_Z21floyd_warshall_kernelPjS_jj.ll
[100%] Linking HIP executable /guoty/Inst-level-cache-management/bin/INJECT_floyd_warshall
[100%] Built target INJECT_floyd_warshall
```