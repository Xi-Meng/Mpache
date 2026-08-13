function(register_benchmark)
    set(options INJECT)
    set(oneValueArgs TARGET)
    set(multiValueArgs SOURCES)

    cmake_parse_arguments(REGISTER_BENCHMARK "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    add_executable(${REGISTER_BENCHMARK_TARGET} ${REGISTER_BENCHMARK_SOURCES})

    get_target_property(target_sources ${REGISTER_BENCHMARK_TARGET} SOURCES)
    cmake_path(ABSOLUTE_PATH target_sources OUTPUT_VARIABLE abs_path)
    get_target_property(target_include_path ${REGISTER_BENCHMARK_TARGET} INCLUDE_DIRECTORIES)


    #### IR TARGET ####
    add_custom_command(OUTPUT ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll
    COMMAND
        ${CMAKE_HIP_COMPILER} -I ${target_include_path} -Wno-return-type-c-linkage
        -std=c++17 -S --offload-device-only ${abs_path} -emit-llvm -o ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll)
    
    add_custom_target(${REGISTER_BENCHMARK_TARGET}.ll
                        DEPENDS ${CMAKE_TMP_DIRECTORY}/IR/${REGISTER_BENCHMARK_TARGET}.ll)
    ###################

    #### ISA TARGET ####
    add_custom_command(OUTPUT ${CMAKE_TMP_DIRECTORY}/ISA/${REGISTER_BENCHMARK_TARGET}.isa
    COMMAND
        ${CMAKE_HIP_COMPILER} -I ${target_include_path} -Wno-return-type-c-linkage
        -std=c++17 -S --offload-device-only ${abs_path} -o ${CMAKE_TMP_DIRECTORY}/ISA/${REGISTER_BENCHMARK_TARGET}.isa)
    
    add_custom_target(${REGISTER_BENCHMARK_TARGET}.isa
                        DEPENDS ${CMAKE_TMP_DIRECTORY}/ISA/${REGISTER_BENCHMARK_TARGET}.isa)
    ###################

    if(${REGISTER_BENCHMARK_INJECT})
        add_executable(INJECT_${REGISTER_BENCHMARK_TARGET} ${REGISTER_BENCHMARK_SOURCES})
        target_compile_options(INJECT_${REGISTER_BENCHMARK_TARGET} PUBLIC -fpass-plugin=${CMAKE_SOURCE_DIR}/lib/hipPass.so)
    endif()
    
endfunction(register_benchmark)

