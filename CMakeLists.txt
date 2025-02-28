cmake_minimum_required(VERSION 3.22)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS FALSE)

set(emt_standalone TRUE)
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    set(emt_standalone TRUE)
else()
    set(emt_standalone FALSE)
endif()

# variable settings
set(emt_name empty)
set(emt_external_dir ${CMAKE_CURRENT_SOURCE_DIR}/external)
set(emt_bin_dir ${CMAKE_CURRENT_SOURCE_DIR}/bin)
if(NOT ${emt_standalone})
    set(emt_bin_dir ${CMAKE_CURRENT_BINARY_DIR}/bin)
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${CMAKE_CURRENT_SOURCE_DIR}/cmake/module)

if(BUILD_SHARED_LIBS)
    message(STATUS "[emt] this is shared libs")
endif()

project(${emt_name} VERSION 1.0.0 LANGUAGES C CXX)

include(configuration)

add_subdirectory(sources/empty)

add_subdirectory(sources/sample)


