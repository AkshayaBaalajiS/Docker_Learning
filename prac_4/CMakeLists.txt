cmake_minimum_required(VERSION 3.19)

project(CMAKE_PARC6)

#file(GLOB SOURCE_DIR ${CMAKE_SOURCE_DIR})
set( SOURCE_DIR ${CMAKE_SOURCE_DIR})
include_directories(${SOURCE_DIR}/include)

add_subdirectory(lib)

add_subdirectory(app)

