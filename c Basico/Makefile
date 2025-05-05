CC = gcc
CFLAGS = -Wall -Wextra -pedantic -Wunused-but-set-parameter
TARGET = Ejercicio18

all: $(TARGET)

$(TARGET): Ejercicio18.o
		$(CC) $(CFLAGS) $^ -o $@

Ejercicio18.o: Ejercicio18.c
			$(CC) $(CFLAGS) -c $< -o $@

clan:
		rm *.o $(TARGET)

.PHONY: all clan