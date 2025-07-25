/*******************************************************************************
* File: main.c
* 
* Version : 1.12
*
* Description: 
*   A UART echoes a received character over a serial port (CMSIS-DAP bridge).
*
*   The UART component is called "BridgeUART" because it uses the CMSIS-DAP
*   device on the kit as a bridge between the MCU and the PC.
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
* Function Name: main
********************************************************************************
*
* Summary:
*  Main function performs following functions:
*   1: Start the UART
*   2: Read the UART input 
*   3: Echo the data to UART output
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
    uint8_t u8Data;         /* Character to read and write over the UART */   

    /* Initialize the UART hardware with config struct from the component */
    while( Ok != Mfs_Uart_Init( &BridgeUART_HW, &BridgeUART_Config ) )
    {
        /* Loop forever - ErrorInvalidParameter */
    }    

    /* Enable Tx and Rx operation in the MFS block */    
    while( Ok != Mfs_Uart_EnableFunc( &BridgeUART_HW, UartTx ) )
    {
        /* Loop forever - ErrorInvalidParameter */
    }
    
    while( Ok != Mfs_Uart_EnableFunc( &BridgeUART_HW, UartRx ) )
    {
        /* Loop forever - ErrorInvalidParameter */
    }    
    
    /* Set SIN and SOT pins based on CYDWR selections or control file */
    BridgeUART_SetPinFunc_SIN();
    BridgeUART_SetPinFunc_SOT();
    
    for(;;)
    {
        /* Receive and send back data */
        if( ( TRUE == Mfs_Uart_GetStatus( &BridgeUART_HW, UartRxFull  ) ) && \
            ( TRUE == Mfs_Uart_GetStatus( &BridgeUART_HW, UartTxEmpty ) ) )
        {
            u8Data = Mfs_Uart_ReceiveData( &BridgeUART_HW );
          
            while( Ok != Mfs_Uart_SendData( &BridgeUART_HW, u8Data ) )
            {
                /* Loop forever - ErrorInvalidParameter */
            }            
        }
    }  
}

/* [] END OF FILE */
