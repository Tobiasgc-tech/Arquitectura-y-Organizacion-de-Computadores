#include <stdio.h>

int global = 42;

int main() {
    int global = 10;

    printf("Variable global: %d\n", global);
    printf("Variable local: %d\n", global);

    return 0;
}