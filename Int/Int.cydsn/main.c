
#include "project.h"


CY_ISR_PROTO(UART_FUNCTION){
    Led_Write(~Led_Read());
    
    isr_UART_ClearPending();
    
}
int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    UART_Start();
    isr_UART_StartEx(UART_FUNCTION);
    isr_UART_Enable();
    /* Place your initialization/startup code here (e.g. MyInst_Start()) */

    for(;;)
    {
        /* Place your application code here. */
    }
}

/* [] END OF FILE */
