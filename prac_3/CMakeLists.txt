cmake_minimum_required(VERSION 3.10)

PROJECT(CMake_Level1_prac3)

include_directories(${CMAKE_SOURCE_DIR}/include)

#set(CMAKE_OUT_DIR ${CMAKE_BINARY_DIR})
# the above line will not make the exe on the build it is setting a var only 

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

message("Output Dir set to ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

add_subdirectory(${CMAKE_SOURCE_DIR}/src)