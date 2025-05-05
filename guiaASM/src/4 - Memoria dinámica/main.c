#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int32_t strCmp(char *a, char *b); // declaración externa


int main() {
    char *s1 = "sar";
    char *s2 = "taaa";
    int32_t res = strCmp(s1, s2);
    printf("Resultado de strCmp(\"%s\", \"%s\") = %d\n", s1, s2, res);
    return 0;
}
