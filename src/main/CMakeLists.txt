cmake_minimum_required(VERSION 3.13)
project(Main)

# 设置源文件路径
aux_source_directory(${ROOT_DIR}/src/funcs SRC_LIST)
aux_source_directory(${ROOT_DIR}/src/tests TEST_LIST)

# 查找 gtest 和 gmock 库
find_library(gtestlib libgtest.a ${ROOT_DIR}/lib)
find_library(gmocklib libgmock.a ${ROOT_DIR}/lib)

# 设置包含目录
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/../../include")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/../tests") # 包含 gtest 和 gmock

set(EXECUTABLE_OUTPUT_NAME RES)

# 添加可执行目标
add_executable(${EXECUTABLE_OUTPUT_NAME} main.cpp ${SRC_LIST} ${TEST_LIST})

# 链接库文件
target_link_libraries(${EXECUTABLE_OUTPUT_NAME} ${gtestlib} ${gmocklib})

if(ENABLE_COVERAGE)
    # 启用代码覆盖率选项
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage")
endif()

# 输出调试信息
message(STATUS "Source list: ${SRC_LIST}")
message(STATUS "Test list: ${TEST_LIST}")

# 设置可执行文件输出路径
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)

# 设置调试模式和代码覆盖率选项
set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_CXX_FLAGS_DEBUG "-g -Wall -O0")

option(ENABLE_COVERAGE "Use gcov" OFF)
message(STATUS "ENABLE_COVERAGE=${ENABLE_COVERAGE}")
