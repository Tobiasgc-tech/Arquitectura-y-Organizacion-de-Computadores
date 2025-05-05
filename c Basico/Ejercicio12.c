#include <stdio.h>
#define N 4
void rotarIzquierdaN (int arr[],int n, int r) {
    if (n <= 1) return;
    r = r % n;
    int temp[r];
    for (int i = 0; i < r; i++) {
        temp[i] = arr[i];
    }
    for (int i = 0; i < n - r; i++) {
        arr[i] = arr[i+r];
    }
    for (int i= 0; i < r; i++) {
        arr[n-r+i] = temp[i];
    }
}
void imprimirArreglo(int arr[], int n) {
    printf("[");
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1) printf(", ");
    }
    printf("]\n");
}

int main() {
    int arreglo[N] = {1, 2, 3, 4};
    int k = 2;

    printf("Arreglo original: ");
    imprimirArreglo(arreglo, N);

    rotarIzquierdaN(arreglo, N, k);

    printf("Arreglo rotado:   ");
    imprimirArreglo(arreglo, N);

    return 0;
}