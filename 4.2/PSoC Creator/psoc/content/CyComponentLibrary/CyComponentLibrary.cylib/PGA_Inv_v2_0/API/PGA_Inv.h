/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file contains the function prototypes and constants used in
*  the PGA_Inv User Module.
*
* Note:
*  None
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_PGA_Inv_`$INSTANCE_NAME`_H) 
#define CY_PGA_Inv_`$INSTANCE_NAME`_H 

#include "cytypes.h"
#include "cyfitter.h"
#include "CyLib.h"

/* Check to see if required defines such as CY_PSOC5LP are available */
/* They are defined starting with cy_boot v3.0 */
#if !defined (CY_PSOC5LP)
    #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.0 or later
#endif /* (CY_ PSOC5LP) */


#if(!CY_PSOC5A)
    #if(CYDEV_VARIABLE_VDDA == 1)
        #if (!defined(CY_LIB_SC_BST_CLK_EN))
            #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.30 or later
        #endif /* (!defined(CY_LIB_SC_BST_CLK_EN)) */
    #endif /* CYDEV_VARIABLE_VDDA == 1 */
#endif /* (!CY_PSOC5A) */

/***************************************
*   Data Struct Definition
***************************************/

/* Low power API Support */
typedef struct
{
    uint8   enableState;
    uint8   scCR0Reg;
    uint8   scCR1Reg;
    uint8   scCR2Reg;
}   `$INSTANCE_NAME`_BACKUP_STRUCT;


/* component init state */
extern uint8 `$INSTANCE_NAME`_initVar;


/***************************************
*        Function Prototypes 
***************************************/

void `$INSTANCE_NAME`_Start(void)                 `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
void `$INSTANCE_NAME`_Stop(void)                  `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;
void `$INSTANCE_NAME`_SetPower(uint8 power)       `=ReentrantKeil($INSTANCE_NAME . "_SetPower")`;
void `$INSTANCE_NAME`_SetGain(uint8 gain)         `=ReentrantKeil($INSTANCE_NAME . "_SetGain")`;
void `$INSTANCE_NAME`_Sleep(void)                 `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`;
void `$INSTANCE_NAME`_Wakeup(void)                `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
void `$INSTANCE_NAME`_SaveConfig(void)            `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`;
void `$INSTANCE_NAME`_RestoreConfig(void)         `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
void `$INSTANCE_NAME`_Init(void)                  `=ReentrantKeil($INSTANCE_NAME . "_Init")`;
void `$INSTANCE_NAME`_Enable(void)                `=ReentrantKeil($INSTANCE_NAME . "_Enable")`;


/***************************************
*           API Constants        
***************************************/

/* Power constants for SetPower function */
#define `$INSTANCE_NAME`_MINPOWER                 (0x00u)
#define `$INSTANCE_NAME`_LOWPOWER                 (0x01u)
#define `$INSTANCE_NAME`_MEDPOWER                 (0x02u)
#define `$INSTANCE_NAME`_HIGHPOWER                (0x03u)

/* Constants for SetGain function */
#define `$INSTANCE_NAME`_GAIN_01                  (0x00u)
#define `$INSTANCE_NAME`_GAIN_03                  (0x01u)
#define `$INSTANCE_NAME`_GAIN_07                  (0x02u)
#define `$INSTANCE_NAME`_GAIN_15                  (0x03u)
#define `$INSTANCE_NAME`_GAIN_22                  (0x04u)
#define `$INSTANCE_NAME`_GAIN_24                  (0x05u)
#define `$INSTANCE_NAME`_GAIN_31                  (0x06u)
#define `$INSTANCE_NAME`_GAIN_47                  (0x07u)
#define `$INSTANCE_NAME`_GAIN_49                  (0x08u)
#define `$INSTANCE_NAME`_GAIN_MAX                 (0x08u)


/***************************************
*       Initialization Values
***************************************/

#define `$INSTANCE_NAME`_DEFAULT_GAIN             (`$Inverting_Gain`u)
#define `$INSTANCE_NAME`_DEFAULT_POWER            (`$Power`u)


/***************************************
*              Registers
***************************************/

#define `$INSTANCE_NAME`_CR0_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__CR0 )
#define `$INSTANCE_NAME`_CR0_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__CR0 )
#define `$INSTANCE_NAME`_CR1_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__CR1 )
#define `$INSTANCE_NAME`_CR1_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__CR1 )
#define `$INSTANCE_NAME`_CR2_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__CR2 )
#define `$INSTANCE_NAME`_CR2_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__CR2 )
  /* Power manager */
#define `$INSTANCE_NAME`_PM_ACT_CFG_REG           (* (reg8 *) `$INSTANCE_NAME`_SC__PM_ACT_CFG )
#define `$INSTANCE_NAME`_PM_ACT_CFG_PTR           (  (reg8 *) `$INSTANCE_NAME`_SC__PM_ACT_CFG )
  /* Power manager */
