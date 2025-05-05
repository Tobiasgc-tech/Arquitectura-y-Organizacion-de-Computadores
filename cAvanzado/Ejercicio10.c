#include <stdio.h>
#include <string.h>

int main() {
    // 1. strcpy: Copiar una cadena a otra
    char fuente[] = "Hola, Mundo!";
    char destino[50];
    strcpy(destino, fuente);
    printf("strcpy: %s\n", destino);  // Copia el contenido de 'fuente' a 'destino'

    // 2. strcat: Concatenar dos cadenas
    char saludo[50] = "Hola";
    char exclamacion[] = ", ¿cómo estás?";
    strcat(saludo, exclamacion);
    printf("strcat: %s\n", saludo);  // Concatenar 'exclamacion' al final de 'saludo'

    // 3. strlen: Obtener la longitud de una cadena
    printf("strlen: Longitud de 'saludo': %zu\n", strlen(saludo));  // Muestra la longitud de 'saludo'

    // 4. strcmp: Comparar dos cadenas
    char cadena1[] = "Hola";
    char cadena2[] = "Hola";
    char cadena3[] = "Mundo";
    int resultado1 = strcmp(cadena1, cadena2);  // 0 si son iguales
    int resultado2 = strcmp(cadena1, cadena3);  // No 0 si son diferentes
    printf("strcmp: comparación entre 'cadena1' y 'cadena2' = %d\n", resultado1);  // 0 si son iguales
    printf("strcmp: comparación entre 'cadena1' y 'cadena3' = %d\n", resultado2);  // No 0 si son diferentes

    // 5. strchr: Encontrar la primera aparición de un carácter
    char *posicion = strchr(fuente, 'M');
    if (posicion != NULL) {
        printf("strchr: 'M' encontrado en la posición: %ld\n", posicion - fuente);  // Devuelve la posición de 'M' en 'fuente'
    } else {
        printf("strchr: Carácter no encontrado.\n");
    }

    // 6. strstr: Encontrar la primera aparición de una subcadena
    char *subcadena = strstr(fuente, "Mundo");
    if (subcadena != NULL) {
        printf("strstr: 'Mundo' encontrado en la posición: %ld\n", subcadena - fuente);  // Devuelve la posición de "Mundo"
    } else {
        printf("strstr: Subcadena no encontrada.\n");
    }

    return 0;
}
