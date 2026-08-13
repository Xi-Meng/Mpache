import random
import argparse

parser = argparse.ArgumentParser(description='Generate a sparse matrix.')
parser.add_argument('--rows', required=True, type=int, help='number of rows in the matrix')
parser.add_argument('--cols', required=True, type=int, help='number of columns in the matrix')
parser.add_argument('--elements', required=True, type=int, help='number of non-zero elements in the matrix')
args = parser.parse_args()

n_rows = args.rows
n_cols = args.cols
n_elements = args.elements

# 定义要生成的矩阵大小和非零元素的数目 
# 规律：越稀疏，bypass后的效果越好；但是过于稀疏，到27000，bypass效果就不是那么好，猜测是cache没填满
# n_rows, n_cols, n_elements = 11500, 11500, 280000
# 11500 11500 280000
# 稀疏度：0.00212
file_name='/workspace/Inst-level-cache-management/include/spmm_my/data/demo_matrix.mtx'
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
