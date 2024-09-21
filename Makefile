# Directories
BUILD_DIR = build

# Target to build everything using CMake and Ninja
all: $(BUILD_DIR)/build.ninja
	ninja -C $(BUILD_DIR)

# Generate Ninja build files using CMake
$(BUILD_DIR)/build.ninja:
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake -G Ninja \
		-DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ \
		..

# Install developer tools
develop:
	brew install llvm clang-format ccache ninja

# Run tests
test: all
	cd $(BUILD_DIR) && ctest --output-on-failure

# Target to format code using clang-format
format:
	find src tests include -name '*.cpp' -o -name '*.hpp' | xargs clang-format -i

# Target to lint code using clang-tidy
lint:
	find src tests include -name '*.cpp' -o -name '*.hpp' | xargs clang-tidy

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all develop format lint test clean
