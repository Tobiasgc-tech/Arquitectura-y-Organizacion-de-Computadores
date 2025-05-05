#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#define TOTAL_TIRADAS 60000000

int main() {
    srand(time(NULL));
    uint32_t dado[6] = {0};

    for (int i = TOTAL_TIRADAS; i--;) {
        int cara = rand() % 6; // valores entre 0 y 5
        dado[cara] += 1;
    }
    printf("Resultados de %d tiradas de dado:\n\n", TOTAL_TIRADAS);
    for (int i = 0; i < 6; i++) {
        float porcentaje = 100.0f * dado[i] / TOTAL_TIRADAS;
        printf("Cara %d: %u veces (%.2f%%)\n", i + 1, dado[i], porcentaje);
    }
    return 0;
}