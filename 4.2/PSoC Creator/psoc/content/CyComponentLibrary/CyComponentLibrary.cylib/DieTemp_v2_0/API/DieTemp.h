/*******************************************************************************
* File Name: `$INSTANCE_NAME`_DieTemp.h
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  Defines the API to acquire the Die Temperature.
*
********************************************************************************
* Copyright 2008-2012, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/


#if !defined(CY_DIE_TEMP_`$INSTANCE_NAME`_H)
#define CY_DIE_TEMP_`$INSTANCE_NAME`_H


#include <cytypes.h>
#include <CyLib.h>
#include <CySpc.h>

#if !defined (CY_PSOC5LP)
    #error Component `$CY_COMPONENT_NAME` requires cy_boot v3.0 or later
#endif /* (CY_ PSOC5LP) */


/***************************************
*       Function Prototypes
***************************************/

cystatus `$INSTANCE_NAME`_Start(void)                 `=ReentrantKeil($INSTANCE_NAME . "_Start")`;
cystatus `$INSTANCE_NAME`_Query(int16 * temperature)  `=ReentrantKeil($INSTANCE_NAME . "_Query")`;
cystatus `$INSTANCE_NAME`_GetTemp(int16 * temperature)`=ReentrantKeil($INSTANCE_NAME . "_GetTemp")`;
void `$INSTANCE_NAME`_Stop(void)                      `=ReentrantKeil($INSTANCE_NAME . "_Stop")`;


#endif /* CY_DIE_TEMP_`$INSTANCE_NAME`_H */


/* [] END OF FILE */



