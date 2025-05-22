#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej1.h"

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - es_indice_ordenado
 */
bool EJERCICIO_1A_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - indice_a_inventario
 */
bool EJERCICIO_1B_HECHO = true;

/**
 * OPCIONAL: implementar en C
 */
bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador) {
    bool repuesta = true;

    if (tamanio > 1) {
        for (int i = 0; i < tamanio - 1; i++) {
            item_t* item1 = inventario[indice[i]];
            item_t* item2 = inventario[indice[i + 1]];

            if (!comparador(item1, item2)) {
                repuesta = false;
            }
        }
    }

    return repuesta;
}

/**
 * OPCIONAL: implementar en C
 */
item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio) {
	// ¿Cuánta memoria hay que pedir para el resultado?
    item_t** nuevo_inventario = malloc(tamanio * sizeof(item_t*));

    // Copiar los punteros en el orden indicado por el índice
    for (uint16_t i = 0; i < tamanio; i++) {
        nuevo_inventario[i] = inventario[indice[i]];
    }

    return nuevo_inventario;
}
