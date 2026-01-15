#!/bin/bash

PROJECT=scope_example

echo "Creating full PRIVATE / PUBLIC / INTERFACE example..."

mkdir -p $PROJECT/{include,lib,config,app}

# ===============================
# Header (PUBLIC macro example)
# ===============================
cat <<EOF > $PROJECT/include/mylib.hpp
#pragma once
#include <iostream>

/* PUBLIC macro: appears in header */
#ifdef ENABLE_LOG
void log_message();
#endif

void do_work();
EOF

# ===============================
# Library source (PRIVATE macro)
# ===============================
cat <<EOF > $PROJECT/lib/mylib.cpp
#include "mylib.hpp"

/* PRIVATE macro: only in cpp */
#ifdef INTERNAL_DEBUG
static void debug()
{
    std::cout << "Internal debug enabled\\n";
}
#endif

#ifdef ENABLE_LOG
void log_message()
{
    std::cout << "Logging from library\\n";
}
#endif

void do_work()
{
#ifdef INTERNAL_DEBUG
    debug();
#endif
    std::cout << "Doing work\\n";
}
EOF

# ===============================
# App source (uses PUBLIC + INTERFACE)
# ===============================
cat <<EOF > $PROJECT/app/main.cpp
#include "mylib.hpp"

#ifdef USE_FAST_MODE
#define MODE "FAST"
#else
#define MODE "NORMAL"
#endif

int main()
{
#ifdef ENABLE_LOG
    log_message();
#endif

    do_work();

    std::cout << "Mode: " << MODE << std::endl;
    return 0;
}
EOF

# ===============================
# lib/CMakeLists.txt
# ===============================
cat <<'EOF' > $PROJECT/lib/CMakeLists.txt
message("USer = $ENV{user}")
add_library(mylib mylib.cpp)

target_include_directories(mylib PUBLIC
    \${CMAKE_SOURCE_DIR}/include
)

# PRIVATE -> used only in cpp
# PUBLIC  -> used in header + app
target_compile_definitions(mylib
    PRIVATE INTERNAL_DEBUG
    PUBLIC  ENABLE_LOG
)
EOF

# ===============================
# config/CMakeLists.txt (INTERFACE)
# ===============================
cat <<EOF > $PROJECT/config/CMakeLists.txt
add_library(config INTERFACE)

# INTERFACE -> only consumers see this
target_compile_definitions(config INTERFACE USE_FAST_MODE)
EOF

# ===============================
# app/CMakeLists.txt
# ===============================
cat <<EOF > $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

target_link_libraries(output
    mylib
    config
)
EOF

# ===============================
# Parent CMakeLists.txt
# ===============================
cat <<EOF > $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)
project(ScopeExample)
include_directories(include)

add_subdirectory(lib)
add_subdirectory(config)
add_subdirectory(app)
EOF

echo "Project created successfully!"
echo "Build with:"
echo "  cd $PROJECT"
echo "  mkdir build && cd build"
echo "  cmake .. && make"
echo "  ./output"
