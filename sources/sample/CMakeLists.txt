add_executable(sample sample.cpp)


set_target_properties(sample PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${emt_bin_dir}
)

target_link_libraries(sample PUBLIC emt::emt)
target_compile_definitions(
    sample PRIVATE 
    $<$<BOOL:${BUILD_SHARED_LIBS}>:EMT_SHARED_LIB>
)