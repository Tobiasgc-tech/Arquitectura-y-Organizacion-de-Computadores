#include <stdio.h>
int factorial(int n);

int main(void) {
    int numero;
    printf("Ingrese un numero: ");
    scanf("%d", &numero);
    printf("El factorial es: %d\n", factorial(numero));
    return 0;
}

int factorial(int n){
    int res = 1;
    while (n > 0)
    {
        res *= n;
        n--;
    }
    return res;
}