# Minimum CMake version
cmake_minimum_required(VERSION 3.16)

# Project name and version
project(jaks VERSION 0.1 LANGUAGES CXX)

# Set C++ standard to C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Specify the compiler (optional if default clang is ok)
# set(CMAKE_CXX_COMPILER /usr/bin/clang++)

# Add an executable target for the main project
add_executable(jaks src/main.cpp)

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
