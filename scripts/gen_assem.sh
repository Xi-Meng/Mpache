# 汇编链接，将所有的global load和store加上glc
#!/bin/bash
cd /workspace/Inst-level-cache-management
export ROCM_PATH=/opt/rocm
export APP="needle"
export ISA="gfx1030"
mkdir -p ./assem/${APP}
cd ./assem/${APP}
$ROCM_PATH/hip/bin/hipcc -c -S --cuda-host-only -target x86_64-linux-gnu -o ${APP}_host.s ../../src/${APP}.hip
$ROCM_PATH/hip/bin/hipcc -c -S --cuda-device-only --offload-arch=${ISA} ../../src/${APP}.hip

cd /workspace/Inst-level-cache-management
python3 ./scripts/modify_device.py

cd ./assem/${APP}
$ROCM_PATH/hip/bin/hipcc -c ${APP}_host.s -o ${APP}_host.o
$ROCM_PATH/hip/../llvm/bin/clang -target amdgcn-amd-amdhsa -mcpu=${ISA} ${APP}-hip-amdgcn-amd-amdhsa-${ISA}.s -o ${APP}-hip-amdgcn-amd-amdhsa-${ISA}.o
$ROCM_PATH/llvm/bin/clang-offload-bundler -type=o -bundle-align=4096 -targets=host-x86_64-unknown-linux,hip-amdgcn-amd-amdhsa-${ISA} -inputs=/dev/null,${APP}-hip-amdgcn-amd-amdhsa-${ISA}.o -outputs=offload_bundle.hipfb
$ROCM_PATH/llvm/bin/llvm-mc -triple x86_64-unknown-linux-gnu ../hip_obj_gen.mcin -o ${APP}_device.o --filetype=obj

# $ROCM_PATH/hip/bin/hipcc ../../include/${APP}/*.c ../../include/${APP}/*.cc ${APP}_host.o ${APP}_device.o -o ${APP}_bypass
$ROCM_PATH/hip/bin/hipcc ${APP}_host.o ${APP}_device.o -o ${APP}_bypass
cp ${APP}_bypass ../../bin/${APP}/
cd /workspace/Inst-level-cache-management/

# 生成cache的excutable file
rm -rf build
export INJECT_BIT="cache"
export BYPASS_ENABLE="OFF"
cmake -S . -B build/$APP_NAME/$INJECT_BIT
cmake --build build/$APP_NAME/$INJECT_BIT


# 反汇编生成ISA
export TYPE="cache"
mkdir ./tmp/ISA/${APP_NAME}
roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}
export TYPE="bypass"
roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}

# 初步测试时间
export CACHE="cache"
export BYPASS="bypass"
./bin/$APP_NAME/${APP_NAME}_${CACHE} && ./bin/$APP_NAME/${APP_NAME}_${BYPASS}