#include <stdio.h>
int main () {
    int i = 5;
    printf ("i: %x \n",i);
    printf ("++i: %x \n",--i);
    printf ("i: %x \n",i);
    printf ("i++: %x \n",i--);
    printf ("i: %x \n",i);
}