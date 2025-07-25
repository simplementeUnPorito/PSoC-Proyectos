
#include "project.h"
#include <stdio.h>

#define N 4 // Cambia esto al tamaño de tu secuencia


// Considerando que tienes una array 'x' que contiene tu secuencia de datos 
static uint8_t x[N*4];  //x sera la variable donde se guardaran los datos recibidos por el UART, teniendo en cuenta que
//se quieren recibir datos float multiplicados su longitud del vector por 4, debido a que cada dato float posee 4 bytes y los recibiremos de a bytes 
//utilizando la funcion ReadRXData() (ver datasheet del uart), luego convertiremos los datos del array x al formato de float para utilizarlos.

float y[N];
volatile uint8_t n;


void convertToIntFloat(const uint8_t* input, float* output, size_t inputSize){
    // Asegúrate de que inputSize sea un múltiplo de 4
    uint32_t temp=0;
    for (size_t i=0; i<inputSize; i += 4) {
        // Asumiendo little endian; ajusta si es necesario
        temp = input[i] | (input[i + 1] << 8) | (input[i + 2] << 16) | (input[i + 3] << 24);
        memcpy(output + (i / 4), &temp, sizeof(float));
    }
}


uint8_t flag = 0;
CY_ISR(UART_ISR){
    flag = 1;
}


#if defined (__GNUC__)
    asm(".global _printf_float");
#endif




int main(void){
    UART_Start();
    UART_ClearRxBuffer(); 
    isr_StartEx(UART_ISR); //Asigno una nueva rutina de servicio
    n = 0;
    flag = 0;
    CyGlobalIntEnable; /* Enable global interrupts. */

    for(;;){
        if(n == N*4){
            Led_Write(1);
            CyGlobalIntDisable;
            //los datos se han leido como bytes, hay que darles el formato de float:
            convertToIntFloat(x,y,N*4);
            
	        //solo enviamos de nuevo los datos float por el puerto para comprobar que la comunicacion funciona bien:
            for(int i=0; i<N; i++){ 
                Chart_Plot(y[i]);	//chart_plot es una libreria que formatea los datos de la manera correcta y los envia utilizando el uart configurado
            }
            n = 0;
            CyGlobalIntEnable;
            Led_Write(0);
        }
        else if(flag)
        {
            //Led_Write(1);
            flag = 0;
            isr_ClearPending();   //Limpio la bandera de interrupción
            x[n] = UART_ReadRxData();
            n++;  
            //CyDelay(3000);
            //Led_Write(0);
            
        }
    }
    
}

/* [] END OF FILE */





