#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${APP_NAME:-}" ]]; then
  echo "ERROR: APP_NAME is not set. Example: export APP_NAME=floyd_warshall" >&2
  exit 1
fi

if [[ -z "${INJECT_BIT:-}" ]]; then
  echo "ERROR: INJECT_BIT is not set. Example: export INJECT_BIT=baseline" >&2
  exit 1
fi

export SOURCE_CPP="${SOURCE_CPP:-OFF}"
export CM_PROJ_PATH="${CM_PROJ_PATH:-$(pwd)}"

./scripts/clean.sh
cmake -S . -B build -G Ninja
cmake --build build -t hipPass
cmake --build build
