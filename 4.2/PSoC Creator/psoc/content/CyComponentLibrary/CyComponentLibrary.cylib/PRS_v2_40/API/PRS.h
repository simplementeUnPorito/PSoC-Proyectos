/*******************************************************************************
* File Name: `$INSTANCE_NAME`.h
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides constants and parameter values for the PRS component.
*
* Note:
*  None
*
********************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_PRS_`$INSTANCE_NAME`_H)
#define CY_PRS_`$INSTANCE_NAME`_H

#include "cyfitter.h"
#include "cytypes.h"
#include "CyLib.h"


/***************************************
*   Conditional Compilation Parameters
****************************************/

#define `$INSTANCE_NAME`_PRS_SIZE                   (`$Resolution`u)
#define `$INSTANCE_NAME`_RUN_MODE                   (`$RunMode`u)
#define `$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE   (`$TimeMultiplexing`u)
#define `$INSTANCE_NAME`_WAKEUP_BEHAVIOUR           (`$WakeupBehaviour`u)

`#declare_enum Mode`

`#declare_enum WakeupBehaviourType`


/***************************************
*       Type defines
***************************************/

/* Structure to save registers before go to sleep */
typedef struct
{
    uint8 enableState;
    
    #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
        /* Save dff register for time mult */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
            uint8 dffStatus;
        #endif  /* End `$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE */
    
        /* Save A0 and A1 registers are none-retention */
        #if(`$INSTANCE_NAME`_PRS_SIZE <= 32u)
            `$RegSizeReplacementString` seed;
            
        #else
            uint32 seedUpper;
            uint32 seedLower;
            
        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */ 
        
    #endif  /* End (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    
} `$INSTANCE_NAME`_BACKUP_STRUCT;

extern uint8 `$INSTANCE_NAME`_initVar;

extern `$INSTANCE_NAME`_BACKUP_STRUCT `$INSTANCE_NAME`_backup;

#if ((`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) && (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK))
    extern uint8 `$INSTANCE_NAME`_sleepState;
#endif  /* End ((`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) && 
          (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)) */

                                     
/***************************************
*        Function Prototypes
****************************************/

void `$INSTANCE_NAME`_Init(void) `=ReentrantKeil($INSTANCE_NAME . "_Init")`;
void `$INSTANCE_NAME`_Enable(void) `=ReentrantKeil($INSTANCE_NAME . "_Enable")`;
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
void `$INSTANCE_NAME`_Stop(void) `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;
void `$INSTANCE_NAME`_SaveConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`;
void `$INSTANCE_NAME`_Sleep(void) `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`;


#if ((`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) && (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE))
    void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
    void `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
#else
    void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`;
    void `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`;
#endif  /* End ((`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) && 
                (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)) */

#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__APISINGLESTEP)
    void `$INSTANCE_NAME`_Step(void) `=ReentrantKeil($INSTANCE_NAME . "_Step")`;
#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__APISINGLESTEP) */

#if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)    /* 8-32 bits PRS */
    `$RegSizeReplacementString` `$INSTANCE_NAME`_Read(void) `=ReentrantKeil($INSTANCE_NAME . "_Read")`;
    void `$INSTANCE_NAME`_WriteSeed(`$RegSizeReplacementString` seed)  `=ReentrantKeil($INSTANCE_NAME . "_WriteSeed")`;
    `$RegSizeReplacementString` `$INSTANCE_NAME`_ReadPolynomial(void) 
                                `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomial")`;
    void `$INSTANCE_NAME`_WritePolynomial(`$RegSizeReplacementString` polynomial) 
                                          `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomial")`;
    
