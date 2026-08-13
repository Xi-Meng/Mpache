#! /usr/bin/python3
import subprocess
import re
import matplotlib.pyplot as plt
import common
import os
import tqdm
import numpy as np


iterations = 100000
step = 1000
pattern = "total: (.*) ms"
benchmark = "./bin/kernel_overhead"

prefix_path = f"{common.args.path}/tmp/results"
pic_path = f"{prefix_path}/overhead.svg"

if not os.path.exists(prefix_path):
  os.makedirs(prefix_path)

time_tot = []
kernel_iters = np.array(range(1,iterations,step))
for i in tqdm.tqdm(kernel_iters):
  command = f"{benchmark} {i}"
  result = subprocess.run([command],shell=True,capture_output=True)
  time_each = eval(re.match(pattern,result.stdout.decode()).group(1))
  time_tot.append(time_each)

slope,intercept = np.polyfit(kernel_iters,time_tot,1)

plt.figure(figsize=(20,8))
plt.rcParams.update({"font.size":20})
plt.plot(kernel_iters,time_tot,label="origin")
plt.plot(kernel_iters,kernel_iters*slope+intercept,color="red",label=f"y={slope}*x+{intercept}")
plt.legend(fontsize=20)
plt.ylabel("time(ms)",fontsize=20)
plt.xlabel("#kernels",fontsize=20)
plt.savefig(pic_path,bbox_inches="tight")

print(f"\nresults saved to {pic_path}")