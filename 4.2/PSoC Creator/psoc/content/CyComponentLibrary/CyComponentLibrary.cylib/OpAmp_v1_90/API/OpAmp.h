/*******************************************************************************
* File Name: `$INSTANCE_NAME`.h  
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file contains the function prototypes and constants used in
*  the OpAmp (Analog Buffer) Component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/


#if !defined(CY_OPAMP_`$INSTANCE_NAME`_H) 
#define CY_OPAMP_`$INSTANCE_NAME`_H 

#include "cyfitter.h"
#include "cytypes.h"
#include "CyLib.h"

/* Check to see if required defines such as CY_PSOC5LP are available */
/* They are defined starting with cy_boot v3.0 */
#if !defined (CY_PSOC5LP)
    #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.0 or later
#endif /* (CY_ PSOC5LP) */


/***************************************
*   Data Struct Definition
***************************************/

/* Low power Mode API Support */
typedef struct
{
    uint8   enableState;
}   `$INSTANCE_NAME`_BACKUP_STRUCT;

/* Variable describes initial state of the component */
extern uint8 `$INSTANCE_NAME`_initVar;


/**************************************
*        Function Prototypes 
**************************************/

void `$INSTANCE_NAME`_Start(void)               `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
void `$INSTANCE_NAME`_Stop(void)                `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;
void `$INSTANCE_NAME`_SetPower(uint8 power)     `=ReentrantKeil($INSTANCE_NAME . "_SetPower")`;
void `$INSTANCE_NAME`_Sleep(void)               `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`;
void `$INSTANCE_NAME`_Wakeup(void)              `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
void `$INSTANCE_NAME`_SaveConfig(void)          `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`;
void `$INSTANCE_NAME`_RestoreConfig(void)       `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
void `$INSTANCE_NAME`_Init(void)                `=ReentrantKeil($INSTANCE_NAME . "_Init")`;
void `$INSTANCE_NAME`_Enable(void)              `=ReentrantKeil($INSTANCE_NAME . "_Enable")`;


/**************************************
*           API Constants
**************************************/

/* Power constants for SetPower() function */
#define `$INSTANCE_NAME`_LPOCPOWER              (0x00u)
#define `$INSTANCE_NAME`_LOWPOWER               (0x01u)
#define `$INSTANCE_NAME`_MEDPOWER               (0x02u)
#define `$INSTANCE_NAME`_HIGHPOWER              (0x03u)


/**************************************
*           Parameter Defaults        
**************************************/
#define `$INSTANCE_NAME`_DEFAULT_POWER          (`$Power`u)
#define `$INSTANCE_NAME`_DEFAULT_MODE           (`$Mode`u)


/**************************************
*             Registers
**************************************/

#define `$INSTANCE_NAME`_CR_REG                 (* (reg8 *) `$INSTANCE_NAME`_ABuf__CR)
#define `$INSTANCE_NAME`_CR_PTR                 (  (reg8 *) `$INSTANCE_NAME`_ABuf__CR)

#define `$INSTANCE_NAME`_MX_REG                 (* (reg8 *) `$INSTANCE_NAME`_ABuf__MX)
#define `$INSTANCE_NAME`_MX_PTR                 (  (reg8 *) `$INSTANCE_NAME`_ABuf__MX)

#define `$INSTANCE_NAME`_SW_REG                 (* (reg8 *) `$INSTANCE_NAME`_ABuf__SW)
#define `$INSTANCE_NAME`_SW_PTR                 (  (reg8 *) `$INSTANCE_NAME`_ABuf__SW)

/* Active mode power manager register */
#define `$INSTANCE_NAME`_PM_ACT_CFG_REG         (* (reg8 *) `$INSTANCE_NAME`_ABuf__PM_ACT_CFG)
#define `$INSTANCE_NAME`_PM_ACT_CFG_PTR         (  (reg8 *) `$INSTANCE_NAME`_ABuf__PM_ACT_CFG)

