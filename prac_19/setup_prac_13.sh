#!/bin/bash

PROJECT=${user}

echo "Creating Practice 13 (Generator Expressions)..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Public header
# =====================
cat <<EOF > $PROJECT/include/feature.hpp
#pragma once

void show_mode();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/feature.cpp
#include <iostream>
#include "feature.hpp"

void show_mode()
{
#ifdef DEBUG_MODE
    std::cout << "DEBUG mode enabled" << std::endl;
#else
    std::cout << "RELEASE mode enabled" << std::endl;
#endif

#ifdef GNU_COMPILER
    std::cout << "Compiled with GCC" << std::endl;
#endif
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "feature.hpp"

int main()
{
    show_mode();
    return 0;
}
EOF

# =====================
# Empty CMakeLists (YOU write logic)
# =====================
touch $PROJECT/CMakeLists.txt
cat<<'EOF' > $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.10)

project(CMAKE_PRAC15)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/output)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/library)

set(INC_DIR ${CMAKE_SOURCE_DIR}/include)

set(ALGO_MODE "RELEASE_MODE" CACHE STRING "By default Set to RELEASE_MODE")

if(ALGO_MODE STREQUAL "RELEASE_MODE")
option(DEBUG_MODE "Set to OFF " OFF)
endif()

if(ALGO_MODE STREQUAL "DEBUG_MODE")
option(DEBUG_MODE "Set to ON " ON)
endif()

option(GNU_COMPILER "By default OFF " OFF)


set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/build/output)

file(GLOB LIB_DIR  ${CMAKE_SOURCE_DIR}/build/library)

add_subdirectory(lib)

add_subdirectory(app)

EOF
touch $PROJECT/lib/CMakeLists.txt
cat<<'EOF' >  $PROJECT/lib/CMakeLists.txt
add_library(feature_sha SHARED feature.cpp)
add_library(feature_sta STATIC feature.cpp)

set_target_properties(feature_sha PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})
set_target_properties(feature_sta PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})

target_include_directories(feature_sha PUBLIC ${INC_DIR})
target_include_directories(feature_sta PUBLIC ${INC_DIR})

if(DEBUG_MODE)
target_compile_definitions(feature_sha PUBLIC DEBUG_MODE)
endif()
EOF
touch $PROJECT/app/CMakeLists.txt
cat<<'EOF' > $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})

set_target_properties(output PROPERTIES BUILD_RPATH ${LIB_DIR})

target_link_libraries(output PRIVATE feature_sha)
EOF

echo "Practice 13 setup complete!"
echo
echo "Your tasks:"
echo "1) Use generator expressions to define DEBUG_MODE only in Debug builds"
echo "2) Define GNU_COMPILER only when using GCC"
echo "3) Do NOT use if() for these conditions"
echo "4) Use target_compile_definitions() with generator expressions"
