#include <stdio.h>
#define N 4
void rotarIzquierda(int arr[], int n) {
    if (n <= 1) return;
    int primero = arr[0];
    for (int i = 0; i < n; i++) {
        arr[i] = arr[i+1];
    }
    arr[n-1] = primero;
}
void imprimirArreglo(int arr[], int n) {
    printf("[");
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1) printf(", ");
    }
    printf("]\n");
}
int main(){
    int arreglo[N] = {1, 2, 3, 4};

    printf("Arreglo original: ");
    imprimirArreglo(arreglo, N);

    rotarIzquierda(arreglo, N);

    printf("Arreglo rotado:   ");
    imprimirArreglo(arreglo, N);

    return 0;
}