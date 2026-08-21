# ==============================================================================
# Makefile - Lista Encadeada Simples (Estrutura de Dados - UFRGS)
# ==============================================================================

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g

ifeq ($(OS),Windows_NT)
    TARGET = lista_encadeada_simples.exe
    RM = del /Q /F
else
    TARGET = lista_encadeada_simples
    RM = rm -f
endif

SRCS = lista_encadeada_simples.c
OBJS = $(SRCS:.c=.o)

.PHONY: all run clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	$(RM) $(OBJS) $(TARGET)
