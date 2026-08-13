function(register_benchmark_brute)
    set(options INJECT)
    set(oneValueArgs TARGET)
    set(multiValueArgs SOURCES)

    cmake_parse_arguments(REGISTER_BENCHMARK "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    
    # 有其余.c文件版本
    # 将涉及到的.cc文件链接进来
    # "${CMAKE_SOURCE_DIR}/include/$ENV{APP_NAME}/*.hip" 这里的hip根本进不进去pass
    if("$ENV{SOURCE_CPP}" STREQUAL "ON")
        file(GLOB ADDITIONAL_SOURCES 
        # "${CMAKE_SOURCE_DIR}/include/$ENV{APP_NAME}/*.hip"
        "${CMAKE_SOURCE_DIR}/include/$ENV{APP_NAME}/*.cc"
        "${CMAKE_SOURCE_DIR}/include/$ENV{APP_NAME}/*.cpp"
        "${CMAKE_SOURCE_DIR}/include/$ENV{APP_NAME}/*.c")
        
        message(STATUS "APP_NAME = $ENV{APP_NAME}")
        message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
        message(STATUS "ADDITIONAL_SOURCES = ${ADDITIONAL_SOURCES}")

        add_executable(${REGISTER_BENCHMARK_TARGET} ${ADDITIONAL_SOURCES})
        set_target_properties(${REGISTER_BENCHMARK_TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/$ENV{APP_NAME})
        # set_target_properties(REGISTER_BENCHMARK_TARGET PROPERTIES COMPILE_FLAGS "-fpass-plugin=${CMAKE_SOURCE_DIR}/lib/$ENV{APP_NAME}/$ENV{INJECT_BIT}/hipPass.so")
        
        # 只对REGISTER_BENCHMARK_SOURCES注入hipPass.so
        add_library(REGISTER_BENCHMARK_SOURCES_LIB ${REGISTER_BENCHMARK_SOURCES})
        # 添加依赖，要在hipPass生成之后再使用REGISTER_BENCHMARK_SOURCES_LIB
        add_dependencies(REGISTER_BENCHMARK_SOURCES_LIB hipPass)
        set_target_properties(REGISTER_BENCHMARK_SOURCES_LIB PROPERTIES COMPILE_FLAGS "-fpass-plugin=${CMAKE_SOURCE_DIR}/lib/$ENV{APP_NAME}/$ENV{INJECT_BIT}/hipPass.so")
        
        target_link_libraries(${REGISTER_BENCHMARK_TARGET} REGISTER_BENCHMARK_SOURCES_LIB)
        # target_link_libraries(${REGISTER_BENCHMARK_TARGET} hipsparse hipblas)

    else()
        # 无.c文件版本
        # always inject pass
        # # add_executable(${REGISTER_BENCHMARK_TARGET} ${REGISTER_BENCHMARK_SOURCES} ${ADDITIONAL_SOURCES})
        add_executable(${REGISTER_BENCHMARK_TARGET} ${REGISTER_BENCHMARK_SOURCES})
        set_target_properties(${REGISTER_BENCHMARK_TARGET} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/$ENV{APP_NAME})
        add_dependencies(${REGISTER_BENCHMARK_TARGET} hipPass)
        target_link_libraries(${REGISTER_BENCHMARK_TARGET} hipsparse)
        target_link_libraries(${REGISTER_BENCHMARK_TARGET} hipblas)
        message(STATUS "REGISTER_BENCHMARK_TARGET = ${REGISTER_BENCHMARK_TARGET}")
        target_compile_options(${REGISTER_BENCHMARK_TARGET} PUBLIC -fpass-plugin=${CMAKE_SOURCE_DIR}/lib/$ENV{APP_NAME}/$ENV{INJECT_BIT}/hipPass.so)
    
    endif()

    # #### IR TARGET ####
    # file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY})
    # file(MAKE_DIRECTORY ${CMAKE_TMP_DIRECTORY}/IR)
    # get_target_property(target_sources ${REGISTER_BENCHMARK_TARGET} SOURCES)
    # cmake_path(ABSOLUTE_PATH target_sources OUTPUT_VARIABLE abs_path)
    # get_target_property(target_include_path ${REGISTER_BENCHMARK_TARGET} INCLUDE_DIRECTORIES)
    # add_custom_command(OUTPUT ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll
    # COMMAND
    #     ${CMAKE_HIP_COMPILER} -I ${target_include_path} -Wno-return-type-c-linkage
    #     -std=c++17 -S --offload-device-only ${abs_path} -emit-llvm -o ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll)
    
    # add_custom_target(${REGISTER_BENCHMARK_TARGET}.ll
    #                     DEPENDS ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll)
    # ###################


endfunction(register_benchmark_brute)

