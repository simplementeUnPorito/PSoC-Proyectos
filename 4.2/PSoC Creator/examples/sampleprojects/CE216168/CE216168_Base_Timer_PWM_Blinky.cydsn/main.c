/*******************************************************************************
* File: main.c
* 
* Version : 1.11
*
* Description: 
*
*   This application uses one of the Base Timers (BT) to blink an LED. The BT
*   is configured to run in PWM mode with a 1/256 clock prescaler. It generates
*   interrupts that control the LED pin on both a duty value match (LED on) and
*   underflow (LED off). The firmware sets the PWM period to one second and the
*   duty cycle to 10%.
*
********************************************************************************
* Copyright 2016, Cypress Semiconductor Corporation. All rights reserved.
* This software is owned by Cypress Semiconductor Corporation and is protected
* by and subject to worldwide patent and copyright laws and treaties.
* Therefore, you may use this software only as provided in the license agreement
* accompanying the software package from which you obtained this software.
* CYPRESS AND ITS SUPPLIERS MAKE NO WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
* WITH REGARD TO THIS SOFTWARE, INCLUDING, BUT NOT LIMITED TO, NONINFRINGEMENT,
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
*******************************************************************************/

#include "project.h"

/*******************************************************************************
* Defines for LED and Base Timer
*******************************************************************************/

#define LED_ON              (0u)
#define LED_OFF             (1u)

/* Calculate the PWM cycle value for a 1s period */
#define CLOCK_RATE          (__CLKHC)
#define CLOCK_PRESCALER     (256u)
#define COUNTS_PER_SECOND   (CLOCK_RATE / CLOCK_PRESCALER)

#define PWM_PERIOD          (COUNTS_PER_SECOND)
#define PWM_DUTY            (COUNTS_PER_SECOND / 10)


/*******************************************************************************
* Function Name: LED_PWM_PwmDutyMatchIrqCb
********************************************************************************
*
* Summary:
*  LED_PWM_PwmDutyMatchIrqCb turns on the LED.
*
*  This function is called from the BT interrupt handler (which clears the IRQ)
* 
* Parameters:
*  None.
*
* Return:
*  None.
*
*******************************************************************************/
void LED_PWM_PwmDutyMatchIrqCb( void )
{
    /* Turn on the LED */
    Green_LED_GpioPut( LED_ON );
}


/*******************************************************************************
* Function Name: LED_PWM_PwmUnderflowIrqCb
********************************************************************************
*
* Summary:
*  LED_PWM_PwmUnderflowIrqCb turns on the LED.
*
*  This function is called from the BT interrupt handler (which clears the IRQ)
* 
* Parameters:
*  None.
*
* Return:
*  None.
*
*******************************************************************************/
void LED_PWM_PwmUnderflowIrqCb( void )
{
    /* Turn off the LED */
    Green_LED_GpioPut( LED_OFF );
}


/*******************************************************************************
* Function Name: main
********************************************************************************
*
* Summary:
*  Main function performs following functions:
*   1: Initialize the LED (off)
*   2: Initialize the PWM and set the cycle and duty values
*   3. Start (software trigger) the timer
*   4. Loop forever (each interrupt fires once per second)
* 
* Parameters:
*  None.
*
* Return:
*  Not used.
*
*******************************************************************************/
int main(void)
{
    /* Initialize the LED pin as digital output, initially off */
    Green_LED_GpioInitOut( LED_OFF );

    /* Initialize PWM timer */ 
    while( Ok != Bt_Pwm_Init( &LED_PWM_HW , &LED_PWM_Config ) )
    {
        /* ErrorInvalidParameter - loop forever */
    }

    /* Set cycle and duty value */
    while( Ok != Bt_Pwm_WriteCycleVal( &LED_PWM_HW, PWM_PERIOD ) )
    {
        /* ErrorInvalidParameter - loop forever */
    }

    while( Ok != Bt_Pwm_WriteDutyVal( &LED_PWM_HW, PWM_DUTY ) )
    {
        /* ErrorInvalidParameter - loop forever */
    }
    
    /* Enable count operation */
    while( Ok != Bt_Pwm_EnableCount( &LED_PWM_HW ) )
    {
        /* ErrorInvalidParameter - loop forever */
    }
    
    /* Start triggered by software */
    while( Ok != Bt_Pwm_EnableSwTrig( &LED_PWM_HW ) )
    {
        /* ErrorInvalidParameter - loop forever */
    }
       
    for(;;)
    {
        /* Place your application code here. */
    }
}

/* [] END OF FILE */
