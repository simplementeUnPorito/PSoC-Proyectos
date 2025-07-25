#include "project.h"
#include <stdio.h>
#include "funciones.h"

#define MAX_BUFFER 100
char buffer[MAX_BUFFER];


int main(void)
{
    CyGlobalIntEnable;
    PC_Start();
    uint32_t n;
    for(;;)
    {
        
        n = getInt(buffer,MAX_BUFFER,"Ingrese un numero: ",PC_PutString,PC_GetChar,PC_PutChar);
        triangulitoLindo(n,buffer,100,PC_PutString);
        snprintf(buffer,MAX_BUFFER,"La cantidad de unos es: %u\n\r",contarBits(n));
        PC_PutString(buffer);
    }
}
