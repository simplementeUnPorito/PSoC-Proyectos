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
#include <math.h>

#define N 4 // Cambia esto al tamaño de tu secuencia


// Considerando que tienes una array 'x' que contiene tu secuencia de datos 
static uint8_t x[N*4];  //x sera la variable donde se guardaran los datos recibidos por el UART, teniendo en cuenta que
//se quieren recibir datos float multiplicados su longitud del vector por 4, debido a que cada dato float posee 4 bytes y los recibiremos de a bytes 
//utilizando la funcion ReadRXData() (ver datasheet del uart), luego convertiremos los datos del array x al formato de float para utilizarlos.

float32 y[N];
volatile uint8_t n;


void convertToIntFloat(const uint8_t* input, float32* output, size_t inputSize){
    // Asegúrate de que inputSize sea un múltiplo de 4
    uint32_t temp=0;
    for (size_t i=0; i<inputSize; i += 4) {
        // Asumiendo little endian; ajusta si es necesario
        temp = (uint32_t)input[i] | ((uint32_t)input[i + 1] << 8) | ((uint32_t)input[i + 2] << 16) | ((uint32_t)input[i + 3] << 24);
        //memcpy(output + (i / 4), &temp, sizeof(float));
        output[i / 4] = *((float*)&temp);
    }
}

//uint8_t rxdata;


CY_ISR(UART_ISR){
    //rxdata = UART_RXDATA_REG;
    //UART_TXDATA_REG = rxdata;
    //Chart_1_Plot(5.9);
    for(n=0; n<N; n++){
        if(n>0){
            y[n] = y[n-1] + 1.375;
        }else{
            y[n] = 1.177;
        }
    }
    //x[n] = UART_ReadRxData();
    //n++;
    isr_1_ClearPending();
}


#if defined (__GNUC__)
    asm(".global _printf_float");
#endif


int main(void){
    UART_Start();
    UART_ClearRxBuffer(); 
    isr_1_StartEx(UART_ISR);
    n = 0;
    
    uint8_t i;
    CyGlobalIntEnable; /* Enable global interrupts. */
    
    for(;;){
        if(n == N){
            CyGlobalIntDisable;
            //los datos se han leido como bytes, hay que darles el formato de float:
            //convertToIntFloat(x,y,N*4);
            
	        //solo enviamos de nuevo los datos float por el puerto para comprobar que la comunicacion funciona bien:
            for(i=0; i<N; i++){ 
                Chart_1_Plot(y[i]);	//chart_plot es una libreria que formatea los datos de la manera correcta y los envia utilizando el uart configurado
            }
            n = 0;
            CyGlobalIntEnable;
        }
    }
        
}

/* [] END OF FILE */
