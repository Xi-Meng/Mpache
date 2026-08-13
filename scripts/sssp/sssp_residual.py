import os
import subprocess
def work(BIT):
    print(f"INJECT_BIT is {BIT}")

    # 设置环境变量INJECT_BIT
    os.environ['INJECT_BIT'] = BIT

    # 运行 cmake 命令，注意subprocess.run命令会阻塞进程，直到命令完成
    # subprocess.run(f"cmake -S . -B build -D TARGET_NAME={BIT} > /dev/null 2>&1", shell=True)
    # subprocess.run("cmake --build build -j64 > /dev/null 2>&1", shell=True)

    # 将构建目录变为不一样的
    try:
        subprocess.run(f"cmake -S . -B build/{BIT} -D TARGET_NAME={BIT}", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={BIT}")
        print("Output:\n", e.stdout.decode())

    try:
        subprocess.run(f"cmake --build build/{BIT} -j64", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())


if __name__ == "__main__":
    bits = ["200020110","201221100"]
    for bit in bits:
        work(bit)
