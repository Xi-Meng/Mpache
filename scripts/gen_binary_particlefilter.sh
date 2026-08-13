# 生成指定APP的cache和bypass的executable file
#!/bin/bash
rm -rf build
export APP_NAME="particlefilter_float"
export SOURCE_CPP="OFF"
export SEARCH="%17"

export INJECT_BIT="cache"
export BYPASS_ENABLE="OFF"
export IR_ENABLE="ON"
cmake -S . -B build/$APP_NAME/$INJECT_BIT
cmake --build build/$APP_NAME/$INJECT_BIT

rm -rf build
export INJECT_BIT="bypass"
export BYPASS_ENABLE="ON"
export IR_ENABLE="OFF"
cmake -S . -B build/$APP_NAME/$INJECT_BIT
cmake --build build/$APP_NAME/$INJECT_BIT

# 反汇编生成ISA
mkdir ./tmp/ISA/${APP_NAME}
export TYPE="cache"
roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}
export TYPE="bypass"
roc-obj -o ./tmp/ISA/$APP_NAME/$TYPE -d ./bin/$APP_NAME/${APP_NAME}_${TYPE}

# 初步测试时间
export CACHE="cache"
export BYPASS="bypass"
./bin/$APP_NAME/${APP_NAME}_${CACHE} && ./bin/$APP_NAME/${APP_NAME}_${BYPASS}