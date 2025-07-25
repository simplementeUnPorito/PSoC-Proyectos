/*******************************************************************************
* File Name: `$INSTANCE_NAME`.h
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides constants and parameter values for the PrISM
*  Component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/


#if !defined(CY_PrISM_`$INSTANCE_NAME`_H)    /* CY_PrISM_`$INSTANCE_NAME`_H */
#define CY_PrISM_`$INSTANCE_NAME`_H

#include "CyLib.h"
#include "cytypes.h"
#include "cyfitter.h"


/***************************************
* Conditional Compilation Parameters
***************************************/

/* Check to see if required defines such as CY_PSOC5LP are available */
/* They are defined starting with cy_boot v3.0 */
#if !defined (CY_PSOC5LP)
    #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.0 or later
#endif /* (CY_PSOC5LP) */


/***************************************
*    Initial Parameter Constants
***************************************/
                                     
#define `$INSTANCE_NAME`_RESOLUTION             (`$Resolution`u)
#define `$INSTANCE_NAME`_PULSE_TYPE_HARDCODED   (`$PulseTypeHardcoded`u)


/***************************************
*       Type defines
***************************************/

/* Sleep Mode API Support */
typedef struct
{
    uint8 enableState;
    #if(!`$INSTANCE_NAME`_PULSE_TYPE_HARDCODED)
        uint8 cr;
    #endif /* End `$INSTANCE_NAME`_PULSE_TYPE_HARDCODED */
    `$RegSizeReplacementString` seed;
    `$RegSizeReplacementString` seed_copy;
    `$RegSizeReplacementString` polynom;
    #if(CY_UDB_V0)
        `$RegSizeReplacementString` density0;
        `$RegSizeReplacementString` density1;
    #endif /* End CY_UDB_V0 */
} `$INSTANCE_NAME`_BACKUP_STRUCT;


/***************************************
*       Function Prototypes
***************************************/

