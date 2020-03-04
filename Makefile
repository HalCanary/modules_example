SRCS = src/hello_world.cpp
MAIN_SRC = src/main.cpp

CXXFLAGS = -std=c++2a -fmodules-ts -fimplicit-modules -fprebuilt-module-path=$(BUILD_DIR)/src

CXX = clang++-7

BUILD_DIR = build

PCM_FILES = $(patsubst %.cpp,$(BUILD_DIR)/%.pcm,$(SRCS))
OBJ_FILES = $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(SRCS))

.SECONDARY: $(PCM_FILES) $(OBJ_FILES)

%.o: %.cpp

$(BUILD_DIR)/%.o: %.cpp $(PCM_FILES)
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/%.pcm: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -Xclang -emit-module-interface -o $@

$(BUILD_DIR)/a.out: $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(MAIN_SRC)) $(OBJ_FILES)
	$(CXX) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@
