# Instruction Level Cache Management

## Prepare Env

- Create container by using prebuild image 
```
docker run -v ~/:/workspace --name rocm_workspace -u root -itd --device=/dev/kfd --device=/dev/dri --security-opt seccomp=unconfined --group-add video rocm/rocm-terminal:5.7
```
- Attach to the container
```
docker exec -it rocm_workspace /bin/bash
```
- Set env `CM_PROJ_PATH` to the absolute path of this repo

## Build 

To build this project, you need to use a newer version `cmake` from https://cmake.org/download/.

```
. scripts/build.sh
```

After building, you can test the effect of pass by running

```
./bin/floyd_warshall && ./bin/INJECT_floyd_warshall
```

You are expected to see obvious difference of runtime like below

```
189.839 ms
232.968 ms
```

## Disassemble
Using `roc-obj` (https://github.com/ROCm/HIP/blob/main/docs/markdown/obj_tooling.md)

```
roc-obj -o tmp/ISA -d ./bin/floyd_warshall
```

## Generate IR/ISA (deprecated)
> We find that IR/ISA generated in this way is far different from that disassembled from binary. So ISA disassembled from binary or viewing IR generated from pass are recommended.

```
# IR (result saved to tmp/floyd_warshall.ll)
cmake --build build -t floyd_warshall.ll
# ISA (result saved to tmp/floyd_warshall.isa)
cmake --build build -t floyd_warshall.isa
```
