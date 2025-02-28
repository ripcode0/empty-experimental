# -----------------------------------------------------------------------------
# File: external_install.cmake
# Description: Brief description of the purpose of this file.
#
# Copyright (C) 2024 ripcode0@gmail.com
# All rights reserved.
#
# This script is distributed under the terms of the MIT, which
# permits use, modification, and distribution. See the LICENSE file for details.
# -----------------------------------------------------------------------------

function(external_install)
    cmake_parse_arguments(
        args
        ""
        "GIT_URL;DEST;GIT_TAG;INSTALL_PREFIX;BUILD_TYPE"
        "CMAKE_ARGS"
        ${ARGN}
    )
    set(package_name "")
    if(NOT args_GIT_URL)
        message(FATAL_ERROR "[external_install] Missing required URL parameter.")
    else()
        string(REGEX MATCH "([^/]+)\\.git" match ${args_GIT_URL})
        set(package_name "${CMAKE_MATCH_1}")
        message(STATUS "[external_install] package name : ${package_name}")
    endif()

    if(NOT args_DEST)
        message(STATUS "[external_install] No DEST parameter provided. Using default: ${CMAKE_BINARY_DIR}/download")
        set(args_DEST "${CMAKE_BINARY_DIR}/download")
    endif()

    if(NOT args_GIT_TAG)
        message(FATAL_ERROR "[external_install] Missing required TAG parameter.")
    endif()

    if(NOT args_INSTALL_PREFIX)
        message(FATAL_ERROR "[external_install] Missing required INSTALL_PREFIX parameter. Specify a valid install prefix.")
    endif()

    if(NOT args_BUILD_TYPE)
        set(args_BUILD_TYPE Debug)
    elseif(NOT args_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
        message(FATAL_ERROR "[external_install] Invalid BUILD_TYPE: ${args_BUILD_TYPE}. Supported: Debug, Release, RelWithDebInfo, MinSizeRel.")
    endif()

    if(EXISTS ${args_DEST})
        message(STATUS "[external_install] Removing existing DEST directory: ${args_DEST}")
        file(REMOVE_RECURSE ${args_DEST})
    endif()

    message(STATUS "[external_install] Cloning repository from ${args_GIT_URL}")
    execute_process(
        COMMAND git clone --branch ${args_GIT_TAG} ${args_GIT_URL} ${args_DEST}
        RESULT_VARIABLE clone_result
        OUTPUT_QUIET
        ERROR_VARIABLE clone_error
    )

    if(clone_result)
        message(FATAL_ERROR "[external_install] Failed to clone repository: ${clone_error}")
    endif()

    message(STATUS "[external_install] Configuring build with CMake.")
    execute_process(
        COMMAND cmake -S ${args_DEST} -B ${args_DEST}/build
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_BUILD_TYPE=${args_BUILD_TYPE}
        ${args_CMAKE_ARGS}
        -G "${CMAKE_GENERATOR}"
        RESULT_VARIABLE config_result
        ERROR_VARIABLE config_error
    )

    if(config_result)
        message(FATAL_ERROR "[external_install] CMake configuration failed: ${config_error}")
    endif()

    message(STATUS "[external_install] Building project with CMake.")
    execute_process(
        COMMAND cmake --build ${args_DEST}/build --config ${args_BUILD_TYPE}
        RESULT_VARIABLE build_result
        ERROR_VARIABLE build_error
    )

    if(build_result)
        message(FATAL_ERROR "[external_install] Build failed: ${build_error}")
    endif()

    message(STATUS "[external_install] Installing project to ${args_INSTALL_PREFIX}.")
    execute_process(
        COMMAND cmake --install ${args_DEST}/build --prefix ${args_INSTALL_PREFIX} --config ${args_BUILD_TYPE}
        RESULT_VARIABLE install_result
        ERROR_VARIABLE install_error
    )

    if(install_result)
        message(FATAL_ERROR "[external_install] Installation failed: ${install_error}")
    endif()

    message(STATUS "[external_install] Cleaning up DEST directory: ${args_DEST}")
    if(EXISTS ${args_DEST})
        file(REMOVE_RECURSE ${args_DEST})
    endif()

    message(STATUS "[external_install] Package ${package_name} successfully installed to ${args_INSTALL_PREFIX}.")
endfunction()
