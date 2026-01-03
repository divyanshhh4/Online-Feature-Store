cmake_minimum_required(VERSION 3.16)
project(OnlineFeatureStore VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Compiler warnings and optimizations
if(MSVC)
    add_compile_options(/W4 /WX-)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
    
    # Optimization flags for Release
    set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
    set(CMAKE_CXX_FLAGS_DEBUG "-g -O0")
endif()

# Threading support
find_package(Threads REQUIRED)

# Core library (header-only for now)
add_library(feature_store_core INTERFACE)
target_include_directories(feature_store_core INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)
target_link_libraries(feature_store_core INTERFACE Threads::Threads)

# Example executable
add_executable(feature_store_example
    src/main.cpp
)
target_link_libraries(feature_store_example PRIVATE feature_store_core)

# Installation rules
install(TARGETS feature_store_example DESTINATION bin)
install(DIRECTORY src/core DESTINATION include/feature_store FILES_MATCHING PATTERN "*.h")
