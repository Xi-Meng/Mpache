import pandas as pd

df = pd.read_csv("/workspace/Inst-level-cache-management/IPC/sssp_result.csv")
average_grbm_count = df['GRBM_COUNT'].mean()
print("平均 GRBM_COUNT 值是 :", average_grbm_count)