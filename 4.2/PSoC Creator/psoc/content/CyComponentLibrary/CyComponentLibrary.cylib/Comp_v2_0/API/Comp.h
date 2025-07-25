/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file contains the function prototypes and constants used in
*  the Analog Comparator User Module.
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

#if !defined(CY_COMP_`$INSTANCE_NAME`_H) 
#define CY_COMP_`$INSTANCE_NAME`_H

#include "cytypes.h"
#include "CyLib.h"
#include "cyfitter.h" 


#define `$INSTANCE_NAME`_RECALMODE (0u)

/* Check to see if required defines such as CY_PSOC5LP are available */
/* They are defined starting with cy_boot v3.0 */
#if !defined (CY_PSOC5LP)
    #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.0 or later
#endif /* (CY_PSOC5LP) */


/***************************************
*       Type defines
***************************************/

/* Sleep Mode API Support */
typedef struct
{
    uint8 enableState;
   /* uint8 compCRReg; */
}`$INSTANCE_NAME`_backupStruct;

#if (CY_PSOC5A)
    /* Stop API changes for PSoC5A */
    typedef struct
    {
        uint8 compCRReg;
    }   `$INSTANCE_NAME`_LOWPOWER_BACKUP_STRUCT;
#endif /* CY_PSOC5A */

/* component init state */
extern uint8 `$INSTANCE_NAME`_initVar;


/**************************************
*        Function Prototypes 
**************************************/

void    `$INSTANCE_NAME`_Start(void)                  `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
void    `$INSTANCE_NAME`_Stop(void)                   `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;
void    `$INSTANCE_NAME`_SetSpeed(uint8 speed)        `=ReentrantKeil($INSTANCE_NAME . "_SetSpeed")`;
uint8   `$INSTANCE_NAME`_GetCompare(void)             `=ReentrantKeil($INSTANCE_NAME . "_GetCompare")`;
uint16  `$INSTANCE_NAME`_ZeroCal(void)                `=ReentrantKeil($INSTANCE_NAME . "_ZeroCal")`;
void    `$INSTANCE_NAME`_LoadTrim(uint16 trimVal)     `=ReentrantKeil($INSTANCE_NAME . "_LoadTrim")`;
void `$INSTANCE_NAME`_Init(void)                      `=ReentrantKeil($INSTANCE_NAME . "_Init")`; 
void `$INSTANCE_NAME`_Enable(void)                    `=ReentrantKeil($INSTANCE_NAME . "_Enable")`;
void `$INSTANCE_NAME`_SaveConfig(void)                `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`;
void `$INSTANCE_NAME`_RestoreConfig(void)             `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
void `$INSTANCE_NAME`_Sleep(void)                     `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`;
void `$INSTANCE_NAME`_Wakeup(void)                    `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
/* Below APIs are valid only for PSoC3, PSoC5LP silicons.*/
#if (CY_PSOC3 || CY_PSOC5LP) 
    void `$INSTANCE_NAME`_PwrDwnOverrideEnable(void)  `=ReentrantKeil($INSTANCE_NAME . "_PwrDwnOverrideEnable")`;
    void `$INSTANCE_NAME`_PwrDwnOverrideDisable(void) `=ReentrantKeil($INSTANCE_NAME . "_PwrDwnOverrideDisable")`;
#endif /* CY_PSOC3 || CY_PSOC5LP */


/**************************************
*           API Constants        
**************************************/

/* Power constants for SetSpeed() function */
#define `$INSTANCE_NAME`_SLOWSPEED   (0x00u)
#define `$INSTANCE_NAME`_HIGHSPEED   (0x01u)
#define `$INSTANCE_NAME`_LOWPOWER    (0x02u)


/**************************************
*           Parameter Defaults        
**************************************/

#define `$INSTANCE_NAME`_DEFAULT_SPEED       (`$Speed`u) 
#define `$INSTANCE_NAME`_DEFAULT_HYSTERESIS  (`$Hysteresis`u)
#define `$INSTANCE_NAME`_DEFAULT_POLARITY    (`$Polarity`u)
#define `$INSTANCE_NAME`_DEFAULT_BYPASS_SYNC (`$Sync`u)
#define `$INSTANCE_NAME`_DEFAULT_PWRDWN_OVRD (`$Pd_Override`u)


