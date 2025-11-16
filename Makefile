CC = g++
CFLAGS = -pthread -I./include
LDFLAGS = -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_mixer

# Source directories
SRC_DIRS := src
# Recursively find all cpp files in subdirectories
SOURCES := $(shell find $(SRC_DIRS) -name "*.cpp")
# Object files go to build directory mirroring source structure
OBJECTS := $(patsubst %.cpp, build/%.o, $(SOURCES))

# Create build folder automatically
BUILD_DIRS := $(sort $(dir $(OBJECTS)))

all: windy

windy: $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

# Rule to compile cpp -> o, creating directories as needed
build/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf build windy
run:
	./windy
