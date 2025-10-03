project(prac_20Project)

cmake_minimum_required(VERSION 3.13)

set (CMAKE_CXX_STANDARD 23)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(${CMAKE_SOURCE_DIR}/include/*.h)
include_directories(${CMAKE_SOURCE_DIR}/include/*.hpp)

add_executable(server ${CMAKE_SOURCE_DIR}/src/server.cpp ${CMAKE_SOURCE_DIR}/src/DataStructure.cpp)
add_executable(client ${CMAKE_SOURCE_DIR}/src/client.cpp ${CMAKE_SOURCE_DIR}/src/DataStructure.cpp)

target_include_directories(server PUBLIC ${CMAKE_SOURCE_DIR}/include/)
target_include_directories(client PUBLIC ${CMAKE_SOURCE_DIR}/include/)
