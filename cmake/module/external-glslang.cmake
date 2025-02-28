# ----- variable -----
set(GLSLANG_REPO "https://github.com/KhronosGroup/glslang.git")
set(GLSLANG_TAG "SPIR-V_1.5")
set(glslang_root_dir "${CMAKE_SOURCE_DIR}/temp")
set(glslang_build_dir "${glslang_root_dir}/glslang")
set(GLSLANG_BUILD_DIR "${glslang_build_dir}/build")
set(DEST_DIR "${CMAKE_SOURCE_DIR}/bin")

# ===== 1. glslang 저장소 클론 (태그 기준) =====
if(NOT EXISTS ${glslang_build_dir})
  file(MAKE_DIRECTORY ${glslang_root_dir})
  execute_process(
    COMMAND git clone --branch ${GLSLANG_TAG} --single-branch ${GLSLANG_REPO} ${glslang_build_dir}
    WORKING_DIRECTORY ${glslang_root_dir}
    RESULT_VARIABLE CLONE_RESULT
    OUTPUT_VARIABLE CLONE_OUTPUT
    ERROR_VARIABLE CLONE_ERROR
    TIMEOUT 300
  )
  if(NOT CLONE_RESULT EQUAL 0)
    message(FATAL_ERROR "Git 클론 실패: ${CLONE_ERROR}")
  else()
    message(STATUS "Git 클론 성공: ${CLONE_OUTPUT}")
  endif()
endif()

# ===== 2. glslang 빌드 디렉토리 생성 및 CMake 구성 =====
file(MAKE_DIRECTORY ${GLSLANG_BUILD_DIR})

execute_process(
  COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} ..
  WORKING_DIRECTORY ${GLSLANG_BUILD_DIR}
  RESULT_VARIABLE CONFIG_RESULT
  OUTPUT_VARIABLE CONFIG_OUTPUT
  ERROR_VARIABLE CONFIG_ERROR
  TIMEOUT 300
)
if(NOT CONFIG_RESULT EQUAL 0)
  message(FATAL_ERROR "CMake 구성 실패: ${CONFIG_ERROR}")
else()
  message(STATUS "CMake 구성 성공: ${CONFIG_OUTPUT}")
endif()

# ===== 3. glslangValidator 타겟만 빌드 =====
execute_process(
  COMMAND ${CMAKE_COMMAND} --build . --target glslangValidator --config ${CMAKE_BUILD_TYPE}
  WORKING_DIRECTORY ${GLSLANG_BUILD_DIR}
  RESULT_VARIABLE BUILD_RESULT
  OUTPUT_VARIABLE BUILD_OUTPUT
  ERROR_VARIABLE BUILD_ERROR
  TIMEOUT 300
)
if(NOT BUILD_RESULT EQUAL 0)
  message(FATAL_ERROR "glslangValidator 빌드 실패: ${BUILD_ERROR}")
else()
  message(STATUS "glslangValidator 빌드 성공: ${BUILD_OUTPUT}")
endif()

# ===== 4. 빌드 산출물(glslangValidator 실행 파일) 복사 =====
if(WIN32)
  set(SRC_EXE "${GLSLANG_BUILD_DIR}/StandAlone/${CMAKE_BUILD_TYPE}/glslangValidator.exe")
  set(DEST_EXE "${DEST_DIR}/glslangValidator.exe")
else()
  set(SRC_EXE "${GLSLANG_BUILD_DIR}/StandAlone/${CMAKE_BUILD_TYPE}/glslangValidator")
  set(DEST_EXE "${DEST_DIR}/glslangValidator")
endif()

file(MAKE_DIRECTORY ${DEST_DIR})

execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy ${SRC_EXE} ${DEST_DIR}/glslangValidator.exe
  RESULT_VARIABLE COPY_RESULT
  OUTPUT_VARIABLE COPY_OUTPUT
  ERROR_VARIABLE COPY_ERROR
)
if(NOT COPY_RESULT EQUAL 0)
  message(FATAL_ERROR "glslangValidator 복사 실패: ${COPY_ERROR}")
else()
  message(STATUS "glslangValidator가 ${DEST_DIR}로 복사되었습니다.")
endif()
