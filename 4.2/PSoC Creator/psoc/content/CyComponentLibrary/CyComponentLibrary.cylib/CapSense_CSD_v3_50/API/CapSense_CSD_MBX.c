/*******************************************************************************
* File Name: `$INSTANCE_NAME`_MBX.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code of Tuner communication APIs for the 
*  CapSense CSD component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "`$INSTANCE_NAME`_MBX.h"

#if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING)
    
`$INSTANCE_NAME`_NO_STRICT_VOLATILE static void `$INSTANCE_NAME`_InitParams(volatile const `$INSTANCE_NAME`_INBOX *inbox)
                                        `=ReentrantKeil($INSTANCE_NAME . "_InitParams")`;
    
                                        
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_InitParams
    ********************************************************************************
    *
    * Summary:
    *  Configures component parameters to match the parameters in the inbox.
    *  Used only in manual tuning mode to apply new scanning parameters from Tuner 
    *  GUI.
    *
    * Parameters:
    *  inbox:  Pointer to Inbox structure in RAM.
    *
    * Return:
    *  None. Contents of the structure are not modified.
    * 
    * Side Effects: 
    *  Resets baseline values.
    *
    * Global Variables:
    *  `$INSTANCE_NAME`_idacSettings[] - used to store idac value for all sensors.
    *  `$INSTANCE_NAME`_fingerThreshold[] - used to store finger threshold for all 
    *  widgets.
    *  `$INSTANCE_NAME`_noiseThreshold[] - used to sotre noise threshold for all 
    *  widgets.
    *  `$INSTANCE_NAME`_hysteresis[] - used to store finger threshold for all 
    *  widgets.
    *  `$INSTANCE_NAME`_debounce[] - used to store finger threshold for all 
    *  widgets.
    *  `$INSTANCE_NAME`_INBOX inbox - structure which is used as input buffer
    *  for parameters from Tuner GUI. Only used in manual tuning mode.
    *
    * Reentrant:
    *  No
    *
    *******************************************************************************/
    static void `$INSTANCE_NAME`_InitParams(volatile const `$INSTANCE_NAME`_INBOX *inbox)
	                                        `=ReentrantKeil($INSTANCE_NAME . "_InitParams")`
    {
        /* Define widget sensor belongs to */
        uint8 sensor = inbox->sensorIndex;
        uint8 widget = `$INSTANCE_NAME`_widgetNumber[sensor];
        `$SizeReplacementString` tmpValue;
        
        /* Scanning parameters */
        #if (`$INSTANCE_NAME`_CURRENT_SOURCE)
            `$INSTANCE_NAME`_idacSettings[sensor] = inbox->idacSettings;
        #endif /* `$INSTANCE_NAME`_CURRENT_SOURCE */   
        `$INSTANCE_NAME`_widgetResolution[widget] = inbox->resolution;
    
        #if (`$INSTANCE_NAME`_TOTAL_GENERICS_COUNT)
            /* Exclude generic wiget */
            if(widget < `$INSTANCE_NAME`_END_OF_WIDGETS_INDEX)
            {
        #endif  /* `$INSTANCE_NAME`_TOTAL_GENERICS_COUNT */
        
            /* High level parameters */
            tmpValue = inbox->fingerThreshold;
            `$INSTANCE_NAME`_fingerThreshold[widget] = `$INSTANCE_NAME`_SWAP_ENDIAN16(tmpValue);
            tmpValue = inbox->noiseThreshold;
            `$INSTANCE_NAME`_noiseThreshold[widget]  = `$INSTANCE_NAME`_SWAP_ENDIAN16(tmpValue);
            
            tmpValue = inbox->hysteresis;
            `$INSTANCE_NAME`_hysteresis[widget] = `$INSTANCE_NAME`_SWAP_ENDIAN16(tmpValue);
            `$INSTANCE_NAME`_debounce[widget]   = inbox->debounce;
        
        #if (`$INSTANCE_NAME`_TOTAL_GENERICS_COUNT)
            /* Exclude generic wiget */
            }
        #endif  /* `$INSTANCE_NAME`_TOTAL_GENERICS_COUNT */

        #if ( `$INSTANCE_NAME`_MULTIPLE_PRESCALER_ENABLED )
            #if (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN)
                if( sensor > `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0 && \
                    sensor < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH1 )
                {
                    sensor = sensor - `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0;
                }
            #endif /* (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN) */
            `$INSTANCE_NAME`_analogSwitchDivider[sensor] = inbox->analogSwitchDivider;
        #else
            `$INSTANCE_NAME`_analogSwitchDivider = inbox->analogSwitchDivider;
        #endif /* ( `$INSTANCE_NAME`_MULTIPLE_PRESCALER_ENABLED ) */

        /* Re-Init baselines */
        `$INSTANCE_NAME`_InitializeAllBaselines();
    }
#endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_InitMailbox
********************************************************************************
*
* Summary:
*  Initialize parameters  of mailbox structure.
*  Sets type and size of mailbox structure. 
*  Sets check sum to check by Tuner GUI and noReadMsg flag to indicate that this 
*  is the first communication packet.
*
* Parameters:
*  mbx:  Pointer to Mailbox structure in RAM.
*
* Return:
*  None. Modifies the contents of mbx and mbx->outbox.
*
* Global Variables:
*  `$INSTANCE_NAME`_MAILBOXES - structure which incorporates two fields: 
*    - numMailBoxes (number of mailboxes);
*    - `$INSTANCE_NAME`_MAILBOX csdMailbox;
*  `$INSTANCE_NAME`_MAILBOX - structure which incorporates status output and
*  input buffer fields and `$INSTANCE_NAME`_OUTBOX and `$INSTANCE_NAME`_INBOX.
*    - type (used as outbox read status of Tuner GUI);
*    - size (used as inbox apply status of component);
*    - `$INSTANCE_NAME`_OUTBOX outbox - structure which is used as ouput 
*      buffer for report data to Tuner GUI.
*    - `$INSTANCE_NAME`_INBOX inbox - structure which is used as input buffer
*      for paramters from Tuner GUI. Only used in manual tuning mode.
*
* Reentrant:
*  No
*
*******************************************************************************/
void `$INSTANCE_NAME`_InitMailbox(volatile `$INSTANCE_NAME`_MAILBOX *mbx)
                                  `=ReentrantKeil($INSTANCE_NAME . "_InitMailbox")`
{
    /* Restore TYPE_ID (clear busy flag) to indicate "action complete" */
    mbx->type = `$INSTANCE_NAME`_TYPE_ID;
    /* Restore default value - clear "have_msg" */
    mbx->size = `$INSTANCE_NAME`_SWAP_ENDIAN16(sizeof(`$INSTANCE_NAME`_MAILBOX));
    
    /* Addtional fields for async and reset handling */
    #if(`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING)
        mbx->outbox.noReadMsg = 1u;
    #endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING) */
    
    mbx->outbox.checkSum = `$INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_CHECK_SUM);
}


/*******************************************************************************
* Function Name:  `$INSTANCE_NAME`_PostMessage
********************************************************************************
*
* Summary:
*  This blocking function waits while Tuner GUI reports that content of mailbox 
*  could be modified (clears `$INSTANCE_NAME`_BUSY_FLAG). Then loads the report 
*  data to outbox and sets the busy flag.
*  In manual tuning mode the report data:
*    - raw data, baseline, signal;
*  In auto tuning mode to report added data:
*    - fingerThreshold;
*    - noiseThreshold;
*    - scanResolution;
*    - idacValue;
*    - prescaler.
*
* Parameters:
*  mbx:  Pointer to Mailbox structure in RAM.
*
* Return:
*  None. Modifies the contents of mbx->outbox.
*
* Global Variables:
*  `$INSTANCE_NAME`_MAILBOXES - structure which incorporates two fields: 
*    - numMailBoxes (number of mailboxes);
*    - `$INSTANCE_NAME`_MAILBOX csdMailbox;
*  `$INSTANCE_NAME`_MAILBOX - structure which incorporates status output and
*  input buffer fields and `$INSTANCE_NAME`_OUTBOX and `$INSTANCE_NAME`_INBOX.
*    - type (used as outbox read status of Tuner GUI);
*    - size (used as inbox apply status of component);
*    - `$INSTANCE_NAME`_OUTBOX outbox - structure which is used as ouput 
*      buffer for report data to Tuner GUI.
*    - `$INSTANCE_NAME`_INBOX inbox - structure which is used as input buffer
*      for parameters from Tuner GUI. Only used in manual tuning mode.
*  `$INSTANCE_NAME`_lowLevelTuningDone - used to notify the Tuner GUI that 
*  tuning of scanning parameters are done. The scanning parameters in mailbox
*  will not be updated after clear it.
*
* Reentrant:
*  No
*
*******************************************************************************/
void `$INSTANCE_NAME`_PostMessage(volatile `$INSTANCE_NAME`_MAILBOX *mbx)
                                  `=ReentrantKeil($INSTANCE_NAME . "_PostMessage")`
{
    uint8 i;

    /* Check busy flag */
    while (mbx->type != `$INSTANCE_NAME`_TYPE_ID)
    {
        /* Wait while busy flag is set */
    }
    
    /* Copy all data - Raw, Base, Signal, OnMask */
    for(i = 0u; i < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT; i++)
    {
        mbx->outbox.rawData[i]  = `$INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_sensorRaw[i]);
        mbx->outbox.baseLine[i] = `$INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_sensorBaseline[i]);
        #if (`$INSTANCE_NAME`_SIGNAL_SIZE == `$INSTANCE_NAME`_SIGNAL_SIZE_UINT8)
            mbx->outbox.signal[i]   = `$INSTANCE_NAME`_sensorSignal[i];
        #else
            mbx->outbox.signal[i]   = `$INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_sensorSignal[i]);
        #endif  /* (`$INSTANCE_NAME`_SIGNAL_SIZE == `$INSTANCE_NAME`_SIGNAL_SIZE_UINT8) */
    }
        
    /* AutoTuning - need to copy all High Level parameters */
    #if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_AUTO_TUNING)
        
        /* Parameters are changed in run time */
        for(i = 0u; i < `$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT; i++)
        {
            #if (`$INSTANCE_NAME`_SIGNAL_SIZE == `$INSTANCE_NAME`_SIGNAL_SIZE_UINT8)
                mbx->outbox.fingerThreshold[i] = `$INSTANCE_NAME`_fingerThreshold[i];
                mbx->outbox.noiseThreshold[i]  = `$INSTANCE_NAME`_noiseThreshold[i];
            #else
                mbx->outbox.fingerThreshold[i] = $INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_fingerThreshold[i]);
                mbx->outbox.noiseThreshold[i]  = $INSTANCE_NAME`_SWAP_ENDIAN16(`$INSTANCE_NAME`_noiseThreshold[i]); 
            #endif /* (`$INSTANCE_NAME`_SIGNAL_SIZE == `$INSTANCE_NAME`_SIGNAL_SIZE_UINT8) */
        }
        
        /* Widget resolution, take to account TP and MB */
        for(i=0u; i < `$INSTANCE_NAME`_WIDGET_RESOLUTION_PARAMETERS_COUNT; i++)
        {
            mbx->outbox.scanResolution[i]  = `$INSTANCE_NAME`_widgetResolution[i];
        }

        /* Copy tuned idac values */
        for(i=0u; i < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT; i++)
        {
            mbx->outbox.idacValue[i] = `$INSTANCE_NAME`_idacSettings[i];
        }
            
        /* Pass parameters only once */
        `$INSTANCE_NAME`_lowLevelTuningDone = 0u;
    #endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING) */

    /* Copy scan parameters */
    #if ( `$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_AUTO_TUNING )
        for(i = 0u; i < `$INSTANCE_NAME`_TOTAL_SCANSLOT_COUNT; i++)
        {
            mbx->outbox.analogSwitchDivider[i] = `$INSTANCE_NAME`_analogSwitchDivider[i];
        }
    #endif /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_AUTO_TUNING) */

    /* Set busy flag */
    mbx->type = `$INSTANCE_NAME`_BUSY_FLAG;
}


