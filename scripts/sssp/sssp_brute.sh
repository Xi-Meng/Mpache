#!/bin/bash
# 最大的并行任务数量
max_jobs=10

# 已启动的任务数量
job_count=0

# 创建一个数组包含0，1，2
arr=(0 1 2)

# 循环3的9次方（即19683）次来生成INJECT_BIT
for ((k=0; k<19683; k++)); do
  # 如果k小于1483，直接跳过
  if ((k < 13934)); then
    continue
  fi
  # 每次循环都生成一个新的INJECT_BIT
  BIT=""

  # 遍历每一位Bit
  temp=$k
  for((i=0; i<9; i++)); do
    # 这里用到了模运算和整数除法运算来获取每一位的值
    index=$(($temp % 3))
    temp=$(($temp / 3))

    # 添加到INJECT_BIT字符串
    BIT+="${arr[$index]}"
  done

  echo "INJECT_BIT is $BIT for iteration $k"
  # 设置环境变量INJECT_BIT
  export INJECT_BIT=$BIT

#   # 运行 cmake 命令
#   cmake -S . -B build -D TARGET_NAME=$INJECT_BIT
#   cmake --build build
  {
    nohup cmake -S . -B build -D TARGET_NAME=$INJECT_BIT > /dev/null 2>&1
    nohup cmake --build build -j$(nproc) > /dev/null 2>&1
  } &

  ((job_count++))
  
  if (( job_count % max_jobs == 0 )); then
    wait
  fi

done

 # 如果存在未完成的任务，则等待它们完成
 wait