cmake_minimum_required(VERSION 3.13)
project(PipeProject)


set (CMAKE_CXX_STANDARD 23)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(pipe_out ${CMAKE_SOURCE_DIR}/src/pipe_program.cpp)