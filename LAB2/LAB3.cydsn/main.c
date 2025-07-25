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

#if defined (__GNUC__)
    asm(".global _printf_float");
#endif


float y[] = {1.0,2.3, 4.4, 5.6};
int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    uint8_t i = 0;
    for(;;)
    {
        Chart_Plot(y[0]);
        Chart_Plot(y[1]);
        Chart_Plot(y[2]);
        Chart_Plot(y[3]);
    }
}

/* [] END OF FILE */
