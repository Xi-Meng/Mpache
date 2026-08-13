# Scripts

This directory contains helper scripts used to build, inspect, profile, and
search Mpache configurations. Most scripts assume `CM_PROJ_PATH` points to the
repository root.

```bash
export CM_PROJ_PATH="$(pwd)"
```

## Build and Cleanup

```bash
export APP_NAME=floyd_warshall
export INJECT_BIT=baseline
export SOURCE_CPP=OFF
./scripts/build.sh
```

Cleans generated files, configures CMake with Ninja, builds `hipPass`, and builds
the configured target. The top-level CMake file expects `APP_NAME` and
`INJECT_BIT` to be set before running this script.

```bash
./scripts/clean.sh
```

Removes temporary build and analysis outputs.

```bash
./scripts/rebuild.sh <benchmark>
```

Legacy helper for rebuilding and disassembling a single benchmark in the older
baseline/`INJECT_` target flow. The current CMake flow is environment-variable
driven, so check this script before relying on it for a new experiment.

## Analysis and Profiling

```bash
./scripts/disassemble.py -p "$CM_PROJ_PATH"
```

Runs ROCm object disassembly for generated binaries.

```bash
./scripts/prof.py -p "$CM_PROJ_PATH" -d 0
```

Runs profiling commands for selected benchmarks.

```bash
./scripts/benchmark.py -p "$CM_PROJ_PATH" -d 0 -i 5
```

Runs a small benchmark subset and writes a plot to `tmp/results/benchmark.svg`.

```bash
./scripts/measure_overhead.py -p "$CM_PROJ_PATH" -d 0
```

Measures kernel launch overhead.

## Visualization

```bash
./scripts/visDAG.py
./scripts/visDOT.py -p <absolute-path-to-dot-file>
```

Visualizes generated graph files from pass analysis.

## Search Workflows

Files named `app_*`, `brute_*`, and `search_input_*` encode paper-specific
configuration search workflows. They may contain hard-coded benchmark lists,
input choices, or local assumptions. Treat them as reproducibility scripts rather
than stable user-facing commands.