/**************************************
*             Registers        
**************************************/
#define `$INSTANCE_NAME`_CR_REG            (* (reg8 *) `$INSTANCE_NAME`_ctComp__CR )               /* Config register */
#define `$INSTANCE_NAME`_CR_PTR            (  (reg8 *) `$INSTANCE_NAME`_ctComp__CR )
#define `$INSTANCE_NAME`_CLK_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__CLK )  /* Comp clock control register */
#define `$INSTANCE_NAME`_CLK_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__CLK )
#define `$INSTANCE_NAME`_SW0_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW0 )            /* Routing registers */
#define `$INSTANCE_NAME`_SW0_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__SW0 )
#define `$INSTANCE_NAME`_SW2_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW2 )
#define `$INSTANCE_NAME`_SW2_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__SW2 )
#define `$INSTANCE_NAME`_SW3_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW3 )
#define `$INSTANCE_NAME`_SW3_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__SW3 )
#define `$INSTANCE_NAME`_SW4_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW4 )
#define `$INSTANCE_NAME`_SW4_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__SW4 )
#define `$INSTANCE_NAME`_SW6_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW6 )
#define `$INSTANCE_NAME`_SW6_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__SW6 )

/* Trim registers */
/* PSoC5A */
#if (CY_PSOC5A)
    #define `$INSTANCE_NAME`_TR_REG        (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR )                /* Trim registers */
    #define `$INSTANCE_NAME`_TR_PTR        (  (reg8 *) `$INSTANCE_NAME`_ctComp__TR )
#endif /* CY_PSOC5A */

/* PSoC3, PSoC5LP or later */
#if (CY_PSOC3 || CY_PSOC5LP) 
    #define `$INSTANCE_NAME`_TR0_REG       (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR0 )/* Trim register for P-type load */
    #define `$INSTANCE_NAME`_TR0_PTR       (  (reg8 *) `$INSTANCE_NAME`_ctComp__TR0 ) 
    #define `$INSTANCE_NAME`_TR1_REG       (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR1 )/* Trim register for N-type load */
    #define `$INSTANCE_NAME`_TR1_PTR       (  (reg8 *) `$INSTANCE_NAME`_ctComp__TR1 ) 
#endif /* CY_PSOC3 || CY_PSOC5LP */

#define `$INSTANCE_NAME`_WRK_REG           (* (reg8 *) `$INSTANCE_NAME`_ctComp__WRK )    /* Working register - output */
#define `$INSTANCE_NAME`_WRK_PTR           (  (reg8 *) `$INSTANCE_NAME`_ctComp__WRK )
#define `$INSTANCE_NAME`_PWRMGR_REG        (* (reg8 *) `$INSTANCE_NAME`_ctComp__PM_ACT_CFG )  /* Active Power manager */
#define `$INSTANCE_NAME`_PWRMGR_PTR        (  (reg8 *) `$INSTANCE_NAME`_ctComp__PM_ACT_CFG )
#define `$INSTANCE_NAME`_STBY_PWRMGR_REG   (* (reg8 *) `$INSTANCE_NAME`_ctComp__PM_STBY_CFG )/* Standby Power manager */
#define `$INSTANCE_NAME`_STBY_PWRMGR_PTR   (  (reg8 *) `$INSTANCE_NAME`_ctComp__PM_STBY_CFG )

/*      Trim Locations      */
#define `$INSTANCE_NAME`_ctComp__TRIM__TR0_HS_PTR     ((void CYFAR *) `$INSTANCE_NAME`_ctComp__TRIM__TR0_HS)
#define `$INSTANCE_NAME`_ctComp__TRIM__TR0_HS_REG     CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR0_HS_PTR)
#if (CY_PSOC3 || CY_PSOC5LP)
    #define `$INSTANCE_NAME`_ctComp__TRIM__TR1_HS_PTR ((void CYFAR *) `$INSTANCE_NAME`_ctComp__TRIM__TR1_HS)
    #define `$INSTANCE_NAME`_ctComp__TRIM__TR1_HS_REG CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR1_HS_PTR)
