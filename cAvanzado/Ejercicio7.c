#include <stdio.h>
void swap(int *a, int *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
    }
int main() {
    int x = 10, y = 20;
    swap(&x, &y);
    printf("x: %d, y: %d\n", x, y);
    }