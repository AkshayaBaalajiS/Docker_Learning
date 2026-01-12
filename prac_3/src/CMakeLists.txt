cmake_minimum_required(VERSION 3.10)

#file (GLOB cpp_files ${CMAKE_SOURCE_DIR}/src/*.cpp)
file (GLOB cpp_files *.cpp)

add_executable(output ${cpp_files})

set_target_properties(output PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
)


# On comming to child cmkae does the below 
#RUNTIME_OUTPUT_DIRECTORY = CMAKE_CURRENT_BINARY_DIR  (build/src/)

# so the global output setting / properties will not work here 
