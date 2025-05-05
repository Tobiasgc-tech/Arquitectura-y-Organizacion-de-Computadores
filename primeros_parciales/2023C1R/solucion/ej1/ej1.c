#include "ej1.h"

uint32_t* acumuladoPorCliente(uint8_t cantidadDePagos, pago_t* arr_pagos){
    uint32_t *acumulado = calloc(10, sizeof(uint32_t));

    for(int i =  0; i < cantidadDePagos; i++) {
        if (arr_pagos[i].aprobado == 1) {
            int cliente = arr_pagos[i].cliente;
            acumulado[cliente] += arr_pagos[i].monto;
        }
    }
}

uint8_t en_blacklist(char* comercio, char** lista_comercios, uint8_t n){
}

pago_t** blacklistComercios(uint8_t cantidad_pagos, pago_t* arr_pagos, char** arr_comercios, uint8_t size_comercios){
}