#define `$INSTANCE_NAME`_PM_STBY_CFG_REG          (* (reg8 *) `$INSTANCE_NAME`_SC__PM_STBY_CFG )
#define `$INSTANCE_NAME`_PM_STBY_CFG_PTR          (  (reg8 *) `$INSTANCE_NAME`_SC__PM_STBY_CFG )

/* Switched Capacitor Routing Register */
#define `$INSTANCE_NAME`_SW0_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW0 )
#define `$INSTANCE_NAME`_SW0_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW0 )
#define `$INSTANCE_NAME`_SW2_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW2 )
#define `$INSTANCE_NAME`_SW2_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW2 )
#define `$INSTANCE_NAME`_SW3_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW3 )
#define `$INSTANCE_NAME`_SW3_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW3 )
#define `$INSTANCE_NAME`_SW4_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW4 )
#define `$INSTANCE_NAME`_SW4_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW4 )
#define `$INSTANCE_NAME`_SW6_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW6 )
#define `$INSTANCE_NAME`_SW6_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW6 )
#define `$INSTANCE_NAME`_SW7_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW7 )
#define `$INSTANCE_NAME`_SW7_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW7 )
#define `$INSTANCE_NAME`_SW8_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__SW8 )
#define `$INSTANCE_NAME`_SW8_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__SW8 )
#define `$INSTANCE_NAME`_SW10_REG                 (* (reg8 *) `$INSTANCE_NAME`_SC__SW10 )
#define `$INSTANCE_NAME`_SW10_PTR                 (  (reg8 *) `$INSTANCE_NAME`_SC__SW10 )

/* Switched Capacitor Clock Selection Register */
#define `$INSTANCE_NAME`_CLK_REG                  (* (reg8 *) `$INSTANCE_NAME`_SC__CLK )
#define `$INSTANCE_NAME`_CLK_PTR                  (  (reg8 *) `$INSTANCE_NAME`_SC__CLK )

/* Switched Capacitor Boost Clock Selection Register */
#define `$INSTANCE_NAME`_BSTCLK_REG               (* (reg8 *) `$INSTANCE_NAME`_SC__BST )
#define `$INSTANCE_NAME`_BSTCLK_PTR               (  (reg8 *) `$INSTANCE_NAME`_SC__BST )

 /* Pump clock selectin register */
#define `$INSTANCE_NAME`_PUMP_CR1_REG             (* (reg8 *) CYDEV_ANAIF_CFG_PUMP_CR1)
#define `$INSTANCE_NAME`_PUMP_CR1_PTR             (  (reg8 *) CYDEV_ANAIF_CFG_PUMP_CR1)

/* Pump Register for SC block */
#define `$INSTANCE_NAME`_SC_MISC_REG              (* (reg8 *) CYDEV_ANAIF_RT_SC_MISC)
#define `$INSTANCE_NAME`_SC_MISC_PTR              (  (reg8 *) CYDEV_ANAIF_RT_SC_MISC)

/* PM_ACT_CFG (Active Power Mode CFG Register) mask */ 
#define `$INSTANCE_NAME`_ACT_PWR_EN               `$INSTANCE_NAME`_SC__PM_ACT_MSK
#define `$INSTANCE_NAME`_STBY_PWR_EN              `$INSTANCE_NAME`_SC__PM_STBY_MSK


/***************************************
*           Register Constants
***************************************/

/* CR0 SC/CT Control Register 0 definitions */
#define `$INSTANCE_NAME`_MODE_PGA                 (0x0Cu)

/* CR1 SC/CT Control Register 1 definitions */

/* Bit Field  SC_COMP_ENUM */
#define `$INSTANCE_NAME`_COMP_MASK                (0x0Cu)
#define `$INSTANCE_NAME`_COMP_3P0PF               (0x00u)
#define `$INSTANCE_NAME`_COMP_3P6PF               (0x04u)
#define `$INSTANCE_NAME`_COMP_4P35PF              (0x08u)
#define `$INSTANCE_NAME`_COMP_5P1PF               (0x0Cu)

/* Bit Field  SC_DIV2_ENUM */
#define `$INSTANCE_NAME`_DIV2_MASK                (0x10u)
#define `$INSTANCE_NAME`_DIV2_DISABLE             (0x00u)
#define `$INSTANCE_NAME`_DIV2_ENABLE              (0x10u)

/* Bit Field  SC_DRIVE_ENUM */
#define `$INSTANCE_NAME`_DRIVE_MASK               (0x03u)
#define `$INSTANCE_NAME`_DRIVE_280UA              (0x00u)
#define `$INSTANCE_NAME`_DRIVE_420UA              (0x01u)
#define `$INSTANCE_NAME`_DRIVE_530UA              (0x02u)
#define `$INSTANCE_NAME`_DRIVE_650UA              (0x03u)

