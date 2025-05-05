CC = gcc
CFLAGS = -Wall -Wextra -pedantic -Wunused-but-set-parameter
TARGET = Ejercicio12

all: $(TARGET)

$(TARGET): Ejercicio12.o
		$(CC) $(CFLAGS) $^ -o $@

Ejercicio12.o: Ejercicio12.c
			$(CC) $(CFLAGS) -c $< -o $@

clan:
		rm *.o $(TARGET)

.PHONY: all clan