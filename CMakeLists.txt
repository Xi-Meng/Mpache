cmake_minimum_required(VERSION 3.21)
project(
  inst-level-cache-management
  LANGUAGES C CXX HIP
  VERSION 0.1)

# Basic build configurations
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

include(CheckLanguage)
check_language(CXX)
check_language(HIP)

find_package(hip REQUIRED)
find_package(LLVM REQUIRED)
find_package(rocm_smi REQUIRED)

message(STATUS "LLVM version: ${LLVM_VERSION}")
include(AddLLVM)

include_directories(${CMAKE_SOURCE_DIR}/include)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(register_benchmark)

set(CMAKE_TMP_DIRECTORY ${CMAKE_SOURCE_DIR}/tmp)


file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY})
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/IR)
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/DFG)
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/CFG)

add_subdirectory(pass)
add_subdirectory(src)


