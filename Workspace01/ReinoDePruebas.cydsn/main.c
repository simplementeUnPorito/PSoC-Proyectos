#include "project.h"
#include <complex.h>  // Incluir la biblioteca para manejar números complejos
#include <math.h>     // Para la función exp() y M_PI
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define MAX 4

uint8_t real[MAX*4];
uint8_t imag[MAX*4];

float y[MAX] = {1.5, 2.7, 3.9, 4.2};
static uint8 n=4*MAX;
CY_ISR_PROTO(UART_ISR);

#if defined (__GNUC__)
    asm(".global _printf_float");
#endif


void convertToIntFloat(const uint8_t* input, float* output, size_t inputSize) {
    // Asegúrate de que inputSize sea un múltiplo de 4
    for (size_t i = 0; i < inputSize; i += 4) {
        // Asumiendo little endian; ajusta si es necesario
        uint32_t temp = input[i] | (input[i + 1] << 8) | (input[i + 2] << 16) | (input[i + 3] << 24);
        memcpy(output + (i / 4), &temp, sizeof(float));
    }
}

uint8_t flag = 0;
//cambiar a flag
CY_ISR(UART_ISR) {
    flag = 1;
}

int main(void)
{
     UART_Start(); // Asumiendo que tienes un componente UART configurado
     isr_rx_StartEx(UART_ISR); //Asigno una nueva rutina de servicio
     isr_rx_Disable(); //Habilito la interrupcion isr_rx
     // Inicializa tu PSoC y cualquier componente necesario aquí
     CyGlobalIntEnable; /* Enable global interrupts. */
    // Inicializar componentes
    flag = 0;
    for(;;)
    {
        Led_Write(~Led_Read());
        //los datos se han leido como bytes, hay que darles el formato de float:
        convertToIntFloat(real,y,MAX*4);
        
        //solo enviamos de nuevo los datos float por el puerto para comprobar que la comunicacion funciona bien:
          for(int i = 0; i < MAX; i++) { 
               Chart_Plot(y[i]);	//chart_plot es una libreria que formatea los datos de la manera correcta y los envia utilizando el uart configurado
             }
         n=0;
        //led_Write(0);
        
    }

    
    
}

