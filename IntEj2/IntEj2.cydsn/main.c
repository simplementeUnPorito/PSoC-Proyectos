#include "project.h"
#include <stdio.h>

CY_ISR_PROTO(UART_ReadSerial);
#define N_Rx 2000
volatile int8 bufferRX[N_Rx], x[N_Rx], h[N_Rx],resultado[N_Rx];
volatile uint16 iRX = 0;


void recuperarVectores()
{
    uint16_t i = 0;
    for(i = 0; i < bufferRX[1]; i++)
        x[i] = bufferRX[3 + i];
    
    for(i = 0; i < bufferRX[2]; i++)
        h[i] = bufferRX[3 + i + bufferRX[1]];   
}

void retornoResultadoS()
{
    // Transmisión de los datos
    for(uint16_t i = 0; i < ((bufferRX[1] >= bufferRX[2]) ? bufferRX[1] : bufferRX[2]); i++)
    {
        UART_WriteTxData(resultado[i]);
    }   
}

void sumarListas()
{
    
    Led_Write(1);
    recuperarVectores();
    for(uint16_t i = 0; i < ((bufferRX[1] >= bufferRX[2]) ? bufferRX[1] : bufferRX[2]); i++)
    {
        resultado[i] = (bufferRX[1] > i ? x[i] : 0) + (bufferRX[2] > i ? h[i] : 0);
    }
    
    retornoResultadoS();
    
    Led_Write(0);
}


void retornoResultadoC()
{
    // Transmisión de los datos
    for(uint16_t i = 0; i < bufferRX[1]+ bufferRX[2]-1; i++)
    {
        UART_WriteTxData(resultado[i]);
    }   
}
void convListas()
{
    Led_Write(1);
    recuperarVectores();
    uint16_t k,n;
    for(n = 0;n<bufferRX[1]+bufferRX[2]-1;n++)
    {
        resultado[n] = 0;
        for(k = 0;k<=n;k++)
            resultado[n]+=(k<bufferRX[1]?x[k]:0)*(n-k<bufferRX[2]?h[n-k]:0);
    }
    retornoResultadoC();
    Led_Write(0);
}


int main(void)
{
    UART_Start(); 
    isr_StartEx(UART_ReadSerial); 
    isr_Enable();
    CyGlobalIntEnable; // Asegurar que se llame correctamente
    
    for (;;)
    {
        if(iRX != 0 && bufferRX[0] == iRX) //se termino la lectura
        {
            isr_Disable();
            convListas();
            iRX = 0;
            isr_Enable();
        }
    }
}

CY_ISR(UART_ReadSerial)
{
    
    bufferRX[iRX++] = UART_ReadRxData();
    
    // Protección contra desbordamiento de buffer
    if (iRX >= N_Rx)
    {
        iRX = 0; // O manejar el error de otra manera
    }
}

