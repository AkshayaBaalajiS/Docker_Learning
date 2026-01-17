#!/bin/bash

PROJECT=prac_9

echo "Creating Practice 9 - Example 2 (FAST vs SAFE mode)..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Header
# =====================
cat <<EOF > $PROJECT/include/algorithm.hpp
#pragma once

void run_algorithm();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/algorithm.cpp
#include <iostream>
#include "algorithm.hpp"

void run_algorithm()
{
#ifdef FAST_MODE
    std::cout << "Using FAST algorithm" << std::endl;
#else
    std::cout << "Using SAFE algorithm" << std::endl;
#endif
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "algorithm.hpp"

int main()
{
    run_algorithm();
    return 0;
}
EOF

# =====================
# Empty CMakeLists (YOU write)
# =====================
touch $PROJECT/CMakeLists.txt

cat <<'EOF'> $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)

project(CMAKE_PRAC_9_II)

include_directories(${CMAKE_SOURCE_DIR}/include)

set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/build)

file(GLOB LIB_DIR ${CMAKE_BINARY_DIR})

option(FAST_MODE "By default ON" ON )

message("MACRO FAST_MODE = ${FAST_MODE}")

message("USER using this  = $ENV{user}" )

add_subdirectory(lib)


add_subdirectory(app)

EOF

touch $PROJECT/lib/CMakeLists.txt

cat <<'EOF'> $PROJECT/lib/CMakeLists.txt
add_library(algo SHARED algorithm.cpp)

set_target_properties(algo PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})

if(FAST_MODE)
target_compile_definitions(algo PUBLIC FAST_MODE)
endif()
EOF

touch $PROJECT/app/CMakeLists.txt

cat <<'EOF' > $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})
set_target_properties(output PROPERTIES BUILD_RPATH ${LIB_DIR})

target_link_libraries(output algo)
EOF


echo "Project created successfully!"
echo
echo "Your tasks:"
echo "1) Create an option to enable FAST_MODE"
echo "2) Apply the macro in lib/CMakeLists.txt"
echo "3) Decide PUBLIC vs PRIVATE correctly"
echo "4) Build with and without -D flag"