void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
void `$INSTANCE_NAME`_Stop(void) `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;
void `$INSTANCE_NAME`_SetPulse0Mode(uint8 pulse0Type) `=ReentrantKeil($INSTANCE_NAME . "_SetPulse0Mode")`;
void `$INSTANCE_NAME`_SetPulse1Mode(uint8 pulse1Type) `=ReentrantKeil($INSTANCE_NAME . "_SetPulse1Mode")`;
`$RegSizeReplacementString` `$INSTANCE_NAME`_ReadSeed(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadSeed")`;
void `$INSTANCE_NAME`_WriteSeed(`$RegSizeReplacementString` seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeed")`;
`$RegSizeReplacementString` `$INSTANCE_NAME`_ReadPolynomial(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomial")`;
void `$INSTANCE_NAME`_WritePolynomial(`$RegSizeReplacementString` polynomial) \
                                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomial")`;
`$RegSizeReplacementString` `$INSTANCE_NAME`_ReadPulse0(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPulse0")`;
void `$INSTANCE_NAME`_WritePulse0(`$RegSizeReplacementString` pulseDensity0) \
                                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePulse0")`;
`$RegSizeReplacementString` `$INSTANCE_NAME`_ReadPulse1(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPulse1")`;
void `$INSTANCE_NAME`_WritePulse1(`$RegSizeReplacementString` pulseDensity1) \
                                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePulse1")`;
void `$INSTANCE_NAME`_Sleep(void) `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`;
void `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
void `$INSTANCE_NAME`_SaveConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`;
void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
void `$INSTANCE_NAME`_Enable(void) `=ReentrantKeil($INSTANCE_NAME . "_Enable")`;
void `$INSTANCE_NAME`_Init(void) `=ReentrantKeil($INSTANCE_NAME . "_Init")`;


/***************************************
*          API Constants
***************************************/

/* Constants for SetPulse0Mode(), SetPulse1Mode(), pulse type */
#define `$INSTANCE_NAME`_LESSTHAN_OR_EQUAL      (0x00u)
#define `$INSTANCE_NAME`_GREATERTHAN_OR_EQUAL   (0x01u)


/***************************************
* Global variables external identifier
***************************************/

extern uint8 `$INSTANCE_NAME`_initVar;


/***************************************
*    Initial Parameter Constants
***************************************/

#define `$INSTANCE_NAME`_POLYNOM                (`$PolyValue`)
#define `$INSTANCE_NAME`_SEED                   (`$SeedValue`)
#define `$INSTANCE_NAME`_DENSITY0               (`$Density0`)
#define `$INSTANCE_NAME`_DENSITY1               (`$Density1`)
#define `$INSTANCE_NAME`_COMPARE0               (`$CompareType0`u)
#define `$INSTANCE_NAME`_COMPARE1               (`$CompareType1`u)


/***************************************
*              Registers
***************************************/

#if (`$INSTANCE_NAME`_RESOLUTION  <= 8u) /* 8bit - PrISM */
    #define `$INSTANCE_NAME`_DENSITY0_REG       (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__D0_REG)
    #define `$INSTANCE_NAME`_DENSITY0_PTR       (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__D0_REG)
    #define `$INSTANCE_NAME`_DENSITY1_REG       (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__D1_REG)
    #define `$INSTANCE_NAME`_DENSITY1_PTR       (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__D1_REG)
    #define `$INSTANCE_NAME`_POLYNOM_REG        (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__A1_REG)
    #define `$INSTANCE_NAME`_POLYNOM_PTR        (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__A1_REG)
    #define `$INSTANCE_NAME`_SEED_REG           (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__A0_REG)
    #define `$INSTANCE_NAME`_SEED_PTR           (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__A0_REG)
    #define `$INSTANCE_NAME`_SEED_COPY_REG      (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__F0_REG)
    #define `$INSTANCE_NAME`_SEED_COPY_PTR      (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__F0_REG)
    #define `$INSTANCE_NAME`_AUX_CONTROL_REG    (* (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__DP_AUX_CTL_REG)
    #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    (  (reg8 *) `$INSTANCE_NAME`_sC8_PrISMdp_u0__DP_AUX_CTL_REG)
#elif (`$INSTANCE_NAME`_RESOLUTION <= 16u) /* 16bit - PrISM */
    #if(CY_PSOC3) /* 8-bit address space */
        #define `$INSTANCE_NAME`_DENSITY0_PTR       ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__D0_REG)
        #define `$INSTANCE_NAME`_DENSITY1_PTR       ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__D1_REG)
        #define `$INSTANCE_NAME`_POLYNOM_PTR        ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__A1_REG)
        #define `$INSTANCE_NAME`_SEED_PTR           ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__A0_REG)
        #define `$INSTANCE_NAME`_SEED_COPY_PTR      ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__F0_REG)
        #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__DP_AUX_CTL_REG)
    #else /* 16-bit address space */
        #define `$INSTANCE_NAME`_DENSITY0_PTR       ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_D0_REG)
        #define `$INSTANCE_NAME`_DENSITY1_PTR       ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_D1_REG)
        #define `$INSTANCE_NAME`_POLYNOM_PTR        ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_A1_REG)
        #define `$INSTANCE_NAME`_SEED_PTR           ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_A0_REG)
        #define `$INSTANCE_NAME`_SEED_COPY_PTR      ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_F0_REG)
        #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    ((reg16 *) `$INSTANCE_NAME`_sC16_PrISMdp_u0__16BIT_DP_AUX_CTL_REG)
    #endif /* CY_PSOC3 */
#elif (`$INSTANCE_NAME`_RESOLUTION <= 24u) /* 24bit - PrISM */
    #define `$INSTANCE_NAME`_DENSITY0_PTR       ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__D0_REG)
    #define `$INSTANCE_NAME`_DENSITY1_PTR       ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__D1_REG)
    #define `$INSTANCE_NAME`_POLYNOM_PTR        ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__A1_REG)
    #define `$INSTANCE_NAME`_SEED_PTR           ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__A0_REG)
    #define `$INSTANCE_NAME`_SEED_COPY_PTR      ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__F0_REG)
    #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    ((reg32 *) `$INSTANCE_NAME`_sC24_PrISMdp_u0__DP_AUX_CTL_REG)
#else /* 32bit - PrISM */
    #if(CY_PSOC3 || CY_PSOC5) /* 8-bit address space */
        #define `$INSTANCE_NAME`_DENSITY0_PTR       ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__D0_REG)
        #define `$INSTANCE_NAME`_DENSITY1_PTR       ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__D1_REG)
        #define `$INSTANCE_NAME`_POLYNOM_PTR        ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__A1_REG)
        #define `$INSTANCE_NAME`_SEED_PTR           ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__A0_REG)
        #define `$INSTANCE_NAME`_SEED_COPY_PTR      ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__F0_REG)
        #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__DP_AUX_CTL_REG)
    #else /* 32-bit address space */    
        #define `$INSTANCE_NAME`_DENSITY0_PTR       ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_D0_REG)
        #define `$INSTANCE_NAME`_DENSITY1_PTR       ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_D1_REG)
        #define `$INSTANCE_NAME`_POLYNOM_PTR        ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_A1_REG)
        #define `$INSTANCE_NAME`_SEED_PTR           ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_A0_REG)
        #define `$INSTANCE_NAME`_SEED_COPY_PTR      ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_F0_REG)
        #define `$INSTANCE_NAME`_AUX_CONTROL_PTR    ((reg32 *) `$INSTANCE_NAME`_sC32_PrISMdp_u0__32BIT_DP_AUX_CTL_REG)
    #endif
#endif /* End `$INSTANCE_NAME`_RESOLUTION */

#define `$INSTANCE_NAME`_CONTROL_REG   (* (reg8 *) `$INSTANCE_NAME`_`$CtlModeReplacementString`_ControlReg__CONTROL_REG)
#define `$INSTANCE_NAME`_CONTROL_PTR   (  (reg8 *) `$INSTANCE_NAME`_`$CtlModeReplacementString`_ControlReg__CONTROL_REG)


/***************************************
*       Register Constants
***************************************/

#define `$INSTANCE_NAME`_CTRL_ENABLE                                (0x01u)
#define `$INSTANCE_NAME`_CTRL_COMPARE_TYPE0_GREATER_THAN_OR_EQUAL   (0x02u)
#define `$INSTANCE_NAME`_CTRL_COMPARE_TYPE1_GREATER_THAN_OR_EQUAL   (0x04u)

#if (`$INSTANCE_NAME`_RESOLUTION  <= 8u) /* 8bit - PrISM */
    #define `$INSTANCE_NAME`_FIFO0_CLR                              (0x01u)
#elif (`$INSTANCE_NAME`_RESOLUTION <= 16u) /* 16bit - PrISM */
    #define `$INSTANCE_NAME`_FIFO0_CLR                              (0x0101u)
#elif (`$INSTANCE_NAME`_RESOLUTION <= 24u) /* 24bit - PrISM */
    #define `$INSTANCE_NAME`_FIFO0_CLR                              (0x010101Lu)
#else /* 32bit - PrISM */
    #define `$INSTANCE_NAME`_FIFO0_CLR                              (0x01010101Lu)
#endif /* End `$INSTANCE_NAME`_RESOLUTION */


/***************************************
* Renamed global variables or defines 
* for backward compatible
***************************************/
#define `$INSTANCE_NAME`_ReadPusle0     `$INSTANCE_NAME`_ReadPulse0
#define `$INSTANCE_NAME`_ReadPusle1     `$INSTANCE_NAME`_ReadPulse1


#endif  /* End CY_PrISM_`$INSTANCE_NAME`_H */


/* [] END OF FILE */
