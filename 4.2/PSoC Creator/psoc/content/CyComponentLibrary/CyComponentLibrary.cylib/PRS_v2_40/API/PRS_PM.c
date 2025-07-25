/*******************************************************************************
* File Name: `$INSTANCE_NAME`_PM.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides Sleep APIs for PRS component.
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

#include "`$INSTANCE_NAME`.h"

#if ((`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) && (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK))
    uint8 `$INSTANCE_NAME`_sleepState = `$INSTANCE_NAME`_NORMAL_SEQUENCE;    
#endif  /* End ((`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) && 
          (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SaveConfig
********************************************************************************
*
* Summary:
*  Saves seed and polynomial registers.
*
* Parameters:
*  void
*
* Return:
*  void
*
* Global Variables:
*  `$INSTANCE_NAME`_backup - modified when non-retention registers are saved.
*
*******************************************************************************/
void `$INSTANCE_NAME`_SaveConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`
{    
    #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
        /* Save dff register for time mult */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
            `$INSTANCE_NAME`_backup.dffStatus = `$INSTANCE_NAME`_STATUS;
            /* Clear normal dff sequence set */
            `$INSTANCE_NAME`_sleepState &= ((uint8)~`$INSTANCE_NAME`_NORMAL_SEQUENCE);
        #endif  /* End `$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE */
        
        /* Save A0 and A1 registers */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
            `$INSTANCE_NAME`_backup.seed = `$INSTANCE_NAME`_Read();
            
        #else
            `$INSTANCE_NAME`_backup.seedUpper = `$INSTANCE_NAME`_ReadUpper();
            `$INSTANCE_NAME`_backup.seedLower = `$INSTANCE_NAME`_ReadLower();
            
        #endif     /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
        
    #endif  /* End (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Sleep
********************************************************************************
*
* Summary:
*  Stops PRS computation and saves PRS configuration.
*
* Parameters:
*  void
*
* Return:
*  void
*
* Global Variables:
*  `$INSTANCE_NAME`_backup - modified when non-retention registers are saved.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Sleep(void) `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`
{
    /* Store PRS enable state */
    if(`$INSTANCE_NAME`_IS_PRS_ENABLE(`$INSTANCE_NAME`_CONTROL_REG))
    {
        `$INSTANCE_NAME`_backup.enableState = 1u;
        `$INSTANCE_NAME`_Stop();
    }
    else
    {
        `$INSTANCE_NAME`_backup.enableState = 0u;
    }
    
    `$INSTANCE_NAME`_SaveConfig();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_RestoreConfig
********************************************************************************
*
* Summary:
*  Restores seed and polynomial registers.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
#if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
    #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
        void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`
        {   
            /* Restore A0 and A1 registers */
            #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
                `$INSTANCE_NAME`_WriteSeed(`$INSTANCE_NAME`_backup.seed);
            #else
                `$INSTANCE_NAME`_WriteSeedUpper(`$INSTANCE_NAME`_backup.seedUpper);
                `$INSTANCE_NAME`_WriteSeedLower(`$INSTANCE_NAME`_backup.seedLower);
            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
            
            #if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
                #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
                    `$INSTANCE_NAME`_ResetSeedInit(`$INSTANCE_NAME`_DEFAULT_SEED);                        
                #else
                    `$INSTANCE_NAME`_ResetSeedInitUpper(`$INSTANCE_NAME`_DEFAULT_SEED_UPPER);
                    `$INSTANCE_NAME`_ResetSeedInitLower(`$INSTANCE_NAME`_DEFAULT_SEED_LOWER); 
                #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */ 
            #endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */
            
            /* Restore dff state for time mult: use async set/reest */
            /* Set CI, SI, SO, STATE0, STATE1 */
            `$INSTANCE_NAME`_CONTROL_REG = `$INSTANCE_NAME`_backup.dffStatus;
            
            /* Make pulse, to set trigger to defined state */
            `$INSTANCE_NAME`_EXECUTE_DFF_SET;
            
            /* Set normal dff sequence set */
            `$INSTANCE_NAME`_sleepState |= `$INSTANCE_NAME`_NORMAL_SEQUENCE;
        }
        
    #else
        void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`
        {   
            /* Restore A0 and A1 registers */
            #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
                `$INSTANCE_NAME`_WriteSeed(`$INSTANCE_NAME`_backup.seed);
            #else
                `$INSTANCE_NAME`_WriteSeedUpper(`$INSTANCE_NAME`_backup.seedUpper);
                `$INSTANCE_NAME`_WriteSeedLower(`$INSTANCE_NAME`_backup.seedLower);
            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
            
            #if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
                #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
                    `$INSTANCE_NAME`_ResetSeedInit(`$INSTANCE_NAME`_DEFAULT_SEED);                        
                #else
                    `$INSTANCE_NAME`_ResetSeedInitUpper(`$INSTANCE_NAME`_DEFAULT_SEED_UPPER);
                    `$INSTANCE_NAME`_ResetSeedInitLower(`$INSTANCE_NAME`_DEFAULT_SEED_LOWER); 
                #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */ 
            #endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */
        }
        
    #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    
#else
    void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`
    {
        `$INSTANCE_NAME`_Init();
    }
    
#endif  /* End (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Wakeup
********************************************************************************
*
* Summary:
*  Restores PRS configuration and starts PRS computation. 
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
#if ((`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) && (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE))
    void `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`
#else
    void `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`
#endif  /* End ((`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) && 
                (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)) */
{
    `$INSTANCE_NAME`_RestoreConfig();
    
    /* Restore PRS enable state */
    if (`$INSTANCE_NAME`_backup.enableState != 0u)
    {
        `$INSTANCE_NAME`_Enable();
    }
}

/* [] END OF FILE */
