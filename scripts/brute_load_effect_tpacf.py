# First, hipPass switch to 'InjectPass_search.hh' by hand
import os
import subprocess
import re

load_all="%100 %102 %104 %127 %128 %129"
app_name = "tpacf"
os.environ['SOURCE_CPP'] = "ON"
iteration = 10

search_result = f"./IPC/{app_name}/{app_name}_load_effect.csv"
pattern = "(.*) [mu]s"


# 删除lib
cmd = f"rm -rf ./lib/{app_name} && rm -rf build"
result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
if result.returncode == 0:
    # print("success\n")
    pass
else:
    print("rm failed\n")
# 编译cache并计算cache的时间
print("cache time-------------------------------")
load = "cache"
os.environ['INJECT_BIT'] = load
os.environ['BYPASS_ENABLE'] = "OFF"
os.environ['APP_NAME'] = app_name
os.environ['IR_ENABLE'] = "ON"
## 编译----------------------------------------
# cmd = f"cmake -S . -B build/{app_name}/{load}"
# try:
#     subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
# except subprocess.CalledProcessError as e:
#     print(f"CMake configuration failed for TARGET_NAME={load}")
#     print("Output:\n", e.stdout.decode())

# cmd = f"cmake --build build/{app_name}/{load} -j64"
# try:
#     subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
# except subprocess.CalledProcessError as e:
#     print("CMake build failed!")
#     print("Output:\n", e.stdout.decode())
## 运行-----------------------------------------
cache_time = 0
cmd = f"./bin/{app_name}/{app_name}_{load} -i /workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Datapnts.1,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.1,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.2,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.3,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.4,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.5,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.6,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.7,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.8,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.9,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.10,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.11,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.12,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.13,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.14,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.15,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.16,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.17,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.18,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.19,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.20,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.21,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.22,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.23,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.24,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.25,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.26,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.27,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.28,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.29,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.30,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.31,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.32,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.33,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.34,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.35,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.36,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.37,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.38,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.39,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.40,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.41,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.42,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.43,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.44,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.45,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.46,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.47,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.48,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.49,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.50,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.51,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.52,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.53,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.54,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.55,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.56,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.57,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.58,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.59,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.60,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.61,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.62,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.63,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.64,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.65,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.66,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.67,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.68,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.69,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.70,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.71,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.72,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.73,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.74,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.75,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.76,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.77,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.78,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.79,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.80,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.81,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.82,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.83,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.84,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.85,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.86,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.87,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.88,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.89,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.90,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.91,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.92,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.93,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.94,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.95,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.96,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.97,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.98,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.99,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.100"
for i in range(iteration):
    result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
    if result.returncode == 0:
        # print("success\n")
        pass
    else:
        print("failed\n")
    lines = result.stdout.decode().split('\n')  # 分割字符串成多行
    last_line = lines[-2]  # 取最后一行, ms后面一定要有"\n",最后一个数组是空
    cache_time += eval(re.match(pattern, last_line).group(1))
cache_time /= iteration

with open(search_result, 'a') as f:
        f.write(f'0,cache_time,{cache_time},0\n')

# 单个遍历所有load的bypass效果
print("bypass time-------------------------------")
loads = load_all.split(" ")
# print(loads)
k = 1
for percent_load in loads:
    load = percent_load.split('%')[-1]
    print(load,"-----------------------")
    # 设置当前搜索的load
    os.environ['SEARCH'] = percent_load
    os.environ['INJECT_BIT'] = load
    # os.environ['SOURCE_CPP'] = "OFF"

    os.environ['BYPASS_ENABLE'] = "ON"
    os.environ['APP_NAME'] = app_name
    os.environ['IR_ENABLE'] = "OFF"
    # 编译--------------------------------------
    cmd = f"cmake -S . -B build/{app_name}/{load}"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={load}")
        print("Output:\n", e.stdout.decode())

    cmd = f"cmake --build build/{app_name}/{load} -j64"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())

    # 运行--------------------------------------
    time = 0
    cmd = f"./bin/{app_name}/{app_name}_{load} -i /workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Datapnts.1,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.1,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.2,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.3,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.4,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.5,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.6,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.7,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.8,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.9,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.10,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.11,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.12,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.13,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.14,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.15,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.16,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.17,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.18,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.19,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.20,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.21,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.22,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.23,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.24,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.25,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.26,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.27,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.28,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.29,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.30,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.31,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.32,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.33,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.34,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.35,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.36,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.37,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.38,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.39,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.40,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.41,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.42,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.43,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.44,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.45,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.46,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.47,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.48,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.49,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.50,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.51,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.52,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.53,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.54,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.55,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.56,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.57,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.58,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.59,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.60,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.61,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.62,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.63,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.64,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.65,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.66,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.67,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.68,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.69,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.70,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.71,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.72,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.73,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.74,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.75,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.76,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.77,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.78,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.79,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.80,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.81,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.82,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.83,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.84,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.85,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.86,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.87,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.88,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.89,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.90,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.91,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.92,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.93,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.94,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.95,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.96,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.97,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.98,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.99,/workspace/Inst-level-cache-management/include/tpacf/data/medium/input/Randompnts.100"
    for i in range(iteration):
        result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
        if result.returncode == 0:
            # print("success\n")
            pass
        else:
            print("failed\n")
        lines = result.stdout.decode().split('\n')  # 分割字符串成多行
        last_line = lines[-2]  # 取最后一行, ms后面一定要有"\n",最后一个数组是空
        time += eval(re.match(pattern, last_line).group(1))
    time /= iteration
    improve = 100 * (cache_time - time) / cache_time
    with open(search_result, 'a') as f:
        f.write(f'{k},{percent_load},{time},{improve}\n')
    k+=1