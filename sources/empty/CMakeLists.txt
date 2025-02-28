
file(GLOB_RECURSE srcs *.h *.cpp)

add_library(empty ${srcs})
add_library(emt::emt ALIAS empty)

set_target_properties(empty PROPERTIES
    RUNTIME_OUTPUT_NAME "${emt_name}"
    ARCHIVE_OUTPUT_NAME "${emt_name}"
    CMAKE_SHARED_LIBRARY_ARCHIVE_SUFFIX ""
    ARCHIVE_OUTPUT_DIRECTORY ${emt_bin_dir}
    RUNTIME_OUTPUT_DIRECTORY ${emt_bin_dir}
    LIBRARY_OUTPUT_DIRECTORY ${emt_bin_dir}
)

target_include_directories(empty PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(empty PRIVATE
    $<$<BOOL:${BUILD_SHARED_LIBS}>:EMT_SHARED_LIB EMT_DLL_EXPORT>
)



