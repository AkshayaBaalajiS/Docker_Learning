#!/bin/bash

PROJECT=prac_7

echo "Creating Practice 7 (Shared Library + RPATH) structure..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Header
# =====================
cat <<EOF > $PROJECT/include/logger.hpp
#pragma once

void log_message();
EOF

# =====================
# Shared library source
# =====================
cat <<EOF > $PROJECT/lib/logger.cpp
#include <iostream>
#include "logger.hpp"

void log_message()
{
    std::cout << "Logger from shared library" << std::endl;
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include "logger.hpp"

int main()
{
    log_message();
    return 0;
}
EOF

# =====================
# CMakeLists (you write logic)
# =====================
touch $PROJECT/CMakeLists.txt

cat <<'EOF' > $PROJECT/CMakeLists.txt

cmake_minimum_required(VERSION 3.19)

project(CMAKE_PRAC7)

set (OUTPUT_LOC ${CMAKE_BINARY_DIR})

include_directories(${CMAKE_SOURCE_DIR}/include)

add_subdirectory(lib)

add_subdirectory(app)

EOF

touch $PROJECT/lib/CMakeLists.txt

cat <<'EOF' > $PROJECT/lib/CMakeLists.txt
add_library(logger SHARED logger.cpp)


# fkor understanding the export zi am commenting this cause the exe and the lib are in ssame dir so no issue arraises 
#set_target_properties(logger PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_LOC})

#Linux dynamic loader rule (VERY IMPORTANT):

#The loader always searches the executable’s directory FIRST

EOF

touch $PROJECT/app/CMakeLists.txt
cat <<'EOF' > $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp )

#set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_LOC})
set_target_properties(output PROPERTIES BUILD_RPATH ${OUTPUT_LOC}/lib)

target_link_libraries(output logger)

# use this on the exe to list the lib it linked 
# readelf -d app/output | grep -i path

EOF

echo "Practice 7 setup complete!"
echo "Your tasks:"
echo "  - Build SHARED library"
echo "  - Build executable"
echo "  - Link them"
echo "  - Make executable run WITHOUT exporting LD_LIBRARY_PATH"
echo " -- CMAKE content added in script "

echo "Enjoy Docker Learning "
