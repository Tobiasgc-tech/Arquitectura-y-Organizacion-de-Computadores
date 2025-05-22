#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej1.h"

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - init_fantastruco_dir
 */
bool EJERCICIO_1A_HECHO = true;

// OPCIONAL: implementar en C
void init_fantastruco_dir(fantastruco_t* card) {
    directory_t dir = malloc(16);
    directory_entry_t* wu = create_dir_entry("wakeup", wakeup);
    directory_entry_t* sl = create_dir_entry("sleep", sleep);

    dir[0] = wu;
    dir[1] = sl;

    card->__dir = dir;
    card->__dir_entries = 2;
}

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - summon_fantastruco
 */ 
bool EJERCICIO_1B_HECHO = true;

// OPCIONAL: implementar en C
fantastruco_t* summon_fantastruco() {
    fantastruco_t* card = malloc(32);
    init_fantastruco_dir(card);
    card->face_up = 1;
    card->__archetype = NULL;
}
