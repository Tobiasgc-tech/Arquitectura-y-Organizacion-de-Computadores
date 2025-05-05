#include <stdint.h>
#include <stdio.h>
int main () {
    uint32_t a = 0x043df;
    uint32_t b = 0x023120;
    uint32_t highBits = (a >> 29) & 0x7;
    uint32_t lowerBits = b & 0x7;

    if (highBits == lowerBits) {
        printf("Si son iguales\n");
    } else {
        printf("No son iguales\n");
    }
    return 0;
}