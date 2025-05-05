#include "ej1.h"

uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len){
    int contador = 0;
    for(long unsigned int i = 0; i < temploArr_len; i++){
        int columLargo = temploArr[i].colum_largo;    
        int columCorto = temploArr[i].colum_corto;
        if (2 * columCorto + 1 == columLargo) {
            contador++;
        }  
    }

}
  
templo* templosClasicos_c(templo *temploArr, size_t temploArr_len){
    uint32_t cantidadDeTemplos = cuantosTemplosClasicos_c (temploArr, temploArr_len);
    
    templo* repuesta = malloc(cantidadDeTemplos*24);

    for(long unsigned int i = 0; i < temploArr_len; i++) {
        int columLargo = temploArr[i].colum_largo;    
        int columCorto = temploArr[i].colum_corto;
        if (2 * columCorto + 1 == columLargo) {
            repuesta->colum_largo = temploArr[i].colum_largo;
            repuesta->nombre = temploArr[i].nombre;
            repuesta->colum_corto = temploArr[i].colum_corto;
        }         
    }


}
