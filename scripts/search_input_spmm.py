import subprocess
import time
import os
import pandas as pd
import re
import numpy as np

# appName = os.environ['APP_NAME']
appName = "spmm_my"
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

def run(mat_col):
    # 遍历文件目录下所有的文件
    k = 0
    cache_time = 0
    bypass_time = 0
    for filename in os.listdir(sssp_dir):
        # print(filename)
        # if filename != "sssp_000000000":
        #     continue
        # if filename.startswith("sssp_"):
        # csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
        cmd = f"{sssp_dir}{filename} {mat_col}"
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


loop = 4
cnt = 0
row = 256
# sparse = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
while(cnt < loop):
    cnt += 1
    row *= 2
    col = row
    # print(row)
    for mat_col in range(2, 11):
        for spa in np.arange(0.0001, 0.024, 0.0001):
            element = round(row * col * spa)
            # with open(sssp_brute_result, 'a') as f:
                # f.write(f'稀疏度：{spa}\n')
                # f.write(f'row*col: {row}*{col}, element: {element}, sparse: {spa}, ')
            # 生成数据
            cmd = f"python3 /workspace/Inst-level-cache-management/include/spmm_my/data/data_gen.py  --rows {row} --cols {col} --sparse {spa}"
            result = subprocess.run(cmd, shell=True, capture_output=True)
            if result.returncode == 0:
                pass
                print(f"create data over  --rows {row} --cols {col} --elements {element} --sparse {spa}\n")
            else:
                print("failed\n")

            # 当前数据下的运行时间
            
            with open(sssp_brute_result, 'a') as f:
                f.write(f'row*col: {row}*{col}, element: {element}, sparse: {spa}, ')
                f.write(f'mat_col: {mat_col}, ')
            run(mat_col)