#endif /* (CY_PSOC3 || CY_PSOC5LP) */
#define `$INSTANCE_NAME`_ctComp__TRIM__TR0_LS_PTR     ((void CYFAR *) ((uint32)`$INSTANCE_NAME`_ctComp__TRIM__TR0 + 1u))
#define `$INSTANCE_NAME`_ctComp__TRIM__TR0_LS_REG     CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR0_LS_PTR)
#if (CY_PSOC3 || CY_PSOC5LP)
    #define `$INSTANCE_NAME`_ctComp__TRIM__TR1_LS_PTR ((void CYFAR *) ((uint32)`$INSTANCE_NAME`_ctComp__TRIM__TR1 + 1u))
    #define `$INSTANCE_NAME`_ctComp__TRIM__TR1_LS_REG CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR1_LS_PTR)
#endif /* CY_PSOC3 || CY_PSOC5LP */


/***************************************
*  Registers definitions
* for backward capability        
***************************************/
#define `$INSTANCE_NAME`_CR                (* (reg8 *) `$INSTANCE_NAME`_ctComp__CR )               /* Config register */
#define `$INSTANCE_NAME`_CLK               (* (reg8 *) `$INSTANCE_NAME`_ctComp__CLK )  /* Comp clock control register */
#define `$INSTANCE_NAME`_SW0               (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW0 )            /* Routing registers */
#define `$INSTANCE_NAME`_SW2               (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW2 )
#define `$INSTANCE_NAME`_SW3               (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW3 )
#define `$INSTANCE_NAME`_SW4               (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW4 )
#define `$INSTANCE_NAME`_SW6               (* (reg8 *) `$INSTANCE_NAME`_ctComp__SW6 )

/* Trim registers */
/* PSoC5A */
#if (CY_PSOC5A)
    #define `$INSTANCE_NAME`_TR            (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR )                /* Trim registers */
#endif /* CY_PSOC5A */

/* PSoC3, PSoC5LP or later */
#if (CY_PSOC3 || CY_PSOC5LP) 
    #define `$INSTANCE_NAME`_TR0           (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR0 )/* Trim register for P-type load */
    #define `$INSTANCE_NAME`_TR1           (* (reg8 *) `$INSTANCE_NAME`_ctComp__TR1 )/* Trim register for N-type load */
#endif /* CY_PSOC3 || CY_PSOC5LP */

#define `$INSTANCE_NAME`_WRK               (* (reg8 *) `$INSTANCE_NAME`_ctComp__WRK )    /* Working register - output */
#define `$INSTANCE_NAME`_PWRMGR            (* (reg8 *) `$INSTANCE_NAME`_ctComp__PM_ACT_CFG )  /* Active Power manager */
#define `$INSTANCE_NAME`_STBY_PWRMGR       (* (reg8 *) `$INSTANCE_NAME`_ctComp__PM_STBY_CFG )/* Standby Power manager */

/*      Trim Locations      */
#define `$INSTANCE_NAME`_HS_TRIM_TR0        CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR0_HS_PTR)
#if (CY_PSOC3 || CY_PSOC5LP)
    #define `$INSTANCE_NAME`_HS_TRIM_TR1    CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR1_HS_PTR)
#endif /* (CY_PSOC3 || CY_PSOC5LP) */
#define `$INSTANCE_NAME`_LS_TRIM_TR0        CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR0_LS_PTR)
#if (CY_PSOC3 || CY_PSOC5LP)
    #define `$INSTANCE_NAME`_LS_TRIM_TR1    CY_GET_XTND_REG8(`$INSTANCE_NAME`_ctComp__TRIM__TR1_LS_PTR)
#endif /* CY_PSOC3 || CY_PSOC5LP */


/**************************************
*       Register Constants        
**************************************/

