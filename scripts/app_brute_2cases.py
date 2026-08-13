from multiprocessing import Pool, cpu_count
import os
import subprocess

# TODO
# appName = "spmv_my"
# load_require = 10
appName = os.environ['APP_NAME']
load_require = int(os.environ['LOAD_REQUIRE'])

# 创建一个数组包含0，1，2
arr = [0, 2] # 0:正常，2：bypass L1

# 定义最大的并行任务数量
max_jobs = 50
# 创建一个数组包含0，1
arr = [0, 1] # 0:正常，1：只设置nontemporal
length = 2

def work(k):
    # # 如果k小于1483，直接返回
    # if k < 13941:
    #     return

    # 每次循环都生成一个新的INJECT_BIT
    BIT = ""

    # 遍历每一位Bit
    temp = k
    for _ in range(load_require):
        # 这里用到了模运算和整数除法运算来获取每一位的值
        index = temp % length
        temp = temp // length

        # 添加到INJECT_BIT字符串
        BIT += str(arr[index])

    print(f"INJECT_BIT is {BIT} for iteration {k}")

    # 设置环境变量
    # TODO
    os.environ['INJECT_BIT'] = BIT
    os.environ['APP_NAME'] = appName
    os.environ['SOURCE_CPP'] = "ON"
    os.environ['IR_ENABLE'] = "OFF"
    os.environ['BYPASS_ENABLE'] = "ON"

    # 运行 cmake 命令，注意subprocess.run命令会阻塞进程，直到命令完成
    # subprocess.run(f"cmake -S . -B build -D TARGET_NAME={BIT} > /dev/null 2>&1", shell=True)
    # subprocess.run("cmake --build build -j64 > /dev/null 2>&1", shell=True)

    # 将构建目录变为不一样的
    try:
        subprocess.run(f"cmake -S . -B build/{appName}/{BIT}", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={BIT}")
        print("Output:\n", e.stdout.decode())

    try:
        subprocess.run(f"cmake --build build/{appName}/{BIT} -j64", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())


if __name__ == "__main__":
    with Pool(processes=max_jobs) as pool:
        num = length**(load_require)
        print("iteration sum: %s \n" % num)
        pool.map(work, range(num))
