# 生成指定APP的cache和bypass的executable file
#!/bin/bash
rm -rf build
export APP_NAME="spmv_my"
export SOURCE_CPP="ON"
export SEARCH="%17"

export INJECT_BIT="cache"
export BYPASS_ENABLE="OFF"
export IR_ENABLE="ON"
mkdir ./system/group/${APP_NAME}
cmake -S . -B build/$APP_NAME/$INJECT_BIT
cmake --build build/$APP_NAME/$INJECT_BIT

# export CACHE="cache"
# ./bin/$APP_NAME/${APP_NAME}_${CACHE}


rm -rf build
export INJECT_BIT="l1bypass"
export BYPASS_ENABLE="ON"
export IR_ENABLE="OFF"
cmake -S . -B build/$APP_NAME/$INJECT_BIT
cmake --build build/$APP_NAME/$INJECT_BIT

# # 反汇编生成ISA
# mkdir ./tmp/ISA/${APP_NAME}0.9077579
# export TYPE="cache"
# roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}
# export TYPE="bypass"
# roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}

# export BYPASS="bypass"
# ./bin/$APP_NAME/${APP_NAME}_${BYPASS}

# 初步测试时间
export CACHE="cache"
export BYPASS=$INJECT_BIT
./bin/$APP_NAME/${APP_NAME}_${CACHE} && ./bin/$APP_NAME/${APP_NAME}_${BYPASS}