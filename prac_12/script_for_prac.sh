#!/bin/bash

PROJECT=${DIR_NAME}

echo "Creating Practice 10 (target_include_directories)..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Public header
# =====================
cat <<EOF > $PROJECT/include/math_utils.hpp
#pragma once

int add(int a, int b);
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/math_utils.cpp
#include "math_utils.hpp"

int add(int a, int b)
{
    return a + b;
}
EOF

# =====================
# App source
# =====================
cat <<EOF > $PROJECT/app/main.cpp
#include <iostream>
#include "math_utils.hpp"

int main()
{
    std::cout << "Sum = " << add(3, 5) << std::endl;
    return 0;
}
EOF

# =====================
# Empty CMakeLists (YOU write logic)
# =====================
touch $PROJECT/CMakeLists.txt

cat <<'EOF' >  $PROJECT/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)

project(CMAKE_PRAC_13)

message("No include_directories in the cmake cause we are using the target_include_directories")

set(GLOB_PATH ${CMAKE_SOURCE_DIR})

set(OUTPUT_PATH ${CMAKE_SOURCE_DIR}/build)

#file(LIB_PATH GLOB ${CMAKE_SOURCE_DIR}/build)
file(GLOB LIB_PATH  ${CMAKE_SOURCE_DIR}/build)
#set(LIB_PATH  ${CMAKE_SOURCE_DIR}/build)

add_subdirectory(lib)

add_subdirectory(app)

EOF

touch $PROJECT/lib/CMakeLists.txt

cat <<'EOF' > $PROJECT/lib/CMakeLists.txt
add_library(math_utils SHARED math_utils.cpp)
add_library(math_utils_sta STATIC math_utils.cpp)

set_target_properties(math_utils PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_PATH} )


#set_target_properties(math_utils PROPERTIES LIBRARY_OUTPUT_DIRECTORY LIB_PATH )
#for the above command we are not using the ${} path to be given so a directory is created on that name and the exe is put there 


target_include_directories(math_utils PUBLIC ${GLOB_PATH}/include)
target_include_directories(math_utils_sta PUBLIC ${GLOB_PATH}/include)

EOF
touch $PROJECT/app/CMakeLists.txt

cat<<'EOF' > $PROJECT/app/CMakeLists.txt
add_executable(output main.cpp)

#set_target_properties(output PROPERTIES RUILD_RPATH LIB_PATH)
#for the above command we are not using the ${} path to be given so a directory is created on that name and the exe is put there 

set_target_properties(output PROPERTIES RUILD_RPATH ${LIB_PATH})
set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_PATH})


#set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY OUTPUT_PATH)
#for the above command we are not using the ${} path to be given so a directory is created on that name and the exe is put there 

target_link_libraries(output math_utils )

target_include_directories(output PUBLIC ${GLOB_PATH}/include)

EOF
echo "Practice 10 setup complete!"
echo
echo "Your tasks:"
echo "1) Create a library from math_utils.cpp"
echo "2) Use target_include_directories() correctly"
echo "3) Decide PRIVATE vs PUBLIC scope for include/"
echo "4) Build and run successfully"
