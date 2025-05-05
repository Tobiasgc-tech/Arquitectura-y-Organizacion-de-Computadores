#include <stdio.h>
#include <stdint.h>
#define cantMonstruo 4

struct monstruo_t {
    char nombre[50];
    int vida;
    double ataque;
    double defensa;
};

void evolution(struct monstruo_t *monstruo) {
    monstruo->ataque += 10;
    monstruo->defensa += 10;
}

void imprimirMonstruo (struct monstruo_t monstruo) {
    printf("Nombre: %s\n", monstruo.nombre);
    printf("Vida: %d\n", monstruo.vida);
    printf("Ataque: %lf\n", monstruo.ataque);
    printf("Defensa: %lf\n", monstruo.defensa);
}
int main(){
    struct monstruo_t nuevosMonstruo[cantMonstruo] = {
        {"Tobias", 100, 14, 3},
        {"Gabriel", 123, 10, 16},
        {"Jose", 97, 11, 50},
        {"Kratos", 50, 23, 12},
    };
    int i = 0;
    while (i < cantMonstruo){
        imprimirMonstruo(nuevosMonstruo[i]);
        i++;
    };
    evolution(&nuevosMonstruo[3]);
    imprimirMonstruo(nuevosMonstruo[3]);
    return 0;
}