
# configurations
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

message(STATUS "[emt] build type : ${CMAKE_BUILD_TYPE}")

if(MSVC)
    set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "available build configs" FORCE)
    message(STATUS "[emt] msvc compiler version : ${MSVC_TOOLSET_VERSION}")
    find_program(GG cl.exe)
    message("cl : ${GG}")
endif()

