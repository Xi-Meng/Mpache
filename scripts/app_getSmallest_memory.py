import subprocess
import time
import os
import pandas as pd


appName = os.environ['APP_NAME']

def mean_csv(csv_path):
    df = pd.read_csv(csv_path)
    average_grbm_count = df['GRBM_COUNT'].mean()
    average_memUnitStalled = df['MemUnitStalled'].mean()
    average_memUnitBusy = df['MemUnitBusy'].mean()
    average_L2CacheHit = df['L2CacheHit'].mean()
    average_TCC_HIT_sum = df['TCC_HIT_sum'].mean()
    average_TCC_MISS_sum = df['TCC_MISS_sum'].mean()
    average_TCP_TCP_TA_DATA_STALL_CYCLES_sum = df['TCP_TCP_TA_DATA_STALL_CYCLES_sum'].mean()
    average_GPUBusy = df['GPUBusy'].mean()
    return average_grbm_count, average_memUnitStalled, average_memUnitBusy, average_L2CacheHit, average_TCC_HIT_sum, average_TCC_MISS_sum, average_TCP_TCP_TA_DATA_STALL_CYCLES_sum, average_GPUBusy


# 指定你的文件目录
sssp_dir = f"./bin/{appName}/"
# csv_path = f"./IPC/tmp/{appName}.csv"
metric_path = f"./IPC/metrics_memory.txt"
sssp_brute_result = f"./IPC/{appName}/{appName}_brute_memory.csv"
iteration = 10


with open(sssp_brute_result, 'a') as f:
    f.write(f'k,filename,memUnitStalled_average,memUnitBusy_average,grbm_count_average,L2CacheHit_average,TCC_HIT_sum_average,TCC_MISS_sum_average,TCP_TCP_TA_DATA_STALL_CYCLES_sum_average, GPUBusy_average\n')
# 遍历文件目录下所有的文件
k = 0
for filename in os.listdir(sssp_dir):
    # print(filename)
    # if filename != "sssp_000000000":
    #     continue
    # if filename.startswith("sssp_"):
    # csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
    csv_path_k = f"./IPC/tmp/{filename}.csv"
    cmd = f"rocprof -i {metric_path} -o {csv_path_k} {sssp_dir}{filename}"
    print(cmd)
    print("%s : %s\n" % (k, filename))
    grbm_count_sum, memUnitStalled_sum, memUnitBusy_sum, L2CacheHit_sum, TCC_HIT_sum_sum, TCC_MISS_sum_sum, TCP_TCP_TA_DATA_STALL_CYCLES_sum_sum, GPUBusy_sum = 0, 0, 0, 0, 0, 0, 0, 0
    # 对于每个文件，运行指定命令多次
    for i in range(iteration):
        result = subprocess.run(cmd, shell=True) # 阻塞运行？？
        if result.returncode == 0:
            print("success\n")
        else:
            print("failed\n")
        grbm_count, memUnitStalled, memUnitBusy, L2CacheHit, TCC_HIT_sum, TCC_MISS_sum, TCP_TCP_TA_DATA_STALL_CYCLES_sum, GPUBusy = mean_csv(csv_path_k)
        grbm_count_sum += grbm_count
        memUnitStalled_sum += memUnitStalled
        memUnitBusy_sum += memUnitBusy
        L2CacheHit_sum += L2CacheHit
        TCC_HIT_sum_sum += TCC_HIT_sum
        TCC_MISS_sum_sum += TCC_MISS_sum
        TCP_TCP_TA_DATA_STALL_CYCLES_sum_sum += TCP_TCP_TA_DATA_STALL_CYCLES_sum
        GPUBusy_sum += GPUBusy
        # # 为避免命令快速连续运行，你可能希望在每次运行间有一定间隔
        # time.sleep(1)
    grbm_count_average = grbm_count_sum / iteration
    memUnitStalled_average = memUnitStalled_sum / iteration
    memUnitBusy_average = memUnitBusy_sum / iteration
    L2CacheHit_average = L2CacheHit_sum / iteration
    TCC_HIT_sum_average = TCC_HIT_sum_sum / iteration
    TCC_MISS_sum_average = TCC_MISS_sum_sum / iteration
    TCP_TCP_TA_DATA_STALL_CYCLES_sum_average = TCP_TCP_TA_DATA_STALL_CYCLES_sum_sum / iteration
    GPUBusy_average = GPUBusy_sum / iteration
    # 将结果写入 sssp_brute_result 文件
    with open(sssp_brute_result, 'a') as f:
        f.write(f'{k},{filename},{memUnitStalled_average},{memUnitBusy_average},{grbm_count_average},{L2CacheHit_average},{TCC_HIT_sum_average},{TCC_MISS_sum_average},{TCP_TCP_TA_DATA_STALL_CYCLES_sum_average}, {GPUBusy_average}\n')
    k += 1


