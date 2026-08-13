import os

appName = os.environ['APP']
file_name = f"./assem/{appName}/{appName}-hip-amdgcn-amd-amdhsa-gfx1030.s"
temp_file_name = f"./assem/{appName}/temp.s"
# 打开你的文件进行读取

with open(file_name, 'r') as file:
    lines = file.readlines()

# 创建一个临时文件将修改后的内容写入
with open(temp_file_name, 'w') as file:
    for line in lines:
        # 检查当前行是否以 'global_load' 或 'global_store' 开头
        if line.strip().startswith(('global_load', 'global_store')):
            # 在行的末尾添加 'test'
            line = line.strip() + ' glc slc\n'
        file.write(line)

# 删除原始文件
os.remove(file_name)

# 将临时文件重命名为原始文件名
os.rename(temp_file_name, file_name)
