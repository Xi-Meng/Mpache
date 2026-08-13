# First, hipPass switch to 'InjectPass_search.hh' by hand
import os
import subprocess
import re

# cols
load_all="%23 %29 %35 %41 %47 %53 %59 %65 %70 %80 %88 %93 %100 %107 %114 %121 %128 %135 %142 %147 %154 %161 %168 %175 %182 %189 %195 %203 %209 %215 %221 %227 %233 %239 %245 %251 %255 %261 %267 %273 %279 %285 %291 %297 %306 %312 %318 %324 %330 %336 %342 %348 %354 %358 %364 %370 %376 %382 %388 %394 %400 %409 %415 %421 %427 %433 %439 %445 %451 %457 %461 %467 %473 %479 %485 %491 %497 %503 %512 %518 %524 %530 %536 %542 %548 %554 %560 %564 %570 %576 %582 %588 %594 %600 %606 %615 %621 %627 %633 %639 %645 %651 %657 %663 %667 %673 %679 %685 %691 %697 %703 %709 %718 %724 %730 %736 %742 %748 %754 %760 %766 %770 %776 %782 %788 %794 %800 %806 %812 %821 %827 %833 %839 %845 %851 %857 %863 %869 %873 %879 %885 %891 %897 %903 %909 %915"
app_name = "convolutionSeparable_hip"
os.environ['SOURCE_CPP'] = "OFF"
iteration = 1

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
## 运行-----------------------------------------
cache_time = 0
cmd = f"./bin/{app_name}/{app_name}_{load} 8192 8192 100"
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
    cmd = f"./bin/{app_name}/{app_name}_{load} 8192 8192 100"
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
        f.write(f'{k},{percent_load},{time},{improve}')
        if (improve > 1):
            f.write(f', good')
        f.write(f'\n')
    k+=1