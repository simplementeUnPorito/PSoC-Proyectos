/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c  
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code to the API for the TIA User Module.
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

/* Fixed configuration of SC Block only performed once */
uint8 `$INSTANCE_NAME`_initVar = 0u;

#if (CY_PSOC5A)
    static `$INSTANCE_NAME`_BACKUP_STRUCT  `$INSTANCE_NAME`_P5backup;
#endif /* (CY_PSOC5A) */


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
    /* Set SC Block Mode to TIA - SCxx_CR0[3:1] */
    `$INSTANCE_NAME`_CR0_REG = `$INSTANCE_NAME`_MODE_TIA;
    
    /*    Set SC Block CR1 Control Register fields to support TIA mode 
            drive field set by SetPower() API
            compensation Cap - 5.1 pF
            div2 - disable, n/a for TIA mode
            Mixer/PGA Gain - 0db, n/a for TIA mode   */

    `$INSTANCE_NAME`_CR1_REG = (`$INSTANCE_NAME`_COMP_5P1PF |
                                `$INSTANCE_NAME`_DIV2_DISABLE |
                                `$INSTANCE_NAME`_GAIN_0DB);


    /*    Set SC Block CR2 Control Register fields to support TIA mode
            Bias - Low
            r20_r40 - 40K, n/a for TIA mode
            redc - set by SetCapFB() API
            rval - set by SetResFB() API
            PGA Ground Ref - disable, n/a for TIA mode    */

    `$INSTANCE_NAME`_CR2_REG = (`$INSTANCE_NAME`_BIAS_LOW |
                                `$INSTANCE_NAME`_R20_40B_40K |
                                `$INSTANCE_NAME`_GNDVREF_DI);
                          
    /* Set default resistive feedback value */
    `$INSTANCE_NAME`_SetResFB(`$INSTANCE_NAME`_INIT_RES_FEEDBACK);
      
    /* Set default capacitive feedback value */
    `$INSTANCE_NAME`_SetCapFB(`$INSTANCE_NAME`_INIT_CAP_FEEDBACK);

    /* Set default power */
    `$INSTANCE_NAME`_SetPower(`$INSTANCE_NAME`_INIT_POWER);
}


/*******************************************************************************   
* Function Name: `$INSTANCE_NAME`_Enable
********************************************************************************
*
* Summary:
*  Enables the TIA block operation
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
            `$INSTANCE_NAME`_CR2_REG =`$INSTANCE_NAME`_P5backup.scCR2Reg;
            `$INSTANCE_NAME`_P5backup.enableState = 0u;
        }
    #endif
    /* Enable power to Amp in Active mode */
    `$INSTANCE_NAME`_PM_ACT_CFG_REG |= `$INSTANCE_NAME`_ACT_PWR_EN;

    /* Enable the power to Amp in Alternative active mode*/
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
*  The start function initializes the TIA with the default values and enables
*  power to the SC block.
*
* Parameters:
*  void
*
* Return:
*  void 
*
* Global variables:
*  `$INSTANCE_NAME`_initVar: Used to check the initial configuration, modified 
*  when this function is called for the first time.
*
* Theory:
*  Full initialization of the SC Block configuration registers is only perfomed
*  the first time the routine executes - global variable  is used to
*  `$INSTANCE_NAME`_initVar is used to indicate that the static configuration 
*  has been completed.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`
{
    if(`$INSTANCE_NAME`_initVar == 0u)
    {
        `$INSTANCE_NAME`_initVar = 1u;  
        `$INSTANCE_NAME`_Init();
    }

    `$INSTANCE_NAME`_Enable();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Stop
********************************************************************************
*
* Summary: 
*  Disables power to SC block.
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
     /* Disble power to the Amp in Active mode template*/
    `$INSTANCE_NAME`_PM_ACT_CFG_REG &= (uint8)(~`$INSTANCE_NAME`_ACT_PWR_EN);

    /* Disble power to the Amp in Alternative active mode template*/
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
        
    /* This sets TIA in zero current mode and output routes are valid */
    #if (CY_PSOC5A)
        `$INSTANCE_NAME`_P5backup.scCR1Reg = `$INSTANCE_NAME`_CR1_REG;
        `$INSTANCE_NAME`_P5backup.scCR2Reg = `$INSTANCE_NAME`_CR2_REG;
        `$INSTANCE_NAME`_CR1_REG = 0x00u;
        `$INSTANCE_NAME`_CR2_REG = 0x00u;
        `$INSTANCE_NAME`_P5backup.enableState = 1u;
    #endif /* (CY_PSOC5A) */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetPower
********************************************************************************
*
* Summary:
*  Set the drive power of the TIA.
*
* Parameters:
*  Power: Sets power level between (0) and (3) high power.
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetPower(uint8 power) `=ReentrantKeil($INSTANCE_NAME . "_SetPower")`
{
    uint8 tmpCR;

    /* Sets drive bits in SC Block Control Register 1:  SCxx_CR[1:0] */
    tmpCR = `$INSTANCE_NAME`_CR1_REG & (uint8)(~`$INSTANCE_NAME`_DRIVE_MASK);
    tmpCR |= (power & `$INSTANCE_NAME`_DRIVE_MASK);
    `$INSTANCE_NAME`_CR1_REG = tmpCR;  
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetResFB
********************************************************************************
*
* Summary:
*  This function sets value for the resistive feedback of the amplifier.
*
* Parameters:
*  res_feedback: specifies resistive feedback value (see header file for gain 
*                values.)
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetResFB(uint8 res_feedback) `=ReentrantKeil($INSTANCE_NAME . "_SetResFB")`
{
    /* Only set new gain if it is a valid gain */
    if( res_feedback <= `$INSTANCE_NAME`_RES_FEEDBACK_MAX)
    {
        /* Clear SCxx_CR2 rval bits - SCxx_CR2[6:4] */
        `$INSTANCE_NAME`_CR2_REG &= (uint8)(~`$INSTANCE_NAME`_RVAL_MASK);

        /* Set resistive feedback value */
        `$INSTANCE_NAME`_CR2_REG |= (uint8)(res_feedback << 4);
    }
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetCapFB
********************************************************************************
*
* Summary:
*  This function sets the value for the capacitive feedback of the amplifier.
*
* Parameters:
*  cap_feedback: specifies capacitive feedback value (see header file for gain 
*                values.)
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetCapFB(uint8 cap_feedback) `=ReentrantKeil($INSTANCE_NAME . "_SetCapFB")`
{
    /* Only set new gain if it is a valid gain */
    if( cap_feedback <= `$INSTANCE_NAME`_CAP_FEEDBACK_MAX)
    {
        /* Clear SCxx_CR2 redc bits -  - CR2[3:2] */
        `$INSTANCE_NAME`_CR2_REG &= (uint8)(~`$INSTANCE_NAME`_REDC_MASK);

        /* Set redc capacitive feedback value */
        `$INSTANCE_NAME`_CR2_REG |= (uint8)(cap_feedback << 2);
    }
}


/* [] END OF FILE */
