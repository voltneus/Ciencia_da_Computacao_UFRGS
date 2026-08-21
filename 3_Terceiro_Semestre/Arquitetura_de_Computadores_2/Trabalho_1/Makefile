# ==============================================================================
# Makefile - Simulador de Memória Cache (Arquitetura II - UFRGS)
# ==============================================================================

CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O3

ifeq ($(OS),Windows_NT)
    TARGET = cache_sim.exe
    TEST_TARGET = cache_tests.exe
    RM = del /Q /F
else
    TARGET = cache_sim
    TEST_TARGET = cache_tests
    RM = rm -f
endif

.PHONY: all test run clean

all: $(TARGET) $(TEST_TARGET)

$(TARGET): Cache_INF01112.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

$(TEST_TARGET): Cache_INF01112_Tests.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

run: $(TARGET)
	./$(TARGET)

test: $(TEST_TARGET)
	./$(TEST_TARGET)

clean:
	$(RM) $(TARGET) $(TEST_TARGET)