/* CR (Comp Control Register)             */
#define `$INSTANCE_NAME`_CFG_MODE_MASK      (0x78u)
#define `$INSTANCE_NAME`_FILTER_ON          (0x40u)
#define `$INSTANCE_NAME`_HYST_OFF           (0x20u)
#define `$INSTANCE_NAME`_CAL_ON             (0x10u)
#define `$INSTANCE_NAME`_MX_AO              (0x08u)
#define `$INSTANCE_NAME`_PWRDWN_OVRD        (0x04u)

#define `$INSTANCE_NAME`_PWR_MODE_SHIFT     (0x00u)
#define `$INSTANCE_NAME`_PWR_MODE_MASK      ((uint8)(0x03u << `$INSTANCE_NAME`_PWR_MODE_SHIFT))
#define `$INSTANCE_NAME`_PWR_MODE_SLOW      ((uint8)(0x00u << `$INSTANCE_NAME`_PWR_MODE_SHIFT))
#define `$INSTANCE_NAME`_PWR_MODE_FAST      ((uint8)(0x01u << `$INSTANCE_NAME`_PWR_MODE_SHIFT))
#define `$INSTANCE_NAME`_PWR_MODE_ULOW      ((uint8)(0x02u << `$INSTANCE_NAME`_PWR_MODE_SHIFT))

/* CLK (Comp Clock Control Register)      */
#define `$INSTANCE_NAME`_BYPASS_SYNC        (0x10u)
#define `$INSTANCE_NAME`_SYNC_CLK_EN        (0x08u)
#define `$INSTANCE_NAME`_SYNCCLK_MASK       (`$INSTANCE_NAME`_BYPASS_SYNC | `$INSTANCE_NAME`_SYNC_CLK_EN)

/* SW3 Routing Register definitions */
#define `$INSTANCE_NAME`_CMP_SW3_INPCTL_MASK (0x09u)   /* SW3 bits for inP routing control */

/* TR (Comp Trim Register)     */
#define `$INSTANCE_NAME`_DEFAULT_CMP_TRIM    (0x00u)

/* PSoC5A */
#if (CY_PSOC5A)
    #define `$INSTANCE_NAME`_CMP_TRIM1_DIR   (0x08u)   /* Trim direction for N-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TRIM1_MASK  (0x07u)   /* Trim for N-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TRIM2_DIR   (0x80u)   /* Trim direction for P-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TRIM2_MASK  (0x70u)   /* Trim for P-type load for offset calibration */
#endif /* CY_PSOC5A */

/* PSoC3, PSoC5LP or later */
#if (CY_PSOC3 || CY_PSOC5LP)
    #define `$INSTANCE_NAME`_CMP_TR0_DIR     (0x10u)   /* Trim direction for N-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TR0_MASK    (0x0Fu)   /* Trim for N-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TR1_DIR     (0x10u)   /* Trim direction for P-type load for offset calibration */
    #define `$INSTANCE_NAME`_CMP_TR1_MASK    (0x07u)   /* Trim for P-type load for offset calibration */ 
#endif /* CY_PSOC3 || CY_PSOC5LP */


/* WRK (Comp output working register)     */ 
#define `$INSTANCE_NAME`_CMP_OUT_MASK       `$INSTANCE_NAME`_ctComp__WRK_MASK /* Specific comparator out mask */

/* PM_ACT_CFG7 (Active Power Mode CFG Register)     */ 
#define `$INSTANCE_NAME`_ACT_PWR_EN         `$INSTANCE_NAME`_ctComp__PM_ACT_MSK /* Power enable mask */

/* PM_STBY_CFG7 (Standby Power Mode CFG Register)     */ 
#define `$INSTANCE_NAME`_STBY_PWR_EN        `$INSTANCE_NAME`_ctComp__PM_STBY_MSK /* Standby Power enable mask */

#if (CY_PSOC5A)
    /* For stop API changes mask to make the COMP register CR to 0X00  */
    #define `$INSTANCE_NAME`_COMP_REG_CLR   (0x00u)
#endif /* CY_PSOC5A */

#endif /* CY_COMP_`$INSTANCE_NAME`_H */


/* [] END OF FILE */
