set(CMAKE_SYSTEM_NAME Windows)

execute_process(
    COMMAND "C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe" 
    -latest 
    -products * 
    -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 
    -property installationPath
    RESULT_VARIABLE VS_INSTALLED
    OUTPUT_VARIABLE VS_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
)

if(VS_PATH)
    set(vs_tool_path ${VS_PATH}/VC/Tools/MSVC)

    file(GLOB msvc_versions LIST_DIRECTORIES true ${vs_tool_path}/*)

    list(SORT msvc_versions ORDER DESCENDING)
    list(GET msvc_versions 0 msvc_version)
    set(msvc_compiler ${msvc_version}/bin/Hostx64/x64/cl.exe)
    set(nmake_path ${msvc_version}/bin/Hostx64/x64/nmake.exe)
    if(EXISTS ${msvc_compiler})
        message(STATUS "[toolchain] found the compiler : ${msvc_compiler}")
    else()
        message(WARNING "[toolchain] failed to found the compiler.")
    endif()
else()
    message(FATAL_ERROR "failed to find VS path")
endif()

set(CMAKE_C_COMPILER "${msvc_compiler}")
set(CMAKE_CXX_COMPILER "${msvc_compiler}")

set(CMAKE_MAKE_PROGRAM "${nmake_path}")
set(CMAKE_GENERATOR "NMake Makefiles")