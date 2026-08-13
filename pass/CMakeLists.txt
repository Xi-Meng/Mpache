set(CMAKE_CXX_COMPILER ${CMAKE_HIP_COMPILER})
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})
list(APPEND CMAKE_PREFIX_PATH "/opt/rocm/llvm/lib/cmake/llvm")
include(AddLLVM)

# change the output path of hipPass.so
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/$ENV{APP_NAME}/$ENV{INJECT_BIT})
add_llvm_pass_plugin(hipPass hipPass.cc)