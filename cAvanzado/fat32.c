#include <stdlib.h>
#include "fat32.h"
#include <stdio.h>
#include "fat32.h"
#include "list.h"

static uint32_t contador = 0;

fat32_t* new_fat32(void) {
    fat32_t* f = malloc(sizeof(fat32_t));
    *f = contador++;  // asignamos un valor distinto a cada unoo
    return f;
}

fat32_t* copy_fat32(fat32_t* file) {
    fat32_t* copia = malloc(sizeof(fat32_t));
    *copia = *file;  // copiamos el valor
    return copia;
}

void rm_fat32(fat32_t* file) {
    free(file);
}


int main(void) {
    list_t* lista = listNew(TypeFAT32);

    fat32_t* f1 = new_fat32();
    fat32_t* f2 = new_fat32();

    listAddFirst(lista, f1);
    listAddFirst(lista, f2);

    printf("Elementos en la lista: %d\n", lista->size);
    fat32_t* fget = (fat32_t*) listGet(lista, 0);
    printf("Primer elemento: %u\n", *fget);

    listDelete(lista);

    // rm_fat32(f1);  // no es necesario si se hizo copia, ver discusión previa
    // rm_fat32(f2);

    return 0;
}
