
find_program(glslang glslangValidator HINTS ${CMAKE_SOURCE_DIR}/bin)

if(glslang)
    message(STATUS "[emt] found the glslang")
else()
    message(STATUS "[emt] failed to find glslang")
    include(external-glslang)
    find_program(glslangValidator HINTS ${CMAKE_SOURCE_DIR}/bin)
endif()


set(shader__dir ${CMAKE_SOURCE_DIR}/data/shader)

execute_process(
    COMMAND ${glslang} -V ${shader__dir}/shader.vert -o ${shader__dir}/shader.spv
    RESULT_VARIABLE res
)

if(NOT res)
    message(STATUS "compiled.")
endif()


message(STATUS "[emt] : lang ${glslangValidator}")