/* Bit Field  SC_PGA_MODE_ENUM */
#define `$INSTANCE_NAME`_PGA_MODE_MASK            (0x20u)
#define `$INSTANCE_NAME`_PGA_INV                  (0x00u)
#define `$INSTANCE_NAME`_PGA_NINV                 (0x20u)

/* CR2 SC/CT Control Register 2 definitions */

/* Bit Field  SC_BIAS_CONTROL_ENUM */
#define `$INSTANCE_NAME`_BIAS_MASK                (0x01u)
#define `$INSTANCE_NAME`_BIAS_NORMAL              (0x00u)
#define `$INSTANCE_NAME`_BIAS_LOW                 (0x01u)

/* Bit Field  SC_PGA_GNDVREF_ENUM */
#define `$INSTANCE_NAME`_GNDVREF_MASK             (0x80u)
#define `$INSTANCE_NAME`_GNDVREF_DI               (0x00u)
#define `$INSTANCE_NAME`_GNDVREF_E                (0x80u)

/* Bit Field  SC_R20_40B_ENUM */
#define `$INSTANCE_NAME`_R20_40B_MASK             (0x02u)
#define `$INSTANCE_NAME`_R20_40B_40K              (0x00u)
#define `$INSTANCE_NAME`_R20_40B_20K              (0x02u)

/* Bit Field  SC_REDC_ENUM */
#define `$INSTANCE_NAME`_REDC_MASK                (0x0Cu)
#define `$INSTANCE_NAME`_REDC_00                  (0x00u)
#define `$INSTANCE_NAME`_REDC_01                  (0x04u)
#define `$INSTANCE_NAME`_REDC_10                  (0x08u)
#define `$INSTANCE_NAME`_REDC_11                  (0x0Cu)

/* Bit Field  SC_RVAL_ENUM */
#define `$INSTANCE_NAME`_RVAL_MASK                (0x70u)
#define `$INSTANCE_NAME`_RVAL_20K                 (0x00u)
#define `$INSTANCE_NAME`_RVAL_30K                 (0x10u)
#define `$INSTANCE_NAME`_RVAL_40K                 (0x20u)
#define `$INSTANCE_NAME`_RVAL_60K                 (0x30u)
#define `$INSTANCE_NAME`_RVAL_120K                (0x40u)
#define `$INSTANCE_NAME`_RVAL_250K                (0x50u)
#define `$INSTANCE_NAME`_RVAL_500K                (0x60u)
#define `$INSTANCE_NAME`_RVAL_1000K               (0x70u)

/* SC_MISC constants */
#define `$INSTANCE_NAME`_PUMP_FORCE               (0x20u)
#define `$INSTANCE_NAME`_PUMP_AUTO                (0x10u)
#define `$INSTANCE_NAME`_DIFF_PGA_1_3             (0x02u)
#define `$INSTANCE_NAME`_DIFF_PGA_0_2             (0x01u)

/* Bit Field  PGA_INVERTING_GAIN_ENUM */
#define `$INSTANCE_NAME`_PGA_INV_GAIN_MASK        (0x72u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_00          (0x00u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_01          (0x10u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_03          (0x20u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_07          (0x30u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_15          (0x40u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_22          (0x50u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_24          (0x70u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_31          (0x52u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_47          (0x62u)
#define `$INSTANCE_NAME`_PGA_INV_GAIN_49          (0x72u)

/* ANIF.PUMP.CR1 Constants */
#define `$INSTANCE_NAME`_PUMP_CR1_SC_CLKSEL       (0x80u)

#define `$INSTANCE_NAME`_SC_REG_CLR               (0x00u)

/* Boost Clock Enable */
#define `$INSTANCE_NAME`_BST_CLK_EN               (0x08u)
#define `$INSTANCE_NAME`_BST_CLK_INDEX_MASK       (0x07u)
#define `$INSTANCE_NAME`_PM_ACT_CFG_MASK          (0x0Fu)

/* Constants for VDDA Threshold */
#define `$INSTANCE_NAME`_CYDEV_VDDA_MV             (CYDEV_VDDA_MV)
#define `$INSTANCE_NAME`_MINIMUM_VDDA_THRESHOLD_MV (2700u)

/*******************************************************************************
* Following code are OBSOLETE and must not be used starting from PGA_inv 2.0
*******************************************************************************/
#define `$INSTANCE_NAME`_BST_REG            (`$INSTANCE_NAME`_BSTCLK_REG)
#define `$INSTANCE_NAME`_BST_PTR            (`$INSTANCE_NAME`_BSTCLK_PTR)

#endif /* CY_PGA_Inv_`$INSTANCE_NAME`_H */


/* [] END OF FILE */