#if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING)
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_ReadMessage
    ********************************************************************************
    *
    * Summary:
    *  If `$INSTANCE_NAME`_HAVE_MSG is found in the mailbox, initialize component 
    *  with parameters found in the inbox. Signal DONE by overwriting the
    *  value in size field in mailbox.
    *  Only available when manual tuning mode.
    *
    * Parameters:
    *  mbx:  Pointer to Mailbox structure in RAM.
    *
    * Return:
    *  None. Modifies the contents of mbx.
    *
    * Side Effects: 
    *  Initializes component parameters if `$INSTANCE_NAME`_HAVE_MSG is received.
    *
    * Global Variables:
    *  `$INSTANCE_NAME`_MAILBOXES - structure which incorporates two fields: 
    *    - numMailBoxes (number of mailboxes);
    *    - `$INSTANCE_NAME`_MAILBOX csdMailbox;
    *  `$INSTANCE_NAME`_MAILBOX - structure which incorporates status output and
    *  input buffer fields and `$INSTANCE_NAME`_OUTBOX and `$INSTANCE_NAME`_INBOX.
    *    - type (used as outbox read status of Tuner GUI);
    *    - size (used as inbox apply status of component);
    *    - `$INSTANCE_NAME`_OUTBOX outbox - structure which is used as ouput 
    *      buffer for report data to Tuner GUI.
    *    - `$INSTANCE_NAME`_INBOX inbox - structure which is used as input buffer
    *      for parameters from Tuner GUI. Only used in manual tuning mode.
    *
    * Reentrant:
    *  No
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_ReadMessage(volatile `$INSTANCE_NAME`_MAILBOX *mbx)
	                                  `=ReentrantKeil($INSTANCE_NAME . "_ReadMessage")`
    {
        volatile `$INSTANCE_NAME`_INBOX *tmpInbox;
        uint16 tmpValue;
        
        tmpValue = mbx->size;
       
        /* Do we have a message waiting? */
        if (`$INSTANCE_NAME`_SWAP_ENDIAN16(tmpValue) == `$INSTANCE_NAME`_HAVE_MSG)
        {
            tmpInbox = &(mbx->inbox);
            
            `$INSTANCE_NAME`_InitParams(tmpInbox);
    
            /* Notify host/tuner that we have consumed the message */
            mbx->size = `$INSTANCE_NAME`_SWAP_ENDIAN16(sizeof(`$INSTANCE_NAME`_MAILBOX));
            
            /* Defualt settings where changed */
            mbx->outbox.noReadMsg = 0u;
        }       
    }
#endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`_MANUAL_TUNING) */


/* [] END OF FILE */
