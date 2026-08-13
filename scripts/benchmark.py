#! /usr/bin/python3
import pandas as pd
import seaborn as sns
import subprocess
import re
import matplotlib.pyplot as plot
import os
import common

data = pd.DataFrame(columns=["app","mode","time"])

pattern = "(.*) [mu]s"
prefix_path = f"{common.args.path}/tmp/results"
pic_path = f"{prefix_path}/benchmark.svg"

# https://rocm.docs.amd.com/en/latest/conceptual/gpu-isolation.html
os.environ["ROCR_VISIBLE_DEVICES"] = common.args.device

if not os.path.exists(prefix_path):
  os.makedirs(prefix_path)

for app in common.apps:
  if app=="micro_bench_kernel_overhead":  # 暂时先跳过
    continue
  if app not in ["sssp", "2mm", "3mm", "simpleSpmv"]:
    continue
  print(f"benchmarking {app}",end=' ',flush=True)
  commands = [f"{common.args.path}/bin/{app}",f"{common.args.path}/bin/INJECT_{app}"]
  modes = ["baseline","INJECT"]
  times = []
  for command in commands:
    time_each = 0
    for _ in range(common.args.iteration):
      result = subprocess.run([command],shell=True,capture_output=True)
      time_each = time_each + eval(re.match(pattern,result.stdout.decode()).group(1))
    times.append(time_each/common.args.iteration)
  print(times)
  for i in range(1,len(times)):
    times[i] = times[i]/times[0]
  times[0] = 1
  for i in range(len(commands)):
    data.loc[data.shape[0]] = [app,modes[i],times[i]]

sns.set_context()
plot.figure(figsize=(20,8))
g = sns.barplot(data=data,x="app",y="time",hue="mode")
g.figure.savefig(pic_path,bbox_inches="tight")

print(f"results saved to {pic_path}")
  
  
  
  