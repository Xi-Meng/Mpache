#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]
then
  echo "ERROR: Please pass the name of benchmark" >&2
  exit 1
elif [ ! -e src/$1.hip ]
then
  echo "ERROR: src/$1.hip does not exist" >&2
  exit 1
fi

echo "rebuilding $1" 
cmake --build build -t clean
cmake --build build -t hipPass
cmake --build build -t $1
cmake --build build -t INJECT_$1
roc-obj -o tmp/ISA -d ./bin/$1
roc-obj -o tmp/ISA -d ./bin/INJECT_$1
./bin/$1 && ./bin/INJECT_$1 
