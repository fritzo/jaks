# Directories
BUILD_DIR = build

# Target to build everything using CMake
all: $(BUILD_DIR)/Makefile
	$(MAKE) -C $(BUILD_DIR)

# Generate Makefile using CMake
$(BUILD_DIR)/Makefile:
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake ..

# Run tests
test: all
	$(MAKE) -C $(BUILD_DIR) test

# Target to format code using clang-format
format:
	find src test include -name '*.cpp' -o -name '*.hpp' | xargs clang-format -i

# Target to lint code using clang-tidy
lint:
	find src test include -name '*.cpp' -o -name '*.hpp' | xargs clang-tidy

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all format lint test clean
