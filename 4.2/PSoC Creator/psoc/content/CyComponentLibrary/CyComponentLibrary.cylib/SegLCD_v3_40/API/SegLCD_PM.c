/*******************************************************************************
* File Name: `$INSTANCE_NAME`_PM.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the API source code for Power Management of the Segment
*  LCD component.
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
`$CY_API_CALLBACK_HEADER_INCLUDE`


static `$INSTANCE_NAME`_BACKUP_STRUCT `$INSTANCE_NAME`_backup;


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SaveConfig
********************************************************************************
*
* Summary:
*  Stores user data. This function is called by the `$INSTANCE_NAME`_Sleep()
*  function prior entering to a Sleep mode.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
*******************************************************************************/
void `$INSTANCE_NAME`_SaveConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_SaveConfig")`
{
    /* Nothing to save for current version of the component */

    /* Optional user code */
    /*`#START` SAVE_CONFIG_USER_CODE */

    /*`#END`*/

    #ifdef `$INSTANCE_NAME`_SAVE_CONFIG_CALLBACK
        `$INSTANCE_NAME`_SaveConfig_Callback();
    #endif /* `$INSTANCE_NAME`_SAVE_CONFIG_CALLBACK */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_RestoreConfig
********************************************************************************
*
* Summary:
*  Restores user data. This function is called by the `$INSTANCE_NAME`_Wakeup()
*  function after resuming from a Sleep mode.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
*******************************************************************************/
void `$INSTANCE_NAME`_RestoreConfig(void) `=ReentrantKeil($INSTANCE_NAME . "_RestoreConfig")`
{
    /* Nothing to restore for current version of the component */

    /* Optional user code */
    /*`#START RESTORE_CONFIG_USER_CODE` */

    /*`#END`*/

    #ifdef `$INSTANCE_NAME`_RESTORE_CONFIG_CALLBACK
        `$INSTANCE_NAME`_RestoreConfig_Callback();
    #endif /* `$INSTANCE_NAME`_RESTORE_CONFIG_CALLBACK */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Sleep
********************************************************************************
*
* Summary:
*  Prepare the component to enter into a Sleep mode.
*
* Parameters:
*  None.
*
* Return:
*  None.
*
* Global variables:
*  `$INSTANCE_NAME`_backup - stores the state of the component.
*
* Reentrant:
*  No.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Sleep(void) `=ReentrantKeil($INSTANCE_NAME . "_Sleep")`
{
    if((`$INSTANCE_NAME`_CONTROL_REG & `$INSTANCE_NAME`_CNTL_CLK_EN) == `$INSTANCE_NAME`_CNTL_CLK_EN)
    {
        `$INSTANCE_NAME`_backup.enableState = `$INSTANCE_NAME`_LCD_STATE_ENABLED;
    }
    else
    {
        `$INSTANCE_NAME`_backup.enableState = `$INSTANCE_NAME`_LCD_STATE_DISABLED;
    }

    `$INSTANCE_NAME`_Stop();
    `$INSTANCE_NAME`_SaveConfig();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Wakeup
********************************************************************************
*
* Summary:
*  Wakes up components from a Sleep mode.
*
* Parameters:
*  None.
*
* Return:
*  Status one of standard status for PSoC3 Component:
*      CYRET_SUCCESS - Function completed successfully.
*      CYRET_LOCKED - The object was locked, already in use. Some of TDs or a
*                     channel already in use or the component was turned off by
*                     the user before entering to a sleep.
*
* Global variables:
*  `$INSTANCE_NAME`_backup - this API fetch the component state from the
*  structure to analyze and decide if the component should be enabled or not
*  after waking from a Sleep mode.
*
* Reentrant:
*  No.
*
*******************************************************************************/
uint8 `$INSTANCE_NAME`_Wakeup(void) `=ReentrantKeil($INSTANCE_NAME . "_Wakeup")`
{
    uint8 status;

    `$INSTANCE_NAME`_RestoreConfig();

    if(`$INSTANCE_NAME`_backup.enableState == `$INSTANCE_NAME`_LCD_STATE_ENABLED)
    {
        status = `$INSTANCE_NAME`_Enable();
    }
    else
    {
        status = CYRET_LOCKED;
    }

    return(status);
}


/* [] END OF FILE */
