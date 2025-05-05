#include <stdio.h>

int main() {
        char c = 120;
        unsigned char uc = 10;
        short s = 252;
        unsigned short us = 3;
        int i = 87123;
        unsigned u = 4124133;
        long l = 5;
        unsigned long ul = 14161;

        printf("char(%lu): %d \n", sizeof(c),c);
        printf("unsigned char(%lu): %d \n", sizeof(uc),uc);
        printf("short(%lu): %d \n", sizeof(s),s);
        printf("unsigned char(%lu): %d \n", sizeof(us),us);
        printf("int(%lu): %d \n", sizeof(i),i);
        printf("unsigned(%lu): %d \n", sizeof(u),u);
        printf("long(%lu): %d \n", sizeof(l),l);
        printf("unsigned long(%lu): %d \n", sizeof(ul),ul);

        return 0;
}