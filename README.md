# Mpache

Interaction-aware multi-level cache bypassing on GPUs.

This repository contains the research prototype for the ASP-DAC 2025 paper
"Mpache: Interaction Aware Multi-level Cache Bypassing on GPUs". Mpache profiles
the bypassing effect of load instructions, analyzes instruction interactions,
and uses an LLVM/HIP compiler pass to inject cache-bypass decisions for AMD GPUs.

Paper: https://dl.acm.org/doi/10.1145/3658617.3697568

## Repository Status

This is an artifact-style research codebase. It is useful for reproducing and
extending the Mpache prototype, but it is not yet a polished production library.
Before making the repository public, please review
[docs/OPEN_SOURCE_CHECKLIST.md](docs/OPEN_SOURCE_CHECKLIST.md), especially the
license and third-party benchmark attribution items.

## What Is Included

- `pass/`: LLVM pass plugin used to analyze HIP kernels and inject cache-bypass
  attributes.
- `src/`: HIP benchmark entry points used by the prototype.
- `include/`: benchmark support code and imported benchmark suites.
- `cmake/`: CMake helpers for registering baseline and instrumented benchmarks.
- `scripts/`: build, profiling, brute-force search, disassembly, and plotting
  scripts.
- `system/`: Mpache analysis scripts and saved per-application configuration
  results.
- `IPC/`, `metrics/`, `assem/`, `omnitrace-*_output/`: saved experiment outputs
  and profiling/disassembly artifacts.

## Requirements

The prototype has been used with the following environment:

- Linux host or container with AMD GPU access.
- AMD ROCm/HIP, tested around ROCm 5.7.
- LLVM and Clang compatible with the installed ROCm stack.
- CMake 3.21 or newer.
- Ninja.
- Python 3 with packages used by the scripts, including `pandas`, `seaborn`, and
  `matplotlib` for plotting workflows.

The exact GPU target and ROCm version can affect generated ISA and performance
numbers. Reproduction is therefore best done on an AMD GPU platform close to the
paper environment.

## Container Setup

One convenient setup is to use the ROCm container image and mount the host
workspace:

```bash
docker run \
  -v ~/:/workspace \
  --name rocm_workspace \
  -u root \
  -itd \
  --device=/dev/kfd \
  --device=/dev/dri \
  --security-opt seccomp=unconfined \
  --group-add video \
  rocm/rocm-terminal:5.7
```

Attach to the container:

```bash
docker exec -it rocm_workspace /bin/bash
cd /workspace/path/to/Mpache
export CM_PROJ_PATH="$(pwd)"
```

## Build

The current top-level CMake flow builds one benchmark/configuration at a time.
Set `APP_NAME` to a file stem in `src/` and set `INJECT_BIT` to the cache-control
configuration you want to build.

Example:

```bash
export CM_PROJ_PATH="$(pwd)"
export APP_NAME=floyd_warshall
export INJECT_BIT=baseline
export SOURCE_CPP=OFF

cmake -S . -B build -G Ninja
cmake --build build -t hipPass
cmake --build build
```

The executable is emitted under:

```text
bin/${APP_NAME}/${APP_NAME}_${INJECT_BIT}
```

Some benchmarks require extra `.c`, `.cc`, or `.cpp` support files from
`include/${APP_NAME}`. For those benchmarks, set:

```bash
export SOURCE_CPP=ON
```

## Quick Smoke Test

After building one target, run the generated executable directly:

```bash
./bin/${APP_NAME}/${APP_NAME}_${INJECT_BIT}
```

Most benchmark programs print a kernel/runtime measurement. Compare different
`INJECT_BIT` configurations for the same `APP_NAME` to inspect the effect of a
cache-bypass policy.

## Useful Scripts

Build helper:

```bash
export APP_NAME=floyd_warshall
export INJECT_BIT=baseline
export SOURCE_CPP=OFF
./scripts/build.sh
```

Benchmark helper:

```bash
./scripts/benchmark.py -p "$CM_PROJ_PATH" -d 0 -i 5
```

Disassemble generated binaries:

```bash
./scripts/disassemble.py -p "$CM_PROJ_PATH"
```

See [scripts/README.md](scripts/README.md) for a compact script reference. Some
scripts encode paper-specific benchmark subsets or local experiment assumptions;
check the script before using it for new workloads.

## Generated Files

The build and analysis flow can generate:

- `build/`
- `bin/`
- `lib/`
- `tmp/`
- `tmp/IR/`, `tmp/CFG/`, `tmp/DFG/`, `tmp/ISA/`
- profiling outputs from Omniperf/Omnitrace

These files are ignored by `.gitignore` going forward. Existing checked-in
experiment outputs are kept as reference artifacts until the authors decide
whether to move them to a release archive or remove them from the public branch.

## Citation

If you use Mpache in your research, please cite:

```bibtex
@inproceedings{xi2025mpache,
  title     = {Mpache: Interaction Aware Multi-level Cache Bypassing on GPUs},
  author    = {Xi, Mengyue and Guo, Tianyu and Huang, Xuanteng and Lin, Zejia and Zhang, Xianwei},
  booktitle = {Proceedings of the 30th Asia and South Pacific Design Automation Conference},
  pages     = {1209--1215},
  year      = {2025},
  doi       = {10.1145/3658617.3697568}
}
```

## License

No open-source license has been selected yet. Until a license is added, the
default copyright restrictions apply and external users do not have explicit
permission to reuse, modify, or redistribute the code.

Recommended next step before publishing: choose a license, add `LICENSE`, and
verify that all bundled third-party benchmark code is compatible with that
license or has clear attribution.
