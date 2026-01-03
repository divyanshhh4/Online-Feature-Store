#!/bin/bash

# Build script for Online Feature Store (WSL/Linux)

set -e

BUILD_TYPE="${1:-Release}"
BUILD_DIR="build"

echo "=== Online Feature Store Build Script ==="
echo "Build type: $BUILD_TYPE"
echo ""

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure with CMake
echo "Configuring..."
cmake -DCMAKE_BUILD_TYPE="$BUILD_TYPE" ..

# Build
echo ""
echo "Building..."
cmake --build . --parallel $(nproc)

echo ""
echo "=== Build Complete ==="
echo "Executable: $BUILD_DIR/feature_store_example"
echo ""
echo "Run with: ./build/feature_store_example"
