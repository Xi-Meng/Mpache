import subprocess
import time
import os
import pandas as pd


appName = "convolutionSeparable_hip"
metrics = "GRBM_COUNT,MemUnitBusy,GL2C_HIT_sum,GL2C_MISS_sum,L2CacheHit"
kernelName = 'conv_rows'

def mean_csv(csv_path):
    df = pd.read_csv(csv_path)
    # 筛选kernelName对应行的列的平均值
    df = df[df['KernelName'].str.startswith(kernelName)]
    # print(df)
    average_1 = df['GRBM_COUNT'].mean()
    average_2 = df['MemUnitBusy'].mean()
    average_3 = df['GL2C_HIT_sum'].mean()
    average_4 = df['GL2C_MISS_sum'].mean()
    average_5 = df['L2CacheHit'].mean()
    return average_1, average_2, average_3, average_4, average_5


# 指定你的文件目录
sssp_dir = f"./bin/{appName}/"
# csv_path = f"./IPC/tmp/{appName}.csv"
metric_path = f"./metrics/cache.txt"
sssp_brute_result = f"./IPC/{appName}/{appName}_cache_metrics.csv"
iteration = 1


with open(sssp_brute_result, 'a') as f:
    f.write(f'k,filename,kernelName,{metrics}\n')
# 遍历文件目录下所有的文件
k = 0
for filename in os.listdir(sssp_dir):
    if ((not filename.endswith("cache")) and (not filename.endswith("bypass"))):
            continue
    if (filename.endswith("store_bypass")): # 过滤到store_bypass的
        continue
    # print(filename)
    # if filename != "sssp_000000000":
    #     continue
    # if filename.startswith("sssp_"):
    # csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
    csv_path_k = f"./IPC/tmp/{filename}.csv"
    cmd = f"rocprof -i {metric_path} -o {csv_path_k} {sssp_dir}{filename}"
    # print(cmd)
    print("%s : %s\n" % (k, filename))
    sum_1, sum_2, sum_3, sum_4, sum_5 = 0, 0, 0, 0, 0
    # 对于每个文件，运行指定命令多次
    for i in range(iteration):
        result = subprocess.run(cmd, shell=True) # 阻塞运行？？
        if result.returncode == 0:
            print("success\n")
        else:
            print("failed\n")
        once_1, once_2, once_3, once_4, once_5 = mean_csv(csv_path_k)
        sum_1 += once_1
        sum_2 += once_2
        sum_3 += once_3
        sum_4 += once_4
        sum_5 += once_5
        # # 为避免命令快速连续运行，你可能希望在每次运行间有一定间隔
        # time.sleep(1)
    aver_1 = sum_1 / iteration
    aver_2 = sum_2 / iteration
    aver_3 = sum_3 / iteration
    aver_4 = sum_4 / iteration
    aver_5 = sum_5 / iteration
    # 将结果写入 sssp_brute_result 文件
    with open(sssp_brute_result, 'a') as f:
        f.write(f'{k},{filename},{kernelName},{aver_1},{aver_2},{aver_3},{aver_4},{aver_5}\n')
    k += 1


