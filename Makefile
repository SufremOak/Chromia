# Set default values for arguments (can be overridden via command-line)
BUILD_TYPE ?= debug
TARGET ?= chromia
RUST_BUILD = cargo build

# Installation Mode
INSTALL_MODE ?= full

# Compiler and Linker settings
ifeq ($(BUILD_TYPE),release)
    CFLAGS = -Wall -O2 -g
    CXXFLAGS = -Wall -O2 -g
else
    CFLAGS = -Wall -g
    CXXFLAGS = -Wall -g
endif

LDFLAGS =

# Define subdirectories
SUBDIRS = libs gui runtime sources src

# C, C++ and Objective-C source files
C_SOURCES = $(wildcard runtime/*.c sources/*.c)
CXX_SOURCES = $(wildcard sources/*.cpp)
M_SOURCES = $(wildcard sources/*.m gui/*.m)
H_FILES = $(wildcard libs/*.h)

# Object files
C_OBJECTS = $(C_SOURCES:.c=.o)
CXX_OBJECTS = $(CXX_SOURCES:.cpp=.o)
M_OBJECTS = $(M_SOURCES:.m=.o)

# Main build rule (default to building the target)
.DEFAULT_GOAL := all

# Main target
all: $(TARGET)

# Build the final executable
$(TARGET): $(C_OBJECTS) $(CXX_OBJECTS) $(M_OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $^

# C source files compilation rule
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# C++ source files compilation rule
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

# Objective-C source files compilation rule
%.o: %.m
	$(CC) -ObjC $(CFLAGS) -c -o $@ $<

# Rust build rule (can be executed with 'make rust')
rust:
	$(RUST_BUILD)

# Clean all generated files
clean:
	rm -f $(C_OBJECTS) $(CXX_OBJECTS) $(M_OBJECTS) $(TARGET)

# Clean specific submodule
clean-runtime:
	cd runtime && make clean

clean-libs:
	cd libs && make clean

clean-sources:
	cd sources && make clean

# Create submodules
create-submodules:
	for dir in $(SUBDIRS); do \
		if [ -f $$dir/Makefile ]; then \
			echo "Entering $$dir"; \
			make -C $$dir; \
		fi \
	done

# Run the project (optional)
run:
	./$(TARGET)

# Build with specific target and type (debug or release)
build:
	$(MAKE) BUILD_TYPE=$(BUILD_TYPE) $(TARGET)

# Install the project based on the selected installation mode
install: all
	@echo "Installing Chromia in $(INSTALL_MODE) mode..."

	# Create target directories
	mkdir -p /usr/local/Chromia/{Library,Applications,nix/bin,nix/usr/{local,bin}} ~/.chromia

	# Install based on the mode
ifeq ($(INSTALL_MODE), lib-only)
	@echo "Installing libraries only..."
	cp -r libs /usr/local/Chromia/Library/
endif

ifeq ($(INSTALL_MODE), minimal)
	@echo "Installing minimal files..."
	cp $(TARGET) /usr/local/Chromia/Applications/
endif

ifeq ($(INSTALL_MODE), full)
	@echo "Installing full setup..."
	# Install Libraries
	cp -r libs /usr/local/Chromia/Library/
	# Install Executables
	cp $(TARGET) /usr/local/Chromia/Applications/
	# Install Nix binaries
	cp nix/* /usr/local/Chromia/nix/bin/
	# Install Nix user files
	cp -r nix/usr/* /usr/local/Chromia/nix/usr/
	# Install User files
	cp -r sources/* ~/.chromia/
endif

ifeq ($(INSTALL_MODE), runtime-only)
	@echo "Installing runtime files only..."
	# Install runtime files (libraries and runtime executables)
	cp -r libs /usr/local/Chromia/Library/
	cp $(TARGET) /usr/local/Chromia/Applications/
	cp nix/* /usr/local/Chromia/nix/bin/
	cp -r nix/usr/* /usr/local/Chromia/nix/usr/
endif

	@echo "Chromia installed successfully in $(INSTALL_MODE) mode!"

# Build the target with specific options
.PHONY: clean clean-runtime clean-libs clean-sources rust create-submodules run build install

