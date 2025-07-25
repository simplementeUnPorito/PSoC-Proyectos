#ifndef FILE1_H
#define FILE1_H
#include "project.h"
uint8_t contarBits(uint32_t);
void triangulitoLindo(uint8_t,char*, uint8_t,void (*print)(const char*));
int16_t getInt(char *buf,uint16_t max_buf,char *msg,void (*print)(const char*),uint8_t (*getcharl)(), void (*putcharl)(uint8_t) );
void getLine (char *buf, int tamBuf, uint8_t (*getcharl)(), void (*putcharl)(uint8_t));
#endif