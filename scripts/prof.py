#! /usr/bin/python3
import subprocess
from tempfile import mktemp
import common
import os

os.environ["ROCR_VISIBLE_DEVICES"] = common.args.device

# reference /opt/rocm/lib/rocprofiler/(gfx_)metrics.xml
pmcs = [["L2CacheHit"],["FetchSize","WriteSize"],["MemUnitStalled","WriteUnitStalled"]]

pmc_config = mktemp(suffix=".txt")
with open(pmc_config,"w") as f:
  # pmc counters are limited so we need to divide metrics into groups
  for pmc_group in pmcs:
    f.write(f"pmc: {' '.join(pmc_group)}\n")
  
out_path_prefix = "tmp/PROF"
  
if not os.path.exists(out_path_prefix):
  os.makedirs(out_path_prefix)

for app in common.apps:
  print(f"profiling {app}")
  command = f"rocprofv2 -i {pmc_config} -o {out_path_prefix}/{app} {common.args.path}/bin/{app}"
  subprocess.run([command],shell=True)
  