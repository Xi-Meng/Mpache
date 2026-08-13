import random
import argparse

parser = argparse.ArgumentParser(description='Generate a sparse matrix.')
parser.add_argument('--rows', required=True, type=int, help='number of rows in the matrix')
parser.add_argument('--cols', required=True, type=int, help='number of columns in the matrix')
parser.add_argument('--sparse', required=True, type=float, help='number of non-zero elements in the matrix')
args = parser.parse_args()

n_rows = args.rows
n_cols = args.cols
sparse = args.sparse

avg_edge = round(n_cols * sparse)
n_elements = n_rows * avg_edge

# 生成矩阵

# 定义要生成的矩阵大小和非零元素的数目 
# 规律：越稀疏，bypass后的效果越好；但是过于稀疏，到27000，bypass效果就不是那么好，猜测是cache没填满
# n_rows, n_cols, n_elements = 8192, 8192, 261725
# avg_edge = 200
file_name='/workspace/Inst-level-cache-management/include/jds_bfs/data/demo_matrix.mtx'
# 打开一个文件并写入矩阵元数据
with open(file_name, 'w') as f:
    f.write('%%MatrixMarket matrix coordinate real general\n')
    f.write(f'{n_rows} {n_cols} {n_elements}\n')

# # 在文件中写入5200个随机位置和随机值的矩阵元素
# with open(file_name, 'a') as f:
#     for _ in range(n_elements):
#         i = random.randint(1, n_rows)  # 生成一个1到420的随机行索引
#         j = random.randint(1, n_cols)  # 生成一个1到420的随机列索引
#         # value = random.uniform(-1, 1)  # 生成一个-1到1之间的随机数
#         value = 1
#         f.write(f'{i} {j} {value:.14e}\n')  # 以科学记数法格式化矩阵元素值并写入文件

with open(file_name, 'a') as f:
    for i in range(1, n_rows+1):
        for _ in range(avg_edge):
            j = random.randint(1, n_cols)  # 生成一个1到n_cols的随机列索引
            # value = random.uniform(-1, 1)  # 生成一个-1到1之间的随机数
            value = 1
            f.write(f'{i} {j} {value:.14e}\n')  # 以科学记数法格式化矩阵元素值并写入文件