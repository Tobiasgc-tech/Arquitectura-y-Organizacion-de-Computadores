#include <stdio.h>
#include <stddef.h> // para size_t

size_t length(char *str) {
    size_t len = 0;
    while (*str != '\0') {
        len++;
        str++;
    }
    return len;
}
int main() {
    char str[] = "This too shall pass";
    printf("Length of string: %zu\n", length(str));
    return 0;
}
