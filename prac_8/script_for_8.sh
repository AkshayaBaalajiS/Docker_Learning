#!/bin/bash

PROJECT=prac_8

echo "Creating Practice 8 (Compile-time macros) structure..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Header
# =====================
cat <<EOF > $PROJECT/include/config.hpp
#pragma once

void show_config();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/config.cpp
#include <iostream>
#include "config.hpp"

void show_config()
{
#ifdef ENABLE_LOG
    std::cout << "Logging ENABLED" << std::endl;
#else
    std::cout << "Logging DISABLED" << std::endl;
#endif

#ifdef DEBUG_MODE
    std::cout << "Debug mode ON" << std::endl;
#else
    std::cout << "Debug mode OFF" << std::endl;
#endif
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "config.hpp"

int main()
{
    show_config();
    return 0;
}
EOF

# =====================
# Empty CMakeLists (you write logic)
# =====================
touch $PROJECT/CMakeLists.txt

cat <<'EOF' > $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.10)

project(CMAKE_PRAC8)

include_directories(${CMAKE_SOURCE_DIR}/include)

set(BUILD_PATH ${CMAKE_BINARY_DIR})

file(GLOB SOURCE_DIR ${BUILD_PATH})

add_definitions(-DENABLE_LOG, -DDEBUG_MODE)

add_subdirectory(lib)

add_subdirectory(app)

EOF

touch $PROJECT/lib/CMakeLists.txt
cat <<'EOF' > $PROJECT/lib/CMakeLists.txt
add_library(config SHARED config.cpp)

set_target_properties(config PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${BUILD_PATH})

EOF

touch $PROJECT/app/CMakeLists.txt
cat <<'EOF' >$PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

set_target_properties(output PROPERTIES BUILD_RPATH ${BUILD_PATH})

target_link_libraries(output config)
EOF

echo "Practice 8 setup complete!"
echo "Your tasks:"
echo "  - Create a library from config.cpp"
echo "  - Create an executable"
echo "  - Control ENABLE_LOG and DEBUG_MODE from CMake"
echo "  - DO NOT change C++ code"
