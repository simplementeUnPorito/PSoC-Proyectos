/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/
#include "project.h"
#include <stdio.h>

#define MAX 100
char buffer[MAX];

uint8_t Cont_Bits(uint32_t);

uint8_t piram(uint8_t N,void (*print)(const char*)){
    if(N<2||N>10) //Sale de pantalla
        return 0;
    char buffer[3];
    for(uint8_t i = 1; i <= N; i++){
        for(uint8_t j = 1; j <= i; j++)
        {
            snprintf(buffer,3, "%d ", j); 
            print(buffer);
        }
        print("\n\r");
    }
    
    return 1;

}

void getLine (char *buf, int tamBuf, uint8_t (*getcharl)(), void (*putcharl)(uint8_t)) {
    int i;
    uint8 c;
   
    for (i = 0; i < tamBuf -1; ) {
        if ((c = getcharl()) != 0){
            putcharl(c);
            if (c == '\r') break;   // salimos si recibimos un enter
            buf[i++] = c;
        }
    }
    buf[i] = '\0';
    putcharl('\n');
}



int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    PC_Start();
    uint32_t n;
    for(;;)
    {
        PC_PutString("n = ");
        getLine(buffer,MAX,PC_GetChar,PC_PutChar);
        sscanf(buffer,"%lu",&n);
        PC_PutString("Piramide:\n\r");
        piram(n,PC_PutString);
        snprintf(buffer,MAX,"Bits en 1 de %lu: %d\n\r",n,Cont_Bits(n));
        PC_PutString(buffer);
    }
}

/* [] END OF FILE */
