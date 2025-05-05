#include <stdio.h>
int main() {
    int a = 5;
    int b = 3;
    int c = 2;
    int d = 1;

    int resultado1 = a + b * c / d;
    int resultado2 = a % b;
    int resultado3 = a == b;
    int resultado4 = a != b;
    int resultado5 = a & b;
    int resultado6 = a | b;
    int resultado7 = ~a;
    int resultado8 = a && b;
    int resultado9 = a || b;
    int resultado10 = a << 1;
    int resultado11 = a >> 1;
    int resultado12 = a +=b;

    printf("resultado1: %x \n", resultado1);
    printf("resultado2: %x \n", resultado2);
    printf("resultado3: %x \n", resultado3);
    printf("resultado4: %x \n", resultado4);
    printf("resultado5: %x \n", resultado5);
    printf("resultado6: %x \n", resultado6);
    printf("resultado7: %x \n", resultado7);
    printf("resultado8: %x \n", resultado8);
    printf("resultado9: %x \n", resultado9);
    printf("resultado10: %x \n", resultado10);
    printf("resultado11: %x \n", resultado11);
    printf("resultado12: %x \n", resultado12);

    return 0;
}