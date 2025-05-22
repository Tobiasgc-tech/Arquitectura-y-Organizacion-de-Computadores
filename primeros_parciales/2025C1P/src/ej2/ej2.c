#include "ej2.h"

#include <string.h>

// OPCIONAL: implementar en C
void invocar_habilidad(void* carta_generica, char* habilidad) {
	card_t* card = carta_generica;

	directory_t dir_t = card->__dir;
	uint16_t cant_ability = card->__dir_entries;

	while (cant_ability != 0) {
		directory_entry_t* entry = *dir_t;

		if(!strcmp(entry->ability_name, habilidad)) {
			void (*ability)(card_t* card) = entry->ability_ptr;
			ability(card);
			return; 
		}
		dir_t++;
		cant_ability--;
	}
	
	if(card->__archetype != NULL) {
		invocar_habilidad(card->__archetype,habilidad);
		return;
	}
}
