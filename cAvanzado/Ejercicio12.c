#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NAME_LEN 50

typedef struct persona_s {
    char nombre[NAME_LEN + 1];  // +1 para el carácter nulo '\0'
    int edad;
    struct persona_s* hijo;
} persona_t;

persona_t* crearPersona(const char* nombre, int edad) {
    persona_t* nueva = malloc(sizeof(persona_t));
    if (nueva == NULL) {
        return NULL;
    }
    strncpy(nueva->nombre, nombre, NAME_LEN);
    nueva->edad = edad;
    nueva->hijo = NULL;

    return nueva;
}

void eliminarPersona(persona_t* persona) {
    if (persona != NULL) {
        eliminarPersona(persona->hijo);
        free(persona);
    }
}

int main() {
    persona_t* persona = crearPersona("Tobias Cogliano", 22);
    if (persona == NULL) {
        return 1;
    }
    printf("Nombre: %s\n", persona->nombre);
    printf("Edad: %d\n", persona->edad);

    free(persona);

    return 0;
}