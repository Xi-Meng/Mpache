import subprocess
import time
import os
import pandas as pd
import re

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
iteration = 10



# 遍历文件目录下所有的文件
k = 0
for filename in os.listdir(sssp_dir):
    if ((not filename.endswith("cache")) and (not filename.endswith("bypass"))):
        continue
    # print(filename)
    # if filename != "sssp_000000000":
    #     continue
    # if filename.startswith("sssp_"):
    # csv_path_k = f"./IPC/tmp/{appName}_{k}.csv"
    cmd = f"{sssp_dir}{filename}"
    # print(cmd)
    print("%s : %s\n" % (k, filename))
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

    # 将结果写入 sssp_brute_result 文件
    with open(sssp_brute_result, 'a') as f:
        f.write(f'{k},{filename},{time_average}\n')
    k += 1


