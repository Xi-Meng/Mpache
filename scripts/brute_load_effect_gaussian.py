# First, hipPass switch to 'InjectPass_search.hh' by hand
import os
import subprocess
import re

load_all="%35 %41 %46 %51 %54 %58"
app_name = "gaussian"
os.environ['SOURCE_CPP'] = "OFF"
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
cmd = f"./bin/{app_name}/{app_name}_{load} -s 256"
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
    cmd = f"./bin/{app_name}/{app_name}_{load} -s 256"
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