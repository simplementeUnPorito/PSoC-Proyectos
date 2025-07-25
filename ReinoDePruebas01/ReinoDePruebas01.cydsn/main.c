#include "project.h"
#include <complex.h>  // Incluir la biblioteca para manejar números complejos
#include <math.h>     // Para la función exp() y M_PI
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define MAX 4

uint8_t real[MAX*4];
uint8_t imag[MAX*4];

// Función DFT
void dft(float *x, float complex *Xf, uint8_t n_points)
{
    for (uint8_t k = 0; k < n_points; k++) {
        Xf[k] = 0.0 + 0.0 * I;  // Inicializar el valor de Xf[k] como número complejo 0

        for (uint8_t n = 0; n < n_points; n++) {
            // Calcular la DFT sumando las contribuciones de x[n]
            Xf[k] += x[n] * (cos(-2 * M_PI * k * n / n_points) + sin(-2 * M_PI * k * n / n_points) * I);
        }
    }
}


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

char buff[32];

int main(void)
{
     UART_Start(); // Asumiendo que tienes un componente UART configurado
     isr_rx_StartEx(UART_ISR); //Asigno una nueva rutina de servicio
     isr_rx_Enable(); //Habilito la interrupcion isr_rx
     // Inicializa tu PSoC y cualquier componente necesario aquí
     CyGlobalIntEnable; /* Enable global interrupts. */
    // Inicializar componentes
    flag = 0;
    for(;;)
    {
//        if(n == MAX*4){
//            Led_Write(~Led_Read());
//            isr_rx_Disable();
//            //los datos se han leido como bytes, hay que darles el formato de float:
//            convertToIntFloat(real,y,MAX*4);
//            
//	//solo enviamos de nuevo los datos float por el puerto para comprobar que la comunicacion funciona bien:
//              for(int i = 0; i < MAX; i++) { 
//                   Chart_Plot(y[i]);	//chart_plot es una libreria que formatea los datos de la manera correcta y los envia utilizando el uart configurado
//                 }
//             //n=0;
//            isr_rx_Enable();
//            //led_Write(0);
//        }
//        else if(flag && n < MAX*4)
//        {
//         real[n] = UART_ReadRxData();
//         Chart_Plot(real[n++]);
//         isr_rx_ClearPending();//Limpio la bandera de interrupción
//         flag = 0;
//        }
//            
//    }
    //UART_PutString("ME ODIO: ");
    sprintf(buff, "%f\r\n", 3.3);   
    UART_PutString(buff);     
    //CyDelay(3000);
    }
    
}

