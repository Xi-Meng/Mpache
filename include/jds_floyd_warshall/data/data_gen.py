import random

# # 生成向量
# # import random

# # 在文件中写入矩阵元数据
# file_name = 'demo_vector.mtx'
# n_rows, n_cols = 11500, 1

# with open(file_name, 'w') as f:
#     f.write('%%MatrixMarket matrix array real general\n')
#     # f.write('420 1\n')
#     f.write(f'{n_rows} {n_cols}\n')

# # 在文件中写入420行随机生成的实数值
# with open(file_name, 'a') as f:
#     for _ in range(n_rows):
#         f.write(f'{random.uniform(0, 1):.14e}\n')  # 生成一个0到1之间的随机数并以科学计数法格式化

# 生成矩阵

# 定义要生成的矩阵大小和非零元素的数目 
# 规律：越稀疏，bypass后的效果越好；但是过于稀疏，到27000，bypass效果就不是那么好，猜测是cache没填满
n_rows, n_cols, n_elements = 11500, 11500, 280000
file_name='demo_matrix.mtx'
# 打开一个文件并写入矩阵元数据
with open(file_name, 'w') as f:
    f.write('%%MatrixMarket matrix coordinate real general\n')
    f.write(f'{n_rows} {n_cols} {n_elements}\n')

# 在文件中写入5200个随机位置和随机值的矩阵元素
with open(file_name, 'a') as f:
    for _ in range(n_elements):
        i = random.randint(1, n_rows)  # 生成一个1到420的随机行索引
        j = random.randint(1, n_cols)  # 生成一个1到420的随机列索引
        value = random.uniform(-1, 1)  # 生成一个-1到1之间的随机数
        f.write(f'{i} {j} {value:.14e}\n')  # 以科学记数法格式化矩阵元素值并写入文件
