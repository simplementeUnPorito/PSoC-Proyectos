/*******************************************************************************
* File: main.c
* 
* Version : 1.11
*
* Description: 
*   This application toggles an LED when the user switch is pressed.
*
*   When the switch is pressed the LED pin is read, then the value is toggled
*   (ON/OFF) and it is written back to the GPIO. This demonstrates the use of
*   GPIO for input and output and shows how to read the state of an output pin.
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

#include <project.h>

/*******************************************************************************
* Defines for LED and SW switch
*******************************************************************************/

#define LED_ON      (0u)
#define LED_OFF     (1u)

#define SW_ON       (0u)
#define SW_OFF      (1u)


/*******************************************************************************
* Function Name: SWPressed
********************************************************************************
*
* Summary:
*  SWPressed function performs following functions:
*   1: Reads the SW pin state
*   2: If the state changes from off to on return true
*   3. Otherwise return false
* 
* Parameters:
*  None.
*
* Return:
*  TRUE or FALSE indicating that the switch was just pressed.
*
*******************************************************************************/
int SWPressed( void )
{
    static int lastPos = FALSE;                 /* Last state of the switch */
    
    int currPos = ( SW_ON == SW_GpioGet() );  /* Current switch state */
    
    int changed = ( ( ! lastPos ) && currPos ); /* Detect initial press only */

    lastPos = currPos;                          /* Remember the new state */

    return changed;                             /* Switch just pressed */
}


/*******************************************************************************
* Function Name: main
********************************************************************************
*
* Summary:
*  Main function performs following functions:
*   1: Initialize the LED GPIO (off) and switch (pulled up)
*   2: If SW is pressed toggle the state of the LED
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
    Green_LED_GpioInitIn( LED_OFF );  /* Make the pin readable */
    Green_LED_GpioInitOut( LED_OFF ); /* Enable output */
    
    /* Initialize the SW pin as digital input, initially off */
    SW_GpioInitIn( SW_OFF );

    for(;;)
    {
        /* Check for a button press and toggle the LED */
        if( SWPressed() )
        {
            Green_LED_GpioPut( ( Green_LED_GpioGet() == LED_ON ) ? LED_OFF : LED_ON ); 
        }
    }
}

/* [] END OF FILE */
