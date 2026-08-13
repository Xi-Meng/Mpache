#! /usr/bin/python3
import glob
import visDOT
# import common

path = "/workspace/Inst-level-cache-management"
dfg_files = glob.glob(path+"/tmp/DFG/*.dot")
cfg_files = glob.glob(path+"/tmp/CFG/*.dot")
# print(common.args.path)
for dfg_file in dfg_files:
  print(f"processing {dfg_file.split('/')[-1]}")
  print(dfg_file)
  visDOT.vis_dot(dfg_file)

for cfg_file in cfg_files:
  print(f"processing {cfg_file.split('/')[-1]}")
  visDOT.vis_dot(cfg_file)