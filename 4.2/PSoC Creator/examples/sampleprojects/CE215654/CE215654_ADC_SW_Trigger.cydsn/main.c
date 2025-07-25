/*******************************************************************************
* File: main.c
* 
* Version : 1.11
*
* Description: 
*
*   This application uses the ADC to control the green LED based on the voltage
*   on a pin. The voltage on the pin is constantly read with a scan conversion
*   in the ADC and the LED is toggled at the mid-point of the voltage range.
*
*   For the S6E1B and S6E21C Starter Kits the voltage is varied by a
*   potentiometer on the kit. For the S6E1A Evaluation Board an external voltage
*   source is required.
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
* Defines for LED and ADC
*******************************************************************************/
#define LED_ON      (0u)
#define LED_OFF     (1u)

#define ADC_MIN     (0u)
#define ADC_MAX     (0xFFFu)
#define ADC_MID     (((ADC_MAX-ADC_MIN)/2u)+ADC_MIN)


/*******************************************************************************
* Function Name: main
********************************************************************************
*
* Summary:
*  Main function performs following functions:
*   1: Initialize the LED (off) and ADC
*   2: Trigger a scan and wait for it to complete
*   3. Read the FIFO and extract the scan data
*   4. Light the green LED if voltrage is above 50% of the ADC range
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
    uint32_t adc_fifo;              /* ADC scan data and status bits */
    uint16_t adc_data;              /* Result of an ADC scan */
    
    /* Initialize the LED pin as digital output, initially off */
    Green_LED_GpioInitOut( LED_OFF );
    
    /* Initialize the ADC */
    while( Ok != Adc_Init( &ADC_HW, &ADC_Config ) )
    {        
        /* ErrorInvalidParameter - loop forever */
    }
    
    /* Enable and wait until the ADC is ready */
    while( Ok != Adc_EnableWaitReady( &ADC_HW ) )
    {        
        /* ErrorInvalidParameter - loop forever */
        /* ErrorTimeout - loop until ready */
    }
    
    while( 1 )
    {
        /* Trigger a scan conversion */
        while( Ok != Adc_SwTriggerScan( &ADC_HW ) )
        {        
            /* ErrorInvalidParameter - loop forever */
        }
        
        /* Wait for the triggered conversion to complete */
        while( TRUE == Adc_GetStatus( &ADC_HW, ScanStatus ) )
        {
            /* Repeat until scan complete */
        }
           
        /* Read the FIFO and check that it contains valid information */
        adc_fifo = Adc_ReadScanFifo( &ADC_HW );
        
        if( AdcFifoDataValid == Adc_GetScanDataValid( &ADC_HW, adc_fifo ) )
        {
            /* Extract the data from the FIFO */
            adc_data = Adc_GetScanData( &ADC_HW, adc_fifo );
                
            /* Update the LED */
            Green_LED_GpioPut( ( adc_data > ADC_MID ) ? LED_ON : LED_OFF );        
        }       
    }
}

/* [] END OF FILE */
