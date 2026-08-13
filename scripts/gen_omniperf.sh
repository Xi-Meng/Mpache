# 生成profile,analyze,对比文件
#!/bin/bash

export APP="needle"
mkdir ./comp/${APP}

export TYPE="cache"
omniperf profile -n ${APP}_${TYPE} -- ./bin/$APP/${APP}_${TYPE}
omniperf analyze -p workloads/${APP}_${TYPE}/mi100/ > ./comp/${APP}/${APP}_${TYPE}.txt

export TYPE="bypass"
omniperf profile -n ${APP}_${TYPE} -- ./bin/$APP/${APP}_${TYPE}
omniperf analyze -p workloads/${APP}_${TYPE}/mi100/ > ./comp/${APP}/${APP}_${TYPE}.txt

export TYPE1="cache"
export TYPE2="bypass"
omniperf analyze -p workloads/${APP}_${TYPE1}/mi100/ -p workloads/${APP}_${TYPE2}/mi100/ > ./comp/${APP}/${APP}_comp.txt
