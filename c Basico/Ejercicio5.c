#include <stdio.h>

int main() {
    float f = 13.1214F;
    double d = 123.1213561;
    float iF = (int) f;
    float iD = (int) d;


    printf("float(%lu): %f \n", sizeof(f),f);
    printf("double(%lu): %lf \n", sizeof(d),d);
    printf("intF(%lu): %f \n", sizeof(iF),iF);
    printf("intD(%lu): %f \n", sizeof(iD),iD);

    return 0;
}