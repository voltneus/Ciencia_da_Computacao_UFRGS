# ==============================================================================
# Makefile Geral - Laboratórios de CPD (C++) - UFRGS
# ==============================================================================

CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O2

ifeq ($(OS),Windows_NT)
    EXT = .exe
    RM = del /Q /F
else
    EXT =
    RM = rm -f
endif

TARGETS = Lab1/main$(EXT) Lab2/main$(EXT) Lab3/radixsort$(EXT) Lab4/main$(EXT)

.PHONY: all clean lab1 lab2 lab3 lab4

all: $(TARGETS)

lab1: Lab1/main$(EXT)
lab2: Lab2/main$(EXT)
lab3: Lab3/radixsort$(EXT)
lab4: Lab4/main$(EXT)

Lab1/main$(EXT): Lab1/main.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

Lab2/main$(EXT): Lab2/main.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

Lab3/radixsort$(EXT): Lab3/radixsort.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

Lab4/main$(EXT): Lab4/main.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

clean:
	$(RM) $(TARGETS)
