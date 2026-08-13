#! /usr/bin/python3
import common
import subprocess
import os

out_path_prefix = f"{common.args.path}/tmp/ISA"
  
if not os.path.exists(out_path_prefix):
  os.makedirs(out_path_prefix)

for app in common.apps:
  command = f"roc-obj -o {out_path_prefix} -d {common.args.path}/bin/{app}"
  subprocess.run([command],shell=True)
  command = f"roc-obj -o {out_path_prefix} -d {common.args.path}/bin/INJECT_{app}"
  subprocess.run([command],shell=True)
  