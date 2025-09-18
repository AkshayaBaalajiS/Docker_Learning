project(Server_Client_Socket)

cmake_minimum_required(VERSION 3.13)

set (CMAKE_CXX_STANDARD 23)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(client ${CMAKE_SOURCE_DIR}/src/clinet.cpp)
add_executable(server ${CMAKE_SOURCE_DIR}/src/server.cpp)