/* Alternative mode power manager register */
#define `$INSTANCE_NAME`_PM_STBY_CFG_REG        (* (reg8 *) `$INSTANCE_NAME`_ABuf__PM_STBY_CFG)
#define `$INSTANCE_NAME`_PM_STBY_CFG_PTR        (  (reg8 *) `$INSTANCE_NAME`_ABuf__PM_STBY_CFG)

/* ANIF.PUMP.CR1 Pump Configuration Register 1 */
#define `$INSTANCE_NAME`_PUMP_CR1_REG           (* (reg8 *) CYDEV_ANAIF_CFG_PUMP_CR1)
#define `$INSTANCE_NAME`_PUMP_CR1_PTR           (  (reg8 *) CYDEV_ANAIF_CFG_PUMP_CR1)

/* Trim register defines */
#define `$INSTANCE_NAME`_TR0_REG                (* (reg8 *) `$INSTANCE_NAME`_ABuf__TR0)
#define `$INSTANCE_NAME`_TR0_PTR                (  (reg8 *) `$INSTANCE_NAME`_ABuf__TR0)

#define `$INSTANCE_NAME`_TR1_REG                (* (reg8 *) `$INSTANCE_NAME`_ABuf__TR1)
#define `$INSTANCE_NAME`_TR1_PTR                (  (reg8 *) `$INSTANCE_NAME`_ABuf__TR1)


/**************************************
*       Register Constants
**************************************/

/* CX Analog Buffer Input Selection Register */

/* Power mode defines */

/* PM_ACT_CFG (Active Power Mode CFG Register) mask */ 
#define `$INSTANCE_NAME`_ACT_PWR_EN             `$INSTANCE_NAME`_ABuf__PM_ACT_MSK 
/* PM_STBY_CFG (Alternative Active Power Mode CFG Register) mask */ 
#define `$INSTANCE_NAME`_STBY_PWR_EN            `$INSTANCE_NAME`_ABuf__PM_STBY_MSK 
/* Power mask */
#define `$INSTANCE_NAME`_PWR_MASK               (0x03u)

/* MX Analog Buffer Input Selection Register */

/* Bit Field  MX_VN */
#define `$INSTANCE_NAME`_MX_VN_MASK             (0x30u)
#define `$INSTANCE_NAME`_MX_VN_NC               (0x00u)
#define `$INSTANCE_NAME`_MX_VN_AG4              (0x10u)
#define `$INSTANCE_NAME`_MX_VN_AG6              (0x20u)

/* Bit Field  MX_VP */
#define `$INSTANCE_NAME`_MX_VP_MASK             (0x0Fu)
#define `$INSTANCE_NAME`_MX_VP_NC               (0x00u)
#define `$INSTANCE_NAME`_MX_VP_VREF             (0x09u)
#define `$INSTANCE_NAME`_MX_VP_AG4              (0x01u)
#define `$INSTANCE_NAME`_MX_VP_AG5              (0x02u)
#define `$INSTANCE_NAME`_MX_VP_AG6              (0x03u)
#define `$INSTANCE_NAME`_MX_VP_AG7              (0x04u)
#define `$INSTANCE_NAME`_MX_VP_ABUS0            (0x05u)
#define `$INSTANCE_NAME`_MX_VP_ABUS1            (0x06u)
#define `$INSTANCE_NAME`_MX_VP_ABUS2            (0x07u)
#define `$INSTANCE_NAME`_MX_VP_ABUS3            (0x08u)

/* SW Analog Buffer Routing Switch Reg */

/* Bit Field  SW */
#define `$INSTANCE_NAME`_SW_MASK                (0x07u) 
#define `$INSTANCE_NAME`_SW_SWINP               (0x04u)  /* Enable positive input */
#define `$INSTANCE_NAME`_SW_SWINN               (0x02u)  /* Enable negative input */

/* Pump configuration register masks */
#define `$INSTANCE_NAME`_PUMP_CR1_CLKSEL        (0x40u)
#define `$INSTANCE_NAME`_PUMP_CR1_FORCE         (0x20u)
#define `$INSTANCE_NAME`_PUMP_CR1_AUTO          (0x10u)

#endif /* CY_OPAMP_`$INSTANCE_NAME`_H */


/* [] END OF FILE */
