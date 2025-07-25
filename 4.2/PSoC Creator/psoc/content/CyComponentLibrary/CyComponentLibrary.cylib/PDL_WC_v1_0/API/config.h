/*******************************************************************************
* \file `$INSTANCE_NAME`_config.h
* \version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* \brief
*  Contains the variable declarations for the `$INSTANCE_NAME` component.
*
********************************************************************************
* \copyright
* Copyright 2016, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#ifndef `$INSTANCE_NAME`_CONFIG_H
#define `$INSTANCE_NAME`_CONFIG_H

#include "wc/wc.h"
#include "cyfitter.h"
    
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* Hardware pointer */
#define `$INSTANCE_NAME`_HW     `$INSTANCE_NAME`_fm_wc__HW

/* Configuration structure */
extern `=$CY_CONST_CONFIG ? "const " : ""`stc_wc_config_t `$INSTANCE_NAME`_Config;

/* Interrupt callback function */
`=($pfnIrqCallback eq "") || !$bIrqEnable ? "/* Callback unused */" : "void " . $INSTANCE_NAME . "_" . $pfnIrqCallback . "(void);"`

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* `$INSTANCE_NAME`_CONFIG_H */

/* [] END OF FILE */
