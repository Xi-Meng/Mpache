#! /bin/bash
./scripts/clean.sh
export CM_PROJ_PATH=$(pwd)
cmake -S . -B build -G Ninja
cmake --build build -t hipPass
cmake --build build