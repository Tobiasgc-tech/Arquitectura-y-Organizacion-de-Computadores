#include <stdint.h>
#ifndef FAT32_H
#define FAT32_H

typedef uint32_t fat32_t;

fat32_t* new_fat32(void);
fat32_t* copy_fat32(fat32_t* file);
void rm_fact32(fat32_t* file);

#endif