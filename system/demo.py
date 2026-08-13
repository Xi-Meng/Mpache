# groups = []
# loads = []
# with open('/workspace/Inst-level-cache-management/system/group/spmv_my.txt', 'r') as file:
#     for line in file:
#         line_values = line.split()
#         groups.append(line_values)
#         for value in line_values:
#             loads.append([value])
# print('Groups:', groups)
# print('Loads:', loads)

import os
import subprocess
import re

pattern = "(.*) [mu]s"
iteration = 1
app_name = "spmv_my"
os.environ['KERNEL'] = "_Z8spmv_jdsPfPKfPKiS3_S1_S3_i"
os.environ['SOURCE_CPP'] = "ON"
## env相关信息
os.environ['APP_NAME'] = app_name

def offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time): # storemode: int, 前三个: str
    print("search: %s, mode: %s" % (strSearch, strMode))
    inject_bit = strSearch
    if len(strSearch) > 50:
        inject_bit = "long_goups_%d" % (len(strSearch))
    print("inject_bit: %s" % inject_bit )

    os.environ['SEARCH'] = strSearch
    os.environ['MODES'] = strMode
    os.environ['STOREMODE'] = str(storemode)
    os.environ['STOREBYPASS'] = storebypass
    # 编译--------------------------------------
    os.environ['INJECT_BIT'] = inject_bit
    os.environ['BYPASS_ENABLE'] = "ON"
    os.environ['IR_ENABLE'] = "OFF"
    ## 删除相关文件
    cmd = f"rm -rf ./lib/{app_name} && rm -rf build"
    result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行
    if result.returncode == 0:
        # print("success\n")
        pass
    else:
        print("rm failed\n")
    ## 编译
    cmd = f"cmake -S . -B build/{app_name}/{inject_bit}"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={inject_bit}")
        print("Output:\n", e.stdout.decode())

    cmd = f"cmake --build build/{app_name}/{inject_bit} -j64"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())
    
    # 运行--------------------------------------
    time = 0
    cmd = f"./bin/{app_name}/{app_name}_{inject_bit}"
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
    improve = 100 * (baseline_time - time) / baseline_time
    speedup = baseline_time / time
    print(time, speedup, improve)
    return time, speedup, improve

strSearch = "31_28_26_38_47_74_61"
strMode = "1_0_0_0_1_0_0"
storebypass = "false"
storemode = 0
baseline_time = 4.3

offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time)