set(CMAKE_CXX_COMPILER ${CMAKE_HIP_COMPILER})
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})

add_llvm_pass_plugin(hipPass hipPass.cc)