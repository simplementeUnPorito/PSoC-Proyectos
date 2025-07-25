/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c  
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code to the API for the PGA 
*  User Module.
*
* Note:
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#include "`$INSTANCE_NAME`.h"

#if (!CY_PSOC5A)
    #if (CYDEV_VARIABLE_VDDA == 1u)
        #include "CyScBoostClk.h"
    #endif /* (CYDEV_VARIABLE_VDDA == 1u) */
#endif /* (!CY_PSOC5A) */

#if (CY_PSOC5A)
    static `$INSTANCE_NAME`_BACKUP_STRUCT  `$INSTANCE_NAME`_P5backup;
#endif /* (CY_ PSOC5A) */

uint8 `$INSTANCE_NAME`_initVar = 0u;


/*******************************************************************************   
* Function Name: `$INSTANCE_NAME`_Init
********************************************************************************
*
* Summary:
*  Initialize component's parameters to the parameters set by user in the 
*  customizer of the component placed onto schematic. Usually called in 
*  `$INSTANCE_NAME`_Start().
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Init(void) `=ReentrantKeil($INSTANCE_NAME . "_Init")`
{
    /* Set PGA mode */
    `$INSTANCE_NAME`_CR0_REG = `$INSTANCE_NAME`_MODE_PGA;      
    /* Set non-inverting PGA mode and reference mode */
    `$INSTANCE_NAME`_CR1_REG |= `$INSTANCE_NAME`_PGA_NINV;  
    /* Set default gain and ref mode */
    `$INSTANCE_NAME`_CR2_REG = `$INSTANCE_NAME`_VREF_MODE;
    /* Set gain and compensation */
    `$INSTANCE_NAME`_SetGain(`$INSTANCE_NAME`_DEFAULT_GAIN);
    /* Set power */
    `$INSTANCE_NAME`_SetPower(`$INSTANCE_NAME`_DEFAULT_POWER);
}


/*******************************************************************************   
* Function Name: `$INSTANCE_NAME`_Enable
********************************************************************************
*
* Summary:
*  Enables the PGA block operation.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Enable(void) `=ReentrantKeil($INSTANCE_NAME . "_Enable")`
{
    /* This is to restore the value of register CR1 and CR2 which is saved 
      in prior to the modifications in stop() API */
    #if (CY_PSOC5A)
        if(`$INSTANCE_NAME`_P5backup.enableState == 1u)
        {
            `$INSTANCE_NAME`_CR1_REG = `$INSTANCE_NAME`_P5backup.scCR1Reg;
            `$INSTANCE_NAME`_CR2_REG = `$INSTANCE_NAME`_P5backup.scCR2Reg;
            `$INSTANCE_NAME`_P5backup.enableState = 0u;
        }
    #endif /* CY_PSOC5A */   

    /* Enable power to the Amp in Active mode*/
    `$INSTANCE_NAME`_PM_ACT_CFG_REG |= `$INSTANCE_NAME`_ACT_PWR_EN;

    /* Enable power to the Amp in Alternative Active mode*/
    `$INSTANCE_NAME`_PM_STBY_CFG_REG |= `$INSTANCE_NAME`_STBY_PWR_EN;
    
    `$INSTANCE_NAME`_PUMP_CR1_REG |= `$INSTANCE_NAME`_PUMP_CR1_SC_CLKSEL;
    
    #if (!CY_PSOC5A)
        #if (CYDEV_VARIABLE_VDDA == 1u)
            if(CyScPumpEnabled == 1u)
            {
                `$INSTANCE_NAME`_BSTCLK_REG &= (uint8)(~`$INSTANCE_NAME`_BST_CLK_INDEX_MASK);
                `$INSTANCE_NAME`_BSTCLK_REG |= `$INSTANCE_NAME`_BST_CLK_EN | CyScBoostClk__INDEX;
                `$INSTANCE_NAME`_SC_MISC_REG |= `$INSTANCE_NAME`_PUMP_FORCE;
                CyScBoostClk_Start();
            }
            else
            {
                `$INSTANCE_NAME`_BSTCLK_REG &= (uint8)(~`$INSTANCE_NAME`_BST_CLK_EN);
                `$INSTANCE_NAME`_SC_MISC_REG &= (uint8)(~`$INSTANCE_NAME`_PUMP_FORCE);
            }
        #endif /* (CYDEV_VARIABLE_VDDA == 1u) */
    #endif /* (!CY_PSOC5A) */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Start
