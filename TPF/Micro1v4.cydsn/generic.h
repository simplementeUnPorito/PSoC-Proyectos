
#include "project.h"


//Definiciones Logicas
#define TRUE  1
#define FALSE 0

#define POT_MAX 1

#define MAX_BUFFER 100
char buffer[MAX_BUFFER];

#if defined (__GNUC__)
    asm(".global _printf_float");
#endif

uint16_t button = 0;
