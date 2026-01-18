#!/bin/bash

PROJECT=prac_11

echo "Creating Practice 9 (option() + -D flags)..."

mkdir -p $PROJECT/{include,lib,app}

# =====================
# Header
# =====================
cat <<EOF > $PROJECT/include/feature.hpp
#pragma once

void show_features();
EOF

# =====================
# Library source
# =====================
cat <<EOF > $PROJECT/lib/feature.cpp
#include <iostream>
#include "feature.hpp"

void show_features()
{
#ifdef ENABLE_LOG
    std::cout << "Logging ENABLED" << std::endl;
#else
    std::cout << "Logging DISABLED" << std::endl;
#endif

#ifdef ENABLE_DEBUG
    std::cout << "Debug ENABLED" << std::endl;
#else
    std::cout << "Debug DISABLED" << std::endl;
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
    show_features();
    return 0;
}
EOF

# =====================
# Empty CMakeLists (YOU write logic)
# =====================
touch $PROJECT/CMakeLists.txt
touch $PROJECT/lib/CMakeLists.txt
touch $PROJECT/app/CMakeLists.txt

echo "Practice 9 setup complete!"
echo "Your tasks:"
echo "  - Use option() to control ENABLE_LOG and ENABLE_DEBUG"
echo "  - Use target_compile_definitions() (NO add_definitions)"
echo "  - Build with cmake -D flags"
