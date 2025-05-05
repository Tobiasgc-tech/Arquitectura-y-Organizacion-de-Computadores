#include <stdio.h>

void aMayus (char str[]) {
    while (*str != '\0') {
        if (*str >= 'a' && *str <= 'z') {
            *str = *str - ('a'-'A');
        }
        str++;
    }
}

int main() {
    char texto[] = "hola como estAS";
    aMayus(texto);
    printf("%s\n", texto);
}