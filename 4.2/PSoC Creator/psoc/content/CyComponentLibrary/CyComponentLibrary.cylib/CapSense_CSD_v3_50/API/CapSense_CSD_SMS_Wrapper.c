/*******************************************************************************
* File Name: `$INSTANCE_NAME`_SMS_Wrapper.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code of wrapper between CapSense CSD component 
*  and Auto Tuning library.
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
#include "`$INSTANCE_NAME`_CSHL.h"

#if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_AUTO_TUNING)

extern `$SizeReplacementString` `$INSTANCE_NAME`_noiseThreshold[`$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT];
extern `$SizeReplacementString` `$INSTANCE_NAME`_hysteresis[`$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT];
extern uint8 `$INSTANCE_NAME`_widgetResolution[`$INSTANCE_NAME`_WIDGET_RESOLUTION_PARAMETERS_COUNT];
extern const uint8 CYCODE `$INSTANCE_NAME`_numberOfSensors[`$INSTANCE_NAME`_SENSORS_TBL_SIZE];
extern const uint8 CYCODE `$INSTANCE_NAME`_rawDataIndex[`$INSTANCE_NAME`_SENSORS_TBL_SIZE];

extern `$SizeReplacementString` `$INSTANCE_NAME`_fingerThreshold[`$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT];
extern uint8 `$INSTANCE_NAME`_idacSettings[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
extern uint8 `$INSTANCE_NAME`_analogSwitchDivider[`$INSTANCE_NAME`_TOTAL_SCANSLOT_COUNT];

extern void SMS_LIB_V3_50_CalculateThresholds(uint8 SensorNumber);
extern void SMS_LIB_V3_50_AutoTune1Ch(void);
extern void SMS_LIB_V3_50_AutoTune2Ch(void);

`$SizeReplacementString`  * SMS_LIB_noiseThreshold = `$INSTANCE_NAME`_noiseThreshold;
`$SizeReplacementString` * SMS_LIB_hysteresis = `$INSTANCE_NAME`_hysteresis;

uint8 * SMS_LIB_widgetResolution = `$INSTANCE_NAME`_widgetResolution;

const uint8 CYCODE * SMS_LIB_widgetNumber = `$INSTANCE_NAME`_widgetNumber;
const uint8 CYCODE * SMS_LIB_numberOfSensors = `$INSTANCE_NAME`_numberOfSensors;
const uint8 CYCODE * SMS_LIB_rawDataIndex = `$INSTANCE_NAME`_rawDataIndex;

`$SizeReplacementString` * SMS_LIB_fingerThreshold = `$INSTANCE_NAME`_fingerThreshold;
uint8 * SMS_LIB_idacSettings = `$INSTANCE_NAME`_idacSettings;
uint8 * SMS_LIB_prescaler = `$INSTANCE_NAME`_analogSwitchDivider;

uint16 * SMS_LIB_SensorRaw = `$INSTANCE_NAME`_sensorRaw;
uint16 * SMS_LIB_SensorBaseline = `$INSTANCE_NAME`_sensorBaseline;

`$writerCAutoSensitivity`
`$writerCAutoPrescalerTbl`

uint8 SMS_LIB_Table2[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
uint8 SMS_LIB_Table3[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
uint16 SMS_LIB_Table4[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
uint16 SMS_LIB_Table5[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
uint8 SMS_LIB_Table6[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
uint8 SMS_LIB_Table7[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];

uint8 SMS_LIB_Table8[`$INSTANCE_NAME`_END_OF_WIDGETS_INDEX];
uint8 SMS_LIB_Table9[`$INSTANCE_NAME`_END_OF_WIDGETS_INDEX];

uint8 SMS_LIB_Var1 = (`$writerCAutoInitialPrescaler`);
uint16 SMS_LIB_Var2 = (`$writerCAutoKCalcValue`);

uint8 SMS_LIB_TotalSnsCnt = `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT;
uint8 SMS_LIB_TotalScanSlCnt = `$INSTANCE_NAME`_TOTAL_SCANSLOT_COUNT;
uint8 SMS_LIB_EndOfWidgInd = `$INSTANCE_NAME`_END_OF_WIDGETS_INDEX;

#if (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN)
    uint8 SMS_LIB_TotalSnsCnt_CH0 = `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0;
    uint8 SMS_LIB_TotalSnsCnt_CH1 = `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH1;
#else
    uint8 SMS_LIB_TotalSnsCnt_CH0 = 0u;
    uint8 SMS_LIB_TotalSnsCnt_CH1 = 0u;
#endif  /* (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN) */

/*******************************************************************************
* Function Name: SMS_LIB_ScanSensor
********************************************************************************
*
* Summary:
*  Wrapper to `$INSTANCE_NAME`_ScanSensor function.
*
* Parameters:
*  SensorNumber:  Sensor number.
*
* Return:
*  None
*
* Reentrant:
*  No
*
*******************************************************************************/
void SMS_LIB_ScanSensor(uint8 SensorNumber) `=ReentrantKeil("SMS_LIB_ScanSensor")`
{
    `$INSTANCE_NAME`_ScanSensor(SensorNumber);
}

/*******************************************************************************
* Function Name: SMS_LIB_IsBusy
********************************************************************************
*
* Summary:
*  Wrapper to `$INSTANCE_NAME`_IsBusy function.
*  
* Parameters:
*  None
*
* Return:
*  None
*
*******************************************************************************/
uint8 SMS_LIB_IsBusy(void) `=ReentrantKeil("SMS_LIB_IsBusy")`
{
    return `$INSTANCE_NAME`_IsBusy();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_CalculateThresholds
********************************************************************************
*
* Summary:
*  Wrapper to SMS_LIB_CalculateThresholds function.
*
* Parameters:
*  SensorNumber:  Sensor number.
*
* Return:
*  None
*
* Reentrant:
*  No
*
*******************************************************************************/
void `$INSTANCE_NAME`_CalculateThresholds(uint8 SensorNumber) `=ReentrantKeil($INSTANCE_NAME . "_CalculateThresholds")`
{
    SMS_LIB_V3_50_CalculateThresholds(SensorNumber);
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_AutoTune
********************************************************************************
*
* Summary:
*  Wrapper for SMS_LIB_AutoTune1Ch or SMS_LIB_AutoTune2Ch function.
*
* Parameters:
*  None
*
* Return:
*  None
*
* Reentrant:
*  No
*
*******************************************************************************/
void `$INSTANCE_NAME`_AutoTune(void) `=ReentrantKeil($INSTANCE_NAME . "_AutoTune")`
{
    #if (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_ONE_CHANNEL_DESIGN)
        SMS_LIB_V3_50_AutoTune1Ch();
    #elif (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN)
        SMS_LIB_V3_50_AutoTune2Ch();
    #endif /* (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_ONE_CHANNEL_DESIGN) */
}

/*******************************************************************************
* Function Name: SMS_LIB_SetPrescaler
********************************************************************************
*
* Summary:
*  Empty wrapper for version compliance.
*
* Parameters:
*  prescaler:  prascaler value.
*
* Return:
*  None
*
*******************************************************************************/
void SMS_LIB_SetPrescaler(uint8 prescaler) `=ReentrantKeil("SMS_LIB_SetPrescaler")`
{
    prescaler = prescaler;
}

void SMS_LIB_V3_50_SetAnalogSwitchesSrc_PRS(void) `=ReentrantKeil("SMS_LIB_V3_50_SetAnalogSwitchesSrc_PRS")`
{
	`$INSTANCE_NAME`_SetAnalogSwitchesSource(`$INSTANCE_NAME`_ANALOG_SWITCHES_SRC_PRS);
}

void SMS_LIB_V3_50_SetAnalogSwitchesSrc_Prescaler(void) `=ReentrantKeil("SMS_LIB_V3_50_SetAnalogSwitchesSrc_Prescaler")`
{
	`$INSTANCE_NAME`_SetAnalogSwitchesSource(`$INSTANCE_NAME`_ANALOG_SWITCHES_SRC_PRESCALER);
}

#endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_AUTO_TUNING) */


/* [] END OF FILE */
