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
 *   - contarCombustibleAsignado
 */
bool EJERCICIO_1B_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - modificarUnidad
 */
bool EJERCICIO_1C_HECHO = true;

/**
 * OPCIONAL: implementar en C
 */
void optimizar(mapa_t mapa, attackunit_t* compartida, uint32_t (*fun_hash)(attackunit_t*)) {
    uint32_t hash_compartida = fun_hash(compartida);
    for (uint64_t i = 0; i < 255; i++) {
        for (uint64_t j = 0; j < 255; j++) {
            attackunit_t* actual = mapa[i][j];
            if (actual == NULL || compartida == actual) {
                continue;
            }
            uint32_t hash_actual = fun_hash(actual);
            if (hash_actual == hash_compartida) {
                compartida->references++;
                actual->references--;
                mapa[i][j] = compartida;
            }
            if (actual->references == 0) {
                free(actual);
            }
        }
    }
}

/**
 * OPCIONAL: implementar en C
 */
uint32_t contarCombustibleAsignado(mapa_t mapa, uint16_t (*fun_combustible)(char*)) {
    uint32_t total_combustible_utilizado = 0;
    for (uint64_t i = 0; i < 255; i++) {
        for (uint64_t j = 0; j < 255; j++) {
            attackunit_t* actual = mapa[i][j];
            if (actual == NULL) {
                continue;
            }
            uint32_t combustible_base = (uint32_t) fun_combustible(actual->clase);
            uint32_t combustible_utilizado = actual->combustible - combustible_base;
            total_combustible_utilizado += combustible_utilizado;
        }
    }
    return total_combustible_utilizado;
}

/**
 * OPCIONAL: implementar en C
 */
void modificarUnidad(mapa_t mapa, uint8_t x, uint8_t y, void (*fun_modificar)(attackunit_t*)) {
    attackunit_t* unidad_actual = mapa[x][y];
    // Reescritura más fácil de traducir a assembler.
    // Recuerden que en la aritmética de punteros de C, se multiplica el offset sumado a mapa
    // implícatemente por sizeof(attackunit_t*) (8 bytes).
    //attackunit_t* a_modificar = *((attackunit_t**) mapa + x * 255 + y); // 255 -> COLUMNAS
    if (unidad_actual == NULL) {
        return;
    }
    if (unidad_actual->references > 1) {
        attackunit_t* nueva_unidad = malloc(sizeof(attackunit_t));
        unidad_actual->references--;
        *nueva_unidad = *unidad_actual;
        nueva_unidad->references = 1;

        mapa[x][y] = nueva_unidad;
        // reescritura más fácil de traducir a assembler
        //*((attackunit_t**) mapa + x * 255 + y) = nueva_unidad; // 255 -> COLUMNAS
        unidad_actual = nueva_unidad;
    }
    fun_modificar(unidad_actual);
}
