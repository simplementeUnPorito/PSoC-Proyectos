#include "project.h"
#include "servov2.h"

extern volatile struct {
    uint8_t reset : 1;   
    uint8_t key : 2;
    uint8_t pot : 1;  // Define el modo de operación (PERILLA o 3D)
} flag;


Potenciometros pot;
ListaMovimiento movimientos_baile;  // Lista de movimientos para el "baile"


int main(void) {
    CyGlobalIntEnable; /* Enable global interrupts. */
    
    // Iniciar los componentes
    ADC_Start();
    ADC_StartConvert();
    eoc_ADC_Start();
    eoc_ADC_StartEx(guardarPot); // Asignar la ISR
    PC_Start();
    PWM1_Start();
    PWM2_Start();
    TimerServo_Start();
    resetServoTimer_Write(0);
    // Configuración de movimientos para el "baile"
    movimientos_baile.lenLista = 4;  // Número de movimientos de la lista
    movimientos_baile.maxLenLista = 100;
    movimientos_baile.indiceActual = 0;
    movimientos_baile.lista[0] = (Potenciometros){2000, 1800, 1900, 2100};
    movimientos_baile.lista[1] = (Potenciometros){3000, 1900, 1950, 2150};
    movimientos_baile.lista[2] = (Potenciometros){2000, 1700, 2000, 2200};
    movimientos_baile.lista[3] = (Potenciometros){3500, 2000, 1950, 2150};

    updateModeServo(PERILLA);
    TimerServo_Enable();
    ejecutarListaPot(&movimientos_baile);
    for(;;) {
        // Ejecuta el siguiente movimiento en la lista cada ciclo
        if(ServoDone_Read() == 1){
            resetServoTimer_Write(1);
            ejecutarListaPot(&movimientos_baile);
            
            // Espera un corto intervalo para observar el cambio de movimiento
            //CyDelay(500);  // Ajusta el tiempo según la velocidad deseada del baile

            // Mostrar el movimiento actual en la terminal
            char buffer[100];
            snprintf(buffer, 100, "Movimiento %d: B: %u C: %u M: %u P: %u\n\r", 
                     movimientos_baile.indiceActual, pot.base, pot.codo, pot.munneca, pot.pinza);
            PC_PutString(buffer);
            CyDelay(1000);
            // Limpiar la pantalla de la terminal para ver la siguiente actualización
            PC_PutString("\033[2J\033[H");
            resetServoTimer_Write(0);
        }
    }
}
