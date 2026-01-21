#!/bin/bash

PROJECT=${FOLDER}

echo "Creating full Variables & Expressions practice project..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Public header
# =====================
cat <<EOF > $PROJECT/include/mode.hpp
#pragma once

void show_mode();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/mode.cpp
#include <iostream>
#include "mode.hpp"

void show_mode()
{
#ifdef MODE_FAST
    std::cout << "FAST mode selected" << std::endl;
#else
    std::cout << "SAFE mode selected" << std::endl;
#endif

#ifdef ENABLE_LOG
    std::cout << "Logging enabled" << std::endl;
#else
    std::cout << "Logging disabled" << std::endl;
#endif
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "mode.hpp"

int main()
{
    show_mode();
    return 0;
}
EOF

# =====================
# With CMake for docker  (YOU WRITE ALL)
# =====================
touch $PROJECT/CMakeLists.txt
cat <<'EOF' > $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)

project(CMAKE_PRAC_13)

message("USER = $ENV{user}")

set(INC_DIR ${CMAKE_SOURCE_DIR}/include)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/output)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/library)

file(GLOB OUTPUT_DIR ${CMAKE_SOURCE_DIR}/build/output)
set(LIB_DIR ${CMAKE_SOURCE_DIR}/build/library)

# variable from cmkae 
set(MODE "SLOW" CACHE STRING "By default set to SLOW")

if(MODE STREQUAL FAST)
option(MODE_FAST "On is set " ON)
else()
option(MODE_FAST "On is set " OFF)
endif()

set(ENABLE_LOG "OFF" CACHE STRING "By default OFF" )

if(ENABLE_LOG STREQUAL ONN)
option(ENABLE_LOG  "Enable log is by default set to ON" ON)
else()
option(ENABLE_LOG  "Enable log is by default set to OFF" OFF)
endif()

add_subdirectory(lib)
add_subdirectory(app)
EOF

touch $PROJECT/lib/CMakeLists.txt
cat<<'EOF' > $PROJECT/lib/CMakeLists.txt
add_library(mode_so SHARED mode.cpp)
add_library(mode_a STATIC mode.cpp)

set_target_properties(mode_so PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})
set_target_properties(mode_a PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})

target_include_directories(mode_so PUBLIC ${INC_DIR})
target_include_directories(mode_a PUBLIC ${INC_DIR})

if(ENABLE_LOG)
target_compile_definitions(mode_so PUBLIC ENABLE_LOG)
else()
target_compile_definitions(mode_a PUBLIC ENABLE_LOG_OFF)
endif()

if(MODE_FAST)
target_compile_definitions(mode_so PUBLIC MODE_FAST)
else()
target_compile_definitions(mode_a PUBLIC MODE_FAST_OFF)
endif()

target_compile_options(mode_so PUBLIC -Wall)

EOF
touch $PROJECT/app/CMakeLists.txt
cat<<'EOF'> $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})

set_target_properties(output PROPERTIES BUILD_RPATH ${LIB_DIR})

target_link_libraries(output PRIVATE mode_so)

EOF

echo "Project created successfully!"
echo
echo "Your CMake tasks:"
echo "1) In parent CMakeLists.txt:"
echo "   - Define a STRING cache variable MODE (SAFE / FAST)"
echo "   - Define a BOOL option ENABLE_LOG"
echo "   - Print both values using message(STATUS ...)"
echo
echo "2) In lib/CMakeLists.txt:"
echo "   - Create a library from mode.cpp"
echo "   - Add include directory correctly"
echo "   - If MODE == FAST -> define MODE_FAST"
echo "   - If ENABLE_LOG ON -> define ENABLE_LOG"
echo "   - Choose PRIVATE / PUBLIC scopes correctly"
echo
echo "3) In app/CMakeLists.txt:"
echo "   - Create executable"
echo "   - Link the library"
echo
echo "Test with:"
echo "  cmake .."
echo "  cmake -DMODE=FAST .."
echo "  cmake -DENABLE_LOG=ON .."
echo "  cmake -DMODE=FAST -DENABLE_LOG=ON .."
