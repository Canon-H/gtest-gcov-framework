cmake_minimum_required(VERSION 3.13)
project(test)

set(ROOT_DIR ${CMAKE_SOURCE_DIR}) #设置 ROOT_DIR 用于存储 CMAKE_SOURCE_DIR

add_subdirectory(src/main)#执行src/main中的CMakeLists.txt
