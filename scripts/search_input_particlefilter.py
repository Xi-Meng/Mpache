import subprocess
import time
import os
import pandas as pd
import re
import numpy as np

appName = os.environ['APP_NAME']
pattern = "(.*) [mu]s"

# def mean_csv(csv_path):
#     df = pd.read_csv(csv_path)
#     average_grbm_count = df['GRBM_COUNT'].mean()
#     # print("平均 GRBM_COUNT 值是 :", average_grbm_count)
#     return average_grbm_count


# 指定你的文件目录
sssp_dir = f"./bin/{appName}/"
# csv_path = f"./IPC/tmp/{appName}.csv"
# metric_path = f"./IPC/metrics_GRBM_COUNT.txt"
sssp_brute_result = f"./IPC/{appName}/{appName}_getSmallest_time.csv"
iteration = 5

def run(x, y, z, np):
    # 遍历文件目录下所有的文件
    k = 0
    cache_time = 0
    bypass_time = 0
    for filename in os.listdir(sssp_dir):
        if ((not filename.endswith("cache")) and (not filename.endswith("bypass"))):
            continue
        # print(filename)
        # if filename != "sssp_000000000":
        #     continue
        # if filename.startswith("sssp_"):
        # csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
        cmd = f"{sssp_dir}{filename} -x {x} -y {y} -z {z} -np {np}"
        # print(cmd)
        # print("%s : %s\n" % (k, filename))
        # grbm_count_sum = 0
        time = 0
        # 对于每个文件，运行指定命令多次
        for i in range(iteration):
            result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
            if result.returncode == 0:
                # print("success\n")
                pass
            else:
                print("failed\n")
            
            lines = result.stdout.decode().split('\n')  # 分割字符串成多行
            # print(lines)
            last_line = lines[-2]  # 取最后一行, ms后面一定要有"\n",最后一个数组是空
            # print(last_line)
            time += eval(re.match(pattern, last_line).group(1))
            # grbm_count = mean_csv(csv_path_k)
            # grbm_count_sum += grbm_count
            # # 为避免命令快速连续运行，你可能希望在每次运行间有一定间隔
            # time.sleep(1)
        # grbm_count_average = grbm_count_sum / iteration
        time_average = time / iteration

        # # 将结果写入 sssp_brute_result 文件
        # with open(sssp_brute_result, 'a') as f:
        #     f.write(f'{k},{filename},{time_average}\n')

        # k += 1
        if filename.endswith("cache"):
            cache_time = time_average

        if filename.endswith("bypass"):
            bypass_time = time_average

    # 将结果写入 sssp_brute_result 文件
    improve = 100 * (cache_time - bypass_time) / cache_time
    with open(sssp_brute_result, 'a') as f:
        f.write(f'{cache_time},{bypass_time},{improve}\n')
     # k += 1



# lists = [128,256,1024,2048,4096] #,8192,16384,32768,65536]
# # for width in range()
# np = 6000
# for z in range(10,110,10):
#     for x in lists:
#         for y in lists:
#             with open(sssp_brute_result, 'a') as f:
#                 f.write(f'x: {x}, y: {y}, z: {z}, np: {np}, ')
#                 print(f"x: {x}, y: {y}, z: {z}, np: {np}\n")
            
#             run(x, y, z, np)

np = 6000
loop = 1
cnt = 0
x = 64
y = 64
while(cnt < loop):
    cnt+=1

    for z in range(10,20,10):
        for np in range(40000,60000,1000):
            with open(sssp_brute_result, 'a') as f:
                f.write(f'x: {x}, y: {y}, z: {z}, np: {np}, ')
                print(f"x: {x}, y: {y}, z: {z}, np: {np}\n")
            run(x, y, z, np)

    x*=2
    y*=2   
        