#else                                    /* 33-64 bits PRS */
    uint32 `$INSTANCE_NAME`_ReadUpper(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadUpper")`;
    uint32 `$INSTANCE_NAME`_ReadLower(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadLower")`;
    void `$INSTANCE_NAME`_WriteSeedUpper(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeedUpper")`;
    void `$INSTANCE_NAME`_WriteSeedLower(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeedLower")`;
    uint32 `$INSTANCE_NAME`_ReadPolynomialUpper(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomialUpper")`;
    uint32 `$INSTANCE_NAME`_ReadPolynomialLower(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomialLower")`;
    void `$INSTANCE_NAME`_WritePolynomialUpper(uint32 polynomial) 
                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomialUpper")`;
    void `$INSTANCE_NAME`_WritePolynomialLower(uint32 polynomial) 
                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomialLower")`;
    
#endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
    #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u) /* 8-32 bits PRS */
        void `$INSTANCE_NAME`_ResetSeedInit(`$RegSizeReplacementString` seed)  
                                            `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInit")`;
    #else
        void `$INSTANCE_NAME`_ResetSeedInitUpper(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInitUpper")`;
        void `$INSTANCE_NAME`_ResetSeedInitLower(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInitLower")`;
    #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */


/***************************************
*    Initial Parameter Constants
***************************************/

#if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
    #define `$INSTANCE_NAME`_DEFAULT_POLYNOM            (`$PolyValueLower`u)
    #define `$INSTANCE_NAME`_DEFAULT_SEED               (`$SeedValueLower`u)
    
#else
    #define `$INSTANCE_NAME`_DEFAULT_POLYNOM_UPPER      (`$PolyValueUpper`u)
    #define `$INSTANCE_NAME`_DEFAULT_POLYNOM_LOWER      (`$PolyValueLower`u)
    #define `$INSTANCE_NAME`_DEFAULT_SEED_UPPER         (`$SeedValueUpper`u)
    #define `$INSTANCE_NAME`_DEFAULT_SEED_LOWER         (`$SeedValueLower`u)
    
#endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */


/***************************************
*           API Constants
***************************************/

#define `$INSTANCE_NAME`_MASK                           (`$Mask`u)


/***************************************
*             Registers
***************************************/


#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
    #define `$INSTANCE_NAME`_EXECUTE_DFF_RESET  \
        (`$INSTANCE_NAME`_CONTROL_REG |= (`$INSTANCE_NAME`_INIT_STATE | `$INSTANCE_NAME`_CTRL_RESET_COMMON))
    
    #define `$INSTANCE_NAME`_EXECUTE_DFF_SET    \
        (`$INSTANCE_NAME`_CONTROL_REG |= `$INSTANCE_NAME`_CTRL_RESET_COMMON)

#else
    #define `$INSTANCE_NAME`_EXECUTE_DFF_RESET  \
        do { \
            `$INSTANCE_NAME`_CONTROL_REG |= (`$INSTANCE_NAME`_INIT_STATE | `$INSTANCE_NAME`_CTRL_RESET_COMMON | \
            `$INSTANCE_NAME`_CTRL_RISING_EDGE );  \
            `$INSTANCE_NAME`_CONTROL_REG &= ((uint8)~(`$INSTANCE_NAME`_CTRL_RESET_COMMON | \
            `$INSTANCE_NAME`_CTRL_RISING_EDGE));    \
        } while (0)
    
    #define `$INSTANCE_NAME`_EXECUTE_DFF_SET    \
        do { \
            `$INSTANCE_NAME`_CONTROL_REG |= (`$INSTANCE_NAME`_CTRL_RESET_COMMON | \
            `$INSTANCE_NAME`_CTRL_RISING_EDGE);\
            `$INSTANCE_NAME`_CONTROL_REG &= ((uint8)~(`$INSTANCE_NAME`_CTRL_RESET_COMMON | \
            `$INSTANCE_NAME`_CTRL_RISING_EDGE));    \
        } while (0)

    #define `$INSTANCE_NAME`_EXECUTE_STEP       \
        do { \
            `$INSTANCE_NAME`_CONTROL_REG |= `$INSTANCE_NAME`_CTRL_RISING_EDGE; \
            `$INSTANCE_NAME`_CONTROL_REG &= ((uint8)~`$INSTANCE_NAME`_CTRL_RISING_EDGE);    \
        } while (0)
    
#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */

#if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
    
    #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
        #define `$INSTANCE_NAME`_STATUS                     (*(reg8 *) `$INSTANCE_NAME`_Sts_StsReg__STATUS_REG )
        #define `$INSTANCE_NAME`_STATUS_PTR                 ( (reg8 *) `$INSTANCE_NAME`_Sts_StsReg__STATUS_REG )
    #endif  /* End (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    
    #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)      /* 16 bits PRS */
        /* Polynomial */
        #define `$INSTANCE_NAME`_POLYNOM_A__D1_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed */
        #define `$INSTANCE_NAME`_SEED_A__A1_REG             (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_A__A1_PTR         	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_REG             (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_PTR         	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* Seed COPY */
        #define `$INSTANCE_NAME`_SEED_COPY_A__A1_REG        (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A1_PTR    	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_REG        (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_PTR    	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)      /* 24 bits PRS */
        /* Polynomial */
        #define `$INSTANCE_NAME`_POLYNOM_B__D1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_PTR     	 	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed */
        #define `$INSTANCE_NAME`_SEED_B__A1_REG             (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_B__A1_PTR         	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_B__A0_REG             (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_B__A0_PTR     	    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_REG             (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_PTR 	        ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* Seed COPY */
        #define `$INSTANCE_NAME`_SEED_COPY_B__A1_REG        (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A1_PTR 	    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A0_REG        (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A0_PTR	    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_REG        (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_PTR    	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #elif (`$INSTANCE_NAME`_PRS_SIZE <= 32u)      /* 32 bits PRS */
        /* Polynomial */
        #define `$INSTANCE_NAME`_POLYNOM_B__D1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D1_PTR    		( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D1_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D1_PTR     		( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_B__D0_PTR		    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_A__D0_PTR  	    ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed */
        #define `$INSTANCE_NAME`_SEED_B__A1_REG             (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_B__A1_PTR    		    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_A__A1_REG         	(*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_A__A1_PTR      	    ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_B__A0_REG             (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_B__A0_PTR     	    ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_REG             (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_A__A0_PTR     	    ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* Seed COPY */
        #define `$INSTANCE_NAME`_SEED_COPY_B__A1_REG        (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A1_PTR  		( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A1_REG        (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A1_PTR   	 	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A0_REG        (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_B__A0_PTR  	  	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_REG        (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_COPY_A__A0_PTR   	 	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #elif (`$INSTANCE_NAME`_PRS_SIZE <= 40u)      /* 40 bits PRS */
        /* Polynomial Upper */
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        /* Polynomial Lower */
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        /* Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* Seed COPY Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        /* Seed COPY Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)      /* 48 bits PRS */
        /* Polynomial Upper */
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        /* Polynomial Lower */
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        /* Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* Seed COPY Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        /* Seed COPY Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)      /* 56 bits PRS */
        /* Polynom Upper */
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        /* Polynom Lower */
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_D__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        /* Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_D__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_D__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* COPY Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        /* COPY Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_D__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_D__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        
    #else                                        /* 64 bits PRS */
        /* Polynom Upper */
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_A__D1_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        #define `$INSTANCE_NAME`_POLYNOM_UPPER_A__D1_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D1_REG )
        /* Polynom Lower */
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG            (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        #define `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_PTR        	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__D0_REG )
        /* Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_D__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_C__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_B__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_A__A1_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_A__A1_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A1_REG )
        /* Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_D__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_D__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_C__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_B__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG               (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_A__A0_PTR           	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__A0_REG )
        /* COPY Seed Upper */
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_A__A1_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        #define `$INSTANCE_NAME`_SEED_UPPER_COPY_A__A1_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F1_REG )
        /* COPY Seed Lower */
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_D__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_D__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_PTR    		( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG          (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
        #define `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_PTR      	( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__F0_REG )
    #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */

#else
    #if (CY_PSOC3 || CY_PSOC5)
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)         /* 8-32 bits PRS */
            /* Polynomial */
            #define `$INSTANCE_NAME`_POLYNOM_PTR      ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__D0_REG )
            /* Seed */
            #define `$INSTANCE_NAME`_SEED_PTR         ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__A0_REG )
            /* Seed COPY */
            #define `$INSTANCE_NAME`_SEED_COPY_PTR    ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__F0_REG )
            
        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
    #else /* PSoC4 */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 8u)         /* 8 bits PRS */
            /* Polynomial */
            #define `$INSTANCE_NAME`_POLYNOM_PTR      ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__D0_REG )
            /* Seed */
            #define `$INSTANCE_NAME`_SEED_PTR         ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__A0_REG )
            /* Seed COPY */
            #define `$INSTANCE_NAME`_SEED_COPY_PTR    ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__F0_REG )
            
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 16u)         /* 16 bits PRS */
            /* Polynomial */
            #define `$INSTANCE_NAME`_POLYNOM_PTR      ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__16BIT_D0_REG )
            /* Seed */
            #define `$INSTANCE_NAME`_SEED_PTR         ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__16BIT_A0_REG )
            /* Seed COPY */
            #define `$INSTANCE_NAME`_SEED_COPY_PTR    ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__16BIT_F0_REG )

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)         /* 24 bits PRS */
            /* Polynomial */
            #define `$INSTANCE_NAME`_POLYNOM_PTR      ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__D0_REG )
            /* Seed */
            #define `$INSTANCE_NAME`_SEED_PTR         ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__A0_REG )
            /* Seed COPY */
            #define `$INSTANCE_NAME`_SEED_COPY_PTR    ( (`$RegDefReplacementString` *)\
                                                `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__F0_REG )
         
         #else                                          /* 32 bits PRS */
            /* Polynomial */
            #define `$INSTANCE_NAME`_POLYNOM_PTR      ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__32BIT_D0_REG )
            /* Seed */
            #define `$INSTANCE_NAME`_SEED_PTR         ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__32BIT_A0_REG )
            /* Seed COPY */
            #define `$INSTANCE_NAME`_SEED_COPY_PTR    ( (`$RegDefReplacementString` *)\
                                            `$INSTANCE_NAME`_`$VerilogSectionReplacementString`_PRSdp_u0__32BIT_F0_REG )
         
        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

    #endif  /* End (CY_PSOC3 || CY_PSOC5) */
    
#endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */


#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
    /* Aux control */
    #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)    
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)      /* 8-16 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)      /* 24-39 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 40u)      /* 40-55 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_REG      (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_PTR      ( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__DP_AUX_CTL_REG )

        #else                                         /* 56-64 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_b0_PRSdp_a__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_b1_PRSdp_b__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_REG      (*(reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_PTR      ( (reg8 *) `$INSTANCE_NAME`_b2_PRSdp_c__DP_AUX_CTL_REG )
			#define `$INSTANCE_NAME`_AUX_CONTROL_D_REG      (*(reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_D_PTR      ( (reg8 *) `$INSTANCE_NAME`_b3_PRSdp_d__DP_AUX_CTL_REG )     
																							
        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */
    
    #else
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 8u)      /* 8 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_sC8_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC8_PRSdp_u0__DP_AUX_CTL_REG )
            
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 16u)      /* 16 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_sC16_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC16_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_sC16_PRSdp_u1__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC16_PRSdp_u1__DP_AUX_CTL_REG )
            
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)      /* 24-39 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u1__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u1__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_REG      (*(reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u2__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC24_PRSdp_u2__DP_AUX_CTL_REG )
                
        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 32u)      /* 40-55 bits PRS */
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_REG      (*(reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_A_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u0__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_REG      (*(reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u1__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_B_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u1__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_REG      (*(reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u2__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_C_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u2__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_D_REG      (*(reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u3__DP_AUX_CTL_REG )
            #define `$INSTANCE_NAME`_AUX_CONTROL_D_PTR      ( (reg8 *) `$INSTANCE_NAME`_sC32_PRSdp_u3__DP_AUX_CTL_REG )
    
        #else                                         /* 56-64 bits PRS */
            /* Not supported */                    
        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */
    
    #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    
#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */

#define `$INSTANCE_NAME`_CONTROL_REG               (*(reg8 *) `$INSTANCE_NAME`_ClkSp_CtrlReg__CONTROL_REG )
#define `$INSTANCE_NAME`_CONTROL_PTR               ( (reg8 *) `$INSTANCE_NAME`_ClkSp_CtrlReg__CONTROL_REG )
    

/***************************************
*       Register Constants
***************************************/

/* Control register definitions */

#define `$INSTANCE_NAME`_CTRL_ENABLE                    (0x01u)
#define `$INSTANCE_NAME`_CTRL_RISING_EDGE               (0x02u)
#define `$INSTANCE_NAME`_CTRL_RESET_COMMON              (0x04u)
#define `$INSTANCE_NAME`_CTRL_RESET_CI                  (0x08u)
#define `$INSTANCE_NAME`_CTRL_RESET_SI                  (0x10u)
#define `$INSTANCE_NAME`_CTRL_RESET_SO                  (0x20u)
#define `$INSTANCE_NAME`_CTRL_RESET_STATE0              (0x40u)
#define `$INSTANCE_NAME`_CTRL_RESET_STATE1              (0x80u)

#define `$INSTANCE_NAME`_INIT_STATE                     ( `$INSTANCE_NAME`_CTRL_RESET_CI |\
                                                          `$INSTANCE_NAME`_CTRL_RESET_SI |\
                                                          `$INSTANCE_NAME`_CTRL_RESET_SO |\
                                                          `$INSTANCE_NAME`_CTRL_RESET_STATE0 |\
                                                          `$INSTANCE_NAME`_CTRL_RESET_STATE1 )
                                                          
/* Status register definitions */
#define `$INSTANCE_NAME`_STS_RESET_CI                   (0x08u)
#define `$INSTANCE_NAME`_STS_RESET_SI                   (0x10u)
#define `$INSTANCE_NAME`_STS_RESET_SO                   (0x20u)
#define `$INSTANCE_NAME`_STS_RESET_STATE0               (0x40u)
#define `$INSTANCE_NAME`_STS_RESET_STATE1               (0x80u)

/* Aux Control register definitions */
#define `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG        (0x03u)

#define `$INSTANCE_NAME`_NORMAL_SEQUENCE                (0x01u)

#define `$INSTANCE_NAME`_IS_PRS_ENABLE(reg)             (((reg) & `$INSTANCE_NAME`_CTRL_ENABLE) != 0u)

#endif  /* End CY_PRS_`$INSTANCE_NAME`_H */


/* [] END OF FILE */
