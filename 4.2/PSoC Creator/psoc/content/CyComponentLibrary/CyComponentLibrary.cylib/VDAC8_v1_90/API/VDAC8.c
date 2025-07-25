/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c  
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code to the API for the 8-bit Voltage DAC 
*  (VDAC8) User Module.
*
* Note:
*  Any unusual or non-standard behavior should be noted here. Other-
*  wise, this section should remain blank.
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#include "cytypes.h"
#include "`$INSTANCE_NAME`.h"

#if (CY_PSOC5A)
#include <CyLib.h>
#endif /* CY_PSOC5A */

uint8 `$INSTANCE_NAME`_initVar = 0u;

#if (CY_PSOC5A)
    static uint8 `$INSTANCE_NAME`_restoreVal = 0u;
#endif /* CY_PSOC5A */

#if (CY_PSOC5A)
    static `$INSTANCE_NAME`_backupStruct `$INSTANCE_NAME`_backup;
#endif /* CY_PSOC5A */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Init
********************************************************************************
* Summary:
*  Initialize to the schematic state.
* 
* Parameters:
*  void:
*
* Return:
*  void
*
* Theory:
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_Init(void) `=ReentrantKeil($INSTANCE_NAME . "_Init")`
{
    `$INSTANCE_NAME`_CR0 = (`$INSTANCE_NAME`_MODE_V );

    /* Set default data source */
    #if(`$INSTANCE_NAME`_DEFAULT_DATA_SRC != 0 )
        `$INSTANCE_NAME`_CR1 = (`$INSTANCE_NAME`_DEFAULT_CNTL | `$INSTANCE_NAME`_DACBUS_ENABLE) ;
    #else
        `$INSTANCE_NAME`_CR1 = (`$INSTANCE_NAME`_DEFAULT_CNTL | `$INSTANCE_NAME`_DACBUS_DISABLE) ;
    #endif /* (`$INSTANCE_NAME`_DEFAULT_DATA_SRC != 0 ) */

    /* Set default strobe mode */
    #if(`$INSTANCE_NAME`_DEFAULT_STRB != 0)
        `$INSTANCE_NAME`_Strobe |= `$INSTANCE_NAME`_STRB_EN ;
    #endif/* (`$INSTANCE_NAME`_DEFAULT_STRB != 0) */

    /* Set default range */
    `$INSTANCE_NAME`_SetRange(`$INSTANCE_NAME`_DEFAULT_RANGE); 

    /* Set default speed */
    `$INSTANCE_NAME`_SetSpeed(`$INSTANCE_NAME`_DEFAULT_SPEED);
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Enable
********************************************************************************
* Summary:
*  Enable the VDAC8
* 
* Parameters:
*  void
*
* Return:
*  void
*
* Theory:
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_Enable(void) `=ReentrantKeil($INSTANCE_NAME . "_Enable")`
{
    `$INSTANCE_NAME`_PWRMGR |= `$INSTANCE_NAME`_ACT_PWR_EN;
    `$INSTANCE_NAME`_STBY_PWRMGR |= `$INSTANCE_NAME`_STBY_PWR_EN;

    /*This is to restore the value of register CR0 ,
    which is modified  in Stop API , this prevents misbehaviour of VDAC */
    #if (CY_PSOC5A)
        if(`$INSTANCE_NAME`_restoreVal == 1u) 
        {
             `$INSTANCE_NAME`_CR0 = `$INSTANCE_NAME`_backup.data_value;
             `$INSTANCE_NAME`_restoreVal = 0u;
        }
    #endif /* CY_PSOC5A */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Start
********************************************************************************
*
* Summary:
*  The start function initializes the voltage DAC with the default values, 
*  and sets the power to the given level.  A power level of 0, is the same as
*  executing the stop function.
*
* Parameters:
*  Power: Sets power level between off (0) and (3) high power
*
* Return:
*  void 
*
* Global variables:
*  `$INSTANCE_NAME`_initVar: Is modified when this function is called for the 
*  first time. Is used to ensure that initialization happens only once.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")` 
{
    /* Hardware initiazation only needs to occure the first time */
    if(`$INSTANCE_NAME`_initVar == 0u)
    { 
        `$INSTANCE_NAME`_Init();
        `$INSTANCE_NAME`_initVar = 1u;
    }

    /* Enable power to DAC */
    `$INSTANCE_NAME`_Enable();

    /* Set default value */
    `$INSTANCE_NAME`_SetValue(`$INSTANCE_NAME`_DEFAULT_DATA); 
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Stop
********************************************************************************
*
* Summary:
*  Powers down DAC to lowest power state.
*
* Parameters:
*  void
*
* Return:
*  void
*
* Theory:
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_Stop(void) `=ReentrantKeil($INSTANCE_NAME . "_Stop")`
{
    /* Disble power to DAC */
    `$INSTANCE_NAME`_PWRMGR &= (uint8)(~`$INSTANCE_NAME`_ACT_PWR_EN);
    `$INSTANCE_NAME`_STBY_PWRMGR &= (uint8)(~`$INSTANCE_NAME`_STBY_PWR_EN);

    /* This is a work around for PSoC5A  ,
    this sets VDAC to current mode with output off */
    #if (CY_PSOC5A)
        `$INSTANCE_NAME`_backup.data_value = `$INSTANCE_NAME`_CR0;
        `$INSTANCE_NAME`_CR0 = `$INSTANCE_NAME`_CUR_MODE_OUT_OFF;
        `$INSTANCE_NAME`_restoreVal = 1u;
    #endif /* CY_PSOC5A */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetSpeed
********************************************************************************
*
* Summary:
*  Set DAC speed
*
* Parameters:
*  power: Sets speed value
*
* Return:
*  void
*
* Theory:
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetSpeed(uint8 speed) `=ReentrantKeil($INSTANCE_NAME . "_SetSpeed")`
{
    /* Clear power mask then write in new value */
    `$INSTANCE_NAME`_CR0 &= (uint8)(~`$INSTANCE_NAME`_HS_MASK);
    `$INSTANCE_NAME`_CR0 |=  (speed & `$INSTANCE_NAME`_HS_MASK);
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetRange
********************************************************************************
*
* Summary:
*  Set one of three current ranges.
*
* Parameters:
*  Range: Sets one of Three valid ranges.
*
* Return:
*  void 
*
* Theory:
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetRange(uint8 range) `=ReentrantKeil($INSTANCE_NAME . "_SetRange")`
{
    `$INSTANCE_NAME`_CR0 &= (uint8)(~`$INSTANCE_NAME`_RANGE_MASK);      /* Clear existing mode */
    `$INSTANCE_NAME`_CR0 |= (range & `$INSTANCE_NAME`_RANGE_MASK);      /*  Set Range  */
    `$INSTANCE_NAME`_DacTrim();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetValue
********************************************************************************
*
* Summary:
*  Set 8-bit DAC value
*
* Parameters:  
*  value:  Sets DAC value between 0 and 255.
*
* Return: 
*  void 
*
* Theory: 
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetValue(uint8 value) `=ReentrantKeil($INSTANCE_NAME . "_SetValue")`
{
    #if (CY_PSOC5A)
        uint8 `$INSTANCE_NAME`_intrStatus = CyEnterCriticalSection();
    #endif /* CY_PSOC5A */

    `$INSTANCE_NAME`_Data = value;                /*  Set Value  */

    /* PSOC5A requires a double write */
    /* Exit Critical Section */
    #if (CY_PSOC5A)
        `$INSTANCE_NAME`_Data = value;
        CyExitCriticalSection(`$INSTANCE_NAME`_intrStatus);
    #endif /* CY_PSOC5A */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_DacTrim
********************************************************************************
*
* Summary:
*  Set the trim value for the given range.
*
* Parameters:
*  range:  1V or 4V range.  See constants.
*
* Return:
*  void
*
* Theory: 
*
* Side Effects:
*
*******************************************************************************/
void `$INSTANCE_NAME`_DacTrim(void) `=ReentrantKeil($INSTANCE_NAME . "_DacTrim")`
{
    uint8 mode;

    mode = (uint8)((`$INSTANCE_NAME`_CR0 & `$INSTANCE_NAME`_RANGE_MASK) >> 2) + `$INSTANCE_NAME`_TRIM_M7_1V_RNG_OFFSET;
    `$INSTANCE_NAME`_TR = CY_GET_XTND_REG8((uint8 *)(`$INSTANCE_NAME`_DAC_TRIM_BASE + mode));
}


/* [] END OF FILE */
