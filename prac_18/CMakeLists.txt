project(SocketProgram)

cmake_minimum_required(VERSION 3.13)

set (CMAKE_CXX_STANDARD 20)
set (CMAKE_CXX_STANDARD_REQUIRED ON)


include_directories(${CMAKE_SOURCE_DIR}/include)


add_executable(server ${CMAKE_SOURCE_DIR}/src/server.cpp)
add_executable(client ${CMAKE_SOURCE_DIR}/src/clinet.cpp)

#target_include_directories(server PUBLIC ${CMAKE_SOURCE_DIR}/include)
#target_include_directories(client PUBLIC ${CMAKE_SOURCE_DIR}/include)
