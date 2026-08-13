import subprocess
import time
import os
import pandas as pd


appName = os.environ['APP_NAME']

def mean_csv(csv_path):
    df = pd.read_csv(csv_path)
    average_grbm_count = df['GRBM_COUNT'].mean() - df['SQ_WAIT_INST_LDS'].mean() - df['SQ_ACTIVE_INST_VALU'].mean() * 4 - df['SQ_INST_CYCLES_SALU'].mean() - df['SQ_LDS_BANK_CONFLICT'].mean()
    # print("平均 GRBM_COUNT 值是 :", average_grbm_count)
    return average_grbm_count


# 指定你的文件目录
sssp_dir = f"./bin/{appName}/"
csv_path = f"./IPC/tmp/{appName}.csv"
metric_path = f"./IPC/metrics.txt"
sssp_brute_result = f"./IPC/{appName}/{appName}_brute_LS.csv"
iteration = 10



# 遍历文件目录下所有的文件
k = 0
for filename in os.listdir(sssp_dir):
    # print(filename)
    # if filename != "sssp_000000000":
    #     continue
    # if filename.startswith("sssp_"):
    csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
    cmd = f"rocprof -i {metric_path} -o {csv_path_k} {sssp_dir}{filename}"
    print(cmd)
    print("%s : %s\n" % (k, filename))
    grbm_count_sum = 0
    # 对于每个文件，运行指定命令多次
    for i in range(iteration):
        result = subprocess.run(cmd, shell=True) # 阻塞运行？？
        if result.returncode == 0:
            print("success\n")
        else:
            print("failed\n")
        grbm_count = mean_csv(csv_path_k)
        grbm_count_sum += grbm_count
        # # 为避免命令快速连续运行，你可能希望在每次运行间有一定间隔
        # time.sleep(1)
    grbm_count_average = grbm_count_sum / iteration

    # 将结果写入 sssp_brute_result 文件
    with open(sssp_brute_result, 'a') as f:
        f.write(f'{k},{filename},{grbm_count_average}\n')
    k += 1


