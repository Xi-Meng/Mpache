#------------------------- for once compiler -----------------------
# cmake_minimum_required(VERSION 3.21)
# project(
#   inst-level-cache-management
#   LANGUAGES C CXX HIP
#   VERSION 0.1)


# # add_custom_target(
# #     clean_log ALL
# #     COMMAND ${CMAKE_COMMAND} -E remove -f ./pass/injectPass.log
# # )

# # Basic build configurations
# set(CMAKE_CXX_STANDARD 20)
# set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# if(NOT CMAKE_BUILD_TYPE)
#   set(CMAKE_BUILD_TYPE "Release")
# endif()
# message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# include(CheckLanguage)
# check_language(CXX)
# check_language(HIP)

# find_package(hip REQUIRED)
# find_package(LLVM REQUIRED)
# find_package(rocm_smi REQUIRED)
# find_package(hipSPARSE REQUIRED)
# find_package(hipblas REQUIRED)

# message(STATUS "LLVM version: ${LLVM_VERSION}")
# include(AddLLVM)

# include_directories(${CMAKE_SOURCE_DIR}/include)
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
# # set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
# # include_directories("/opt/rocm-5.7.0/include")
# # link_directories("/opt/rocm-5.7.0/lib")


# list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
# include(register_benchmark)

# set(CMAKE_TMP_DIRECTORY ${CMAKE_SOURCE_DIR}/tmp)


# file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY})
# file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/IR)
# file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/DFG)
# file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/CFG)

# add_subdirectory(pass)
# add_subdirectory(src)


#---------------------- for brute compiler ---------------------
cmake_minimum_required(VERSION 3.21)
project(
  inst-level-cache-management
  LANGUAGES C CXX HIP
  VERSION 0.1)


# add_custom_target(
#     clean_log ALL
#     COMMAND ${CMAKE_COMMAND} -E remove -f ./pass/injectPass.log
# )

# add_custom_target(
#     clean_log ALL
#     COMMAND ${CMAKE_COMMAND} -E remove -f ./bin/sssp_bin/sssp.log
# )

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
# find_package(hipSPARSE REQUIRED)
# find_package(hipblas REQUIRED)

message(STATUS "LLVM version: ${LLVM_VERSION}")
include(AddLLVM)

include_directories(${CMAKE_SOURCE_DIR}/include)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
# include_directories("/opt/rocm-5.7.0/include")
# link_directories("/opt/rocm-5.7.0/lib")


list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(register_benchmark_brute)
include(register_benchmark)

set(CMAKE_TMP_DIRECTORY ${CMAKE_SOURCE_DIR}/tmp)


file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY})
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/IR)
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/DFG)
file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/CFG)

add_subdirectory(pass)
# add_subdirectory(src)

# if(NOT DEFINED TARGET_NAME)
#     set(TARGET_NAME "NULL")
# endif()
# message(STATUS "TARGET_NAME: ${TARGET_NAME}")

register_benchmark_brute(TARGET $ENV{APP_NAME}_$ENV{INJECT_BIT} SOURCES src/$ENV{APP_NAME}.hip)

# register_benchmark(TARGET $ENV{APP_NAME}_$ENV{INJECT_BIT} SOURCES src/$ENV{APP_NAME}.hip)


