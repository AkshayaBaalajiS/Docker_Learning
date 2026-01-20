#!/bin/bash

PROJECT=prac_12

echo "Creating Practice 12 (target_compile_options)..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Public header
# =====================
cat <<EOF > $PROJECT/include/warnings.hpp
#pragma once

void do_task();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/warnings.cpp
#include <iostream>
#include "warnings.hpp"

void do_task()
{
    int unused_var = 42; // will trigger warning with -Wall
    std::cout << "Task done" << std::endl;
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "warnings.hpp"

int main()
{
    do_task();
    return 0;
}
EOF

# =====================
# Empty CMakeLists (YOU write logic)
# =====================
cat <<'EOF' > $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)

project(CMAKE_PROJ13)

# we are not using the include_directory cause we are using the target_include_directories 

set(INC_DIR ${CMAKE_SOURCE_DIR}/include)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/output)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/library)

file(GLOB OUTPUT_DIR ${CMAKE_SOURCE_DIR}/build/output)
set(LIB_DIR ${CMAKE_SOURCE_DIR}/build/library)

add_subdirectory(lib)
add_subdirectory(app)

EOF

cat <<'EOF' > $PROJECT/lib/CMakeLists.txt
add_library(warnings SHARED warnings.cpp)
add_library(warnings_sta STATIC warnings.cpp)

set_target_properties(warnings PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})

target_compile_options(warnings PUBLIC -Wall -Wextra -Wunused-variable)
#-Wall → enable common warnings

target_include_directories(warnings PRIVATE ${INC_DIR})
target_include_directories(warnings_sta PRIVATE ${INC_DIR})
EOF

cat<< 'EOF' >  $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

target_include_directories(output PRIVATE ${INC_DIR} )
# we are including the dir to output exe  

set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})

target_link_libraries(output warnings)

#cmake treat the above as 
# target_link_libraries(output PRIVATE warnings) 
EOF


echo "Practice 12 setup complete!"
echo
echo "Your tasks:"
echo "1) Create a library from warnings.cpp"
echo "2) Add compiler warnings using target_compile_options()"
echo "3) Decide PRIVATE vs PUBLIC correctly"
echo "4) Build and observe warnings"
