# Contributing

Thank you for your interest in Mpache.

This repository is a research prototype. Contributions are welcome when they
make the artifact easier to build, reproduce, or extend.

## Before Sending Changes

- Keep benchmark behavior reproducible.
- Document any environment assumptions, especially ROCm, LLVM, GPU model, and
  benchmark input changes.
- Avoid committing generated build directories, binaries, profiling traces, or
  temporary analysis files.
- Preserve attribution and license notices for third-party benchmark code under
  `include/`.

## Development Workflow

1. Create a branch for your change.
2. Build at least one affected benchmark configuration.
3. Run the generated executable and record the environment if reporting
   performance.
4. Update `README.md` or `scripts/README.md` when changing build or reproduction
   commands.

## Reporting Issues

Please include:

- ROCm version.
- LLVM/Clang version.
- GPU model.
- `APP_NAME`, `INJECT_BIT`, and `SOURCE_CPP` values.
- Full CMake/build command and the relevant error output.