********************************************************************************
*
* Summary:
*  The start function initializes the PGA with the default values and sets
*  the power to the given level. A power level of 0, is same as executing
*  the stop function.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`
{

    /* This is to restore the value of register CR1 and CR2 which is saved 
      in prior to the modification in stop() API */

    if(`$INSTANCE_NAME`_initVar == 0u)
    {
        `$INSTANCE_NAME`_Init();
        `$INSTANCE_NAME`_initVar = 1u;
    }

    `$INSTANCE_NAME`_Enable();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Stop
********************************************************************************
*
* Summary:
*  Powers down amplifier to lowest power state.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Stop(void) `=ReentrantKeil($INSTANCE_NAME . "_Stop")`
{ 
    /* Disble power to the Amp in Active mode template */
    `$INSTANCE_NAME`_PM_ACT_CFG_REG &= (uint8)(~`$INSTANCE_NAME`_ACT_PWR_EN);

    /* Disble power to the Amp in Alternative Active mode template */
    `$INSTANCE_NAME`_PM_STBY_CFG_REG &= (uint8)(~`$INSTANCE_NAME`_STBY_PWR_EN);

    #if (!CY_PSOC5A)
        #if (CYDEV_VARIABLE_VDDA == 1u)
            `$INSTANCE_NAME`_BSTCLK_REG &= (uint8)(~`$INSTANCE_NAME`_BST_CLK_EN);
            /* Disable pumps only if there aren't any SC block in use */
            if ((`$INSTANCE_NAME`_PM_ACT_CFG_REG & `$INSTANCE_NAME`_PM_ACT_CFG_MASK) == 0u)
            {
                `$INSTANCE_NAME`_SC_MISC_REG &= (uint8)(~`$INSTANCE_NAME`_PUMP_FORCE);
                `$INSTANCE_NAME`_PUMP_CR1_REG &= (uint8)(~`$INSTANCE_NAME`_PUMP_CR1_SC_CLKSEL);
                CyScBoostClk_Stop();
            }
        #endif /* CYDEV_VARIABLE_VDDA == 1u */
    #endif /* (CY_PSOC3 || CY_PSOC5LP) */

    /* This sets PGA in zero current mode and output routes are valid */
    #if (CY_PSOC5A)
        `$INSTANCE_NAME`_P5backup.scCR1Reg = `$INSTANCE_NAME`_CR1_REG;
        `$INSTANCE_NAME`_P5backup.scCR2Reg = `$INSTANCE_NAME`_CR2_REG;
        `$INSTANCE_NAME`_CR1_REG = 0x00u;
        `$INSTANCE_NAME`_CR2_REG = 0x00u;
        `$INSTANCE_NAME`_P5backup.enableState = 1u;
    #endif /* CY_PSOC5A */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetPower
********************************************************************************
*
* Summary:
*  Set the power of the PGA.
*
* Parameters:
*  power: Sets power level between (0) and (3) high power
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetPower(uint8 power) `=ReentrantKeil($INSTANCE_NAME . "_SetPower")`
{
    uint8 tmpCR;

    tmpCR = `$INSTANCE_NAME`_CR1_REG & (uint8)(~`$INSTANCE_NAME`_DRIVE_MASK);
    tmpCR |= (power & `$INSTANCE_NAME`_DRIVE_MASK);
    `$INSTANCE_NAME`_CR1_REG = tmpCR;  
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetGain
********************************************************************************
*
* Summary:
*  This function sets values of the input and feedback resistors to set a 
*  specific gain of the amplifier.
*
* Parameters:
*  gain: Gain value of PGA (See header file for gain values.)
*
* Return:
*  void 
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetGain(uint8 gain) `=ReentrantKeil($INSTANCE_NAME . "_SetGain")`
{
    /* Constant array for gain settings */
    const uint8 `$INSTANCE_NAME`_GainArray[9] = { 
        (`$INSTANCE_NAME`_RVAL_0K   | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=1  */
        (`$INSTANCE_NAME`_RVAL_40K  | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=2  */
        (`$INSTANCE_NAME`_RVAL_120K | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=4  */
        (`$INSTANCE_NAME`_RVAL_280K | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=8  */
        (`$INSTANCE_NAME`_RVAL_600K | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=16 */
        (`$INSTANCE_NAME`_RVAL_460K | `$INSTANCE_NAME`_R20_40B_40K | `$INSTANCE_NAME`_BIAS_LOW), /* G=24, Sets Rin as 20k */
        (`$INSTANCE_NAME`_RVAL_620K | `$INSTANCE_NAME`_R20_40B_20K | `$INSTANCE_NAME`_BIAS_LOW), /* G=32 */
        (`$INSTANCE_NAME`_RVAL_470K | `$INSTANCE_NAME`_R20_40B_20K | `$INSTANCE_NAME`_BIAS_LOW), /* G=48, Sets Rin as 10k */
        (`$INSTANCE_NAME`_RVAL_490K | `$INSTANCE_NAME`_R20_40B_20K | `$INSTANCE_NAME`_BIAS_LOW)  /* G=50, Sets Rin as 10k */
    };
    
    /* Constant array for gain compenstion settings */
    const uint8 `$INSTANCE_NAME`_GainComp[9] = { 
        ( `$INSTANCE_NAME`_COMP_4P35PF  | (uint8)( `$INSTANCE_NAME`_REDC_00 >> 2 )), /* G=1  */
        ( `$INSTANCE_NAME`_COMP_4P35PF  | (uint8)( `$INSTANCE_NAME`_REDC_01 >> 2 )), /* G=2  */
        ( `$INSTANCE_NAME`_COMP_3P0PF   | (uint8)( `$INSTANCE_NAME`_REDC_01 >> 2 )), /* G=4  */
        ( `$INSTANCE_NAME`_COMP_3P0PF   | (uint8)( `$INSTANCE_NAME`_REDC_01 >> 2 )), /* G=8  */
        ( `$INSTANCE_NAME`_COMP_3P6PF   | (uint8)( `$INSTANCE_NAME`_REDC_01 >> 2 )), /* G=16 */
        ( `$INSTANCE_NAME`_COMP_3P6PF   | (uint8)( `$INSTANCE_NAME`_REDC_11 >> 2 )), /* G=24 */
        ( `$INSTANCE_NAME`_COMP_3P6PF   | (uint8)( `$INSTANCE_NAME`_REDC_11 >> 2 )), /* G=32 */
        ( `$INSTANCE_NAME`_COMP_3P6PF   | (uint8)( `$INSTANCE_NAME`_REDC_00 >> 2 )), /* G=48 */
        ( `$INSTANCE_NAME`_COMP_3P6PF   | (uint8)( `$INSTANCE_NAME`_REDC_00 >> 2 ))  /* G=50 */
    };
    
    /* Only set new gain if it is a valid gain */
    if( gain <= `$INSTANCE_NAME`_GAIN_MAX)
    {
        /* Clear resistors, redc, and bias */
        `$INSTANCE_NAME`_CR2_REG &= (uint8)(~(`$INSTANCE_NAME`_RVAL_MASK | `$INSTANCE_NAME`_R20_40B_MASK | 
                                `$INSTANCE_NAME`_REDC_MASK | `$INSTANCE_NAME`_BIAS_MASK ));

        /* Set gain value resistors, redc comp, and bias */
        `$INSTANCE_NAME`_CR2_REG |= (`$INSTANCE_NAME`_GainArray[gain] |
                                ((uint8)(`$INSTANCE_NAME`_GainComp[gain] << 2 ) & `$INSTANCE_NAME`_REDC_MASK));

        /* Clear sc_comp  */
        `$INSTANCE_NAME`_CR1_REG &= (uint8)(~`$INSTANCE_NAME`_COMP_MASK);
        /* Set sc_comp  */
        `$INSTANCE_NAME`_CR1_REG |= ( `$INSTANCE_NAME`_GainComp[gain] | `$INSTANCE_NAME`_COMP_MASK );
    }
}


/* [] END OF FILE */
