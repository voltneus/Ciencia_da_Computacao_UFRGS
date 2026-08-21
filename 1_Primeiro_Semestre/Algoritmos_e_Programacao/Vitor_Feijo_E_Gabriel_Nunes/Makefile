# ==============================================================================
# Makefile para o Jogo 2D (Raylib) - Algoritmos e Programação (UFRGS)
# ==============================================================================

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O2

# Detecção do Sistema Operacional
ifeq ($(OS),Windows_NT)
    LDFLAGS = -lraylib -lopengl32 -lgdi32 -lwinmm
    TARGET = jogo.exe
    RM = del /Q /F
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
        LDFLAGS = -lraylib -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo
    else
        LDFLAGS = -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
    endif
    TARGET = jogo
    RM = rm -f
endif

SRCS = jogo.c funcoes.c
OBJS = $(SRCS:.c=.o)

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(TARGET)

%.o: %.c definicoes.h funcoes.h
	$(CC) $(CFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	$(RM) $(OBJS) $(TARGET)
