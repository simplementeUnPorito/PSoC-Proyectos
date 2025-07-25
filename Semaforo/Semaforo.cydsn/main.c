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



enum trafficLight{
    goN = 33u,
    waitN = 34u,
    goE = 12u,
    waitE = 20u
};
#define DELAY_WAIT 1000
#define DELAY_GO 1000

void ledTrafficLight(enum trafficLight state)
{
       ledRE_Write((state&32u)>>5);
       ledYE_Write((state&16u)>>4);
       ledGE_Write((state&8u)>>3);
    
       ledRE_Write((state&4u)>>2);
       ledYE_Write((state&2u)>>1);
       ledGE_Write(state&1u);
}

enum trafficLight semaforo(uint8_t sensor)
{
    static enum trafficLight state = goN;
    ledTrafficLight(state);
    switch(state)
    {
        case goN:
            if(sensor == 1 || sensor  == 3)
                state = waitN;
            CyDelay(DELAY_GO);
            return state;
        
        case waitN:
            state = goE;
            CyDelay(DELAY_WAIT);
            return state;
        case goE:
            if(sensor == 2 || sensor == 3)
                state = waitE;
            CyDelay(DELAY_GO);
            return state;
        case waitE:
            state = goN;
            CyDelay(DELAY_WAIT);
            return state;
        default:
            state = goN;
            return state;
    }
    return 0;
}

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    volatile uint8_t dato = 0,datoN,datoE;
    for(;;)
    {
        /* Place your application code here. */
        datoN = sensorN_Read()&1;
        datoE = sensorE_Read()&1;
        dato = ~(datoN<<1&datoE);
        semaforo(dato);
        
    }
}

/* [] END OF FILE */
