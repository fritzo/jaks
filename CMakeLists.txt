# Minimum CMake version
cmake_minimum_required(VERSION 3.16)

# Project name and version
project(jaks VERSION 0.1 LANGUAGES CXX)

# Set C++ standard to C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Enable CCache for faster recompilation
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set(CMAKE_CXX_COMPILER_LAUNCHER ccache)  # For C++ compilation
  set(CMAKE_C_COMPILER_LAUNCHER ccache)    # If you have C sources
endif()

# Use the homebrew-installed libc++ library
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++")

# Enable debug symbols
set(CMAKE_BUILD_TYPE "RelWithDebInfo")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fno-omit-frame-pointer")

# Enable optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -march=native")

# Add an executable target for the main project
add_executable(jaks src/main.cpp)

# Apply strict warnings and Werror only to the jaks target (your project)
target_compile_options(jaks PRIVATE -Wall -Wextra -Wpedantic -Werror)

# Add include directories
target_include_directories(jaks PUBLIC include)

# Enable testing
enable_testing()

# Fetch Catch2 testing framework
include(FetchContent)

FetchContent_Declare(
  catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v3.4.0  # Use a stable release version
)

FetchContent_MakeAvailable(catch2)

# Create a test target with Catch2
add_executable(test_example test/test_example.cpp)

# Link Catch2 with the test target
target_link_libraries(test_example PRIVATE Catch2::Catch2WithMain)

# Register the test with CMake
add_test(NAME ExampleTest COMMAND test_example)
