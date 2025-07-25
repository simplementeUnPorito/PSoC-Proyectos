/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c  
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file contains API to enable firmware control of a Pins component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2014, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#include "cytypes.h"
#include "`$INSTANCE_NAME`.h"

/* APIs are not generated for P15[7:6] on PSoC 5 */
#if !(CY_PSOC5A &&\
	 `$INSTANCE_NAME`__PORT == 15 && ((`$INSTANCE_NAME`__MASK & 0xC0) != 0))


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Write
********************************************************************************
*
* Summary:
*  Assign a new value to the digital port's data output register.  
*
* Parameters:  
*  prtValue:  The value to be assigned to the Digital Port. 
*
* Return: 
*  None
*  
*******************************************************************************/
void `$INSTANCE_NAME`_Write(uint8 value) `=ReentrantKeil($INSTANCE_NAME ."_Write")`
{
    uint8 staticBits = (`$INSTANCE_NAME`_DR & (uint8)(~`$INSTANCE_NAME`_MASK));
    `$INSTANCE_NAME`_DR = staticBits | ((uint8)(value << `$INSTANCE_NAME`_SHIFT) & `$INSTANCE_NAME`_MASK);
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetDriveMode
********************************************************************************
*
* Summary:
*  Change the drive mode on the pins of the port.
* 
* Parameters:  
*  mode:  Change the pins to one of the following drive modes.
*
*  `$INSTANCE_NAME`_DM_STRONG     Strong Drive 
*  `$INSTANCE_NAME`_DM_OD_HI      Open Drain, Drives High 
*  `$INSTANCE_NAME`_DM_OD_LO      Open Drain, Drives Low 
*  `$INSTANCE_NAME`_DM_RES_UP     Resistive Pull Up 
*  `$INSTANCE_NAME`_DM_RES_DWN    Resistive Pull Down 
*  `$INSTANCE_NAME`_DM_RES_UPDWN  Resistive Pull Up/Down 
*  `$INSTANCE_NAME`_DM_DIG_HIZ    High Impedance Digital 
*  `$INSTANCE_NAME`_DM_ALG_HIZ    High Impedance Analog 
*
* Return: 
*  None
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetDriveMode(uint8 mode) `=ReentrantKeil($INSTANCE_NAME ."_SetDriveMode")`
{
`$SetDriveModeImpl_API_GEN`
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Read
********************************************************************************
*
* Summary:
*  Read the current value on the pins of the Digital Port in right justified 
*  form.
*
* Parameters:  
*  None
*
* Return: 
*  Returns the current value of the Digital Port as a right justified number
*  
* Note:
*  Macro `$INSTANCE_NAME`_ReadPS calls this function. 
*  
*******************************************************************************/
uint8 `$INSTANCE_NAME`_Read(void) `=ReentrantKeil($INSTANCE_NAME ."_Read")`
{
    return (`$INSTANCE_NAME`_PS & `$INSTANCE_NAME`_MASK) >> `$INSTANCE_NAME`_SHIFT;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_ReadDataReg
********************************************************************************
*
* Summary:
*  Read the current value assigned to a Digital Port's data output register
*
* Parameters:  
*  None 
*
* Return: 
*  Returns the current value assigned to the Digital Port's data output register
*  
*******************************************************************************/
uint8 `$INSTANCE_NAME`_ReadDataReg(void) `=ReentrantKeil($INSTANCE_NAME ."_ReadDataReg")`
{
    return (`$INSTANCE_NAME`_DR & `$INSTANCE_NAME`_MASK) >> `$INSTANCE_NAME`_SHIFT;
}


/* If Interrupts Are Enabled for this Pins component */ 
#if defined(`$INSTANCE_NAME`_INTSTAT) 

    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_ClearInterrupt
    ********************************************************************************
    * Summary:
    *  Clears any active interrupts attached to port and returns the value of the 
    *  interrupt status register.
    *
    * Parameters:  
    *  None 
    *
    * Return: 
    *  Returns the value of the interrupt status register
    *  
    *******************************************************************************/
    uint8 `$INSTANCE_NAME`_ClearInterrupt(void) `=ReentrantKeil($INSTANCE_NAME ."_ClearInterrupt")`
    {
        return (`$INSTANCE_NAME`_INTSTAT & `$INSTANCE_NAME`_MASK) >> `$INSTANCE_NAME`_SHIFT;
    }

#endif /* If Interrupts Are Enabled for this Pins component */ 

#endif /* CY_PSOC5A... */

    
/* [] END OF FILE */
