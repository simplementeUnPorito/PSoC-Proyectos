/*******************************************************************************
* File Name: `$INSTANCE_NAME`.h
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This header file contains pins specific definitions associated with the
*  Static Segment LCD component .
*
* Note:
*
********************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_ST_SEG_LCD_`$INSTANCE_NAME`_PINS_H)
#define CY_ST_SEG_LCD_`$INSTANCE_NAME`_PINS_H

#include <cypins.h>
#include <cyfitter.h>


/***************************************
*        Function Prototypes
***************************************/

void `$INSTANCE_NAME`_SegPort_SetDriveMode(uint8 mode) `=ReentrantKeil($INSTANCE_NAME . "_SegPort_SetDriveMode")`;
void `$INSTANCE_NAME`_ComPort_SetDriveMode(uint8 mode) `=ReentrantKeil($INSTANCE_NAME . "_ComPort_SetDriveMode")`;


/***************************************
*              Constants
***************************************/
#define `$INSTANCE_NAME`_DM_ALG_HIZ         PIN_DM_ALG_HIZ
#define `$INSTANCE_NAME`_DM_DIG_HIZ         PIN_DM_DIG_HIZ
#define `$INSTANCE_NAME`_DM_RES_UP          PIN_DM_RES_UP
#define `$INSTANCE_NAME`_DM_RES_DWN         PIN_DM_RES_DWN
#define `$INSTANCE_NAME`_DM_OD_LO           PIN_DM_OD_LO
#define `$INSTANCE_NAME`_DM_OD_HI           PIN_DM_OD_HI
#define `$INSTANCE_NAME`_DM_STRONG          PIN_DM_STRONG
#define `$INSTANCE_NAME`_DM_RES_UPDWN       PIN_DM_RES_UPDWN

`$pinConstDef`

#endif /* CY_ST_SEG_LCD_`$INSTANCE_NAME`_PINS_H */
