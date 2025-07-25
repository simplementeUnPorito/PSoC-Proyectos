/***************************************************************************//**
* \file CYBLE_cscs.c
* \version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
* 
* \brief
*  Contains the source code for Cycling Speed and Cadence Service.
* 
********************************************************************************
* \copyright
* Copyright 2014-2018, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "`$INSTANCE_NAME`_eventHandler.h"

static CYBLE_CALLBACK_T CyBle_CscsApplCallback = NULL;

#ifdef CYBLE_CSCS_SERVER

`$CscsServer`
static CYBLE_GATT_DB_ATTR_HANDLE_T cyBle_cscssReqHandle;
    
#endif /* CYBLE_CSCS_SERVER */

#ifdef CYBLE_CSCS_CLIENT

CYBLE_CSCSC_T cyBle_cscsc;

static CYBLE_GATT_DB_ATTR_HANDLE_T cyBle_cscscReqHandle;

static const CYBLE_CSCSC_T cyBle_flashCscsc = 
{
    {
        {{0u, 0u}, {0u}, 0u},
        {{0u, 0u}, {0u}, 0u},
        {{0u, 0u}, {0u}, 0u},
        {{0u, 0u}, {0u}, 0u},
    }
};

#endif /* (CYBLE_CSCS_CLIENT) */


/****************************************************************************** 
* Function Name: CyBle_CscsInit
***************************************************************************//**
* 
*  This function initializes the Cycling Speed and Cadence Service.
* 
******************************************************************************/
void CyBle_CscsInit(void)
{
#if defined(CYBLE_CSCS_SERVER)

    cyBle_cscssReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
    
#endif /* CYBLE_CSCS_SERVER */

#ifdef CYBLE_CSCS_CLIENT

    if(cyBle_serverInfo[CYBLE_SRVI_CSCS].range.startHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        (void)memcpy(&cyBle_cscsc, &cyBle_flashCscsc, sizeof(cyBle_cscsc));
    }
    cyBle_cscscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;

#endif /* CYBLE_CSCS_CLIENT */
}


/****************************************************************************** 
* Function Name: CyBle_CscsRegisterAttrCallback
***************************************************************************//**
* 
*  Registers a callback function for Cycling Speed and Cadence Service specific
*  attribute operations.
*  Service specific write requests from peer device will not be handled with
*  unregistered callback function.
* 
*  \param callbackFunc: An application layer event callback function to receive 
*                 events from the BLE Component. The definition of 
*                 CYBLE_CALLBACK_T for CSCS is:  
*                 typedef void (* CYBLE_CALLBACK_T) (uint32 eventCode, 
*                                                   void *eventParam) 
*                 * eventCode indicates the event that triggered this 
*                   callback.
*                 * eventParam contains the parameters corresponding to the 
*                   current event.
* 
* \sideeffect The *eventParams in the callback function should not be used by
*                the application once the callback function execution is 
*                finished. Otherwise this data may become corrupted.
* 
******************************************************************************/
void CyBle_CscsRegisterAttrCallback(CYBLE_CALLBACK_T callbackFunc)
{
    CyBle_CscsApplCallback = callbackFunc;
}


#ifdef CYBLE_CSCS_SERVER
    
/******************************************************************************
* Function Name: CyBle_CscssWriteEventHandler
***************************************************************************//**
*     
*  Handles the Write Request Event for the Cycling Speed and Cadence Service.
* 
*  \param  *eventParam: The pointer to the data that came 
*                       with a write request for the
*                       Cycling Speed and Cadence Service.
* 
* \return
*  Return a value of type CYBLE_GATT_ERR_CODE_T:
*   * CYBLE_GATT_ERR_NONE - function terminated successfully.
*   * CYBLE_GATT_ERR_INVALID_HANDLE - the handle of a Client Configuration 
*                                     Characteristic Descriptor is not valid.
*   * CYBLE_GATT_ERR_UNLIKELY_ERROR - an Internal Stack error occurred.
*   * CYBLE_GATT_ERR_REQUEST_NOT_SUPPORTED - the notification or indication 
*                                            property of a specific 
*                                            Characteristic of Cycling Speed and
*                                            Cadence Service is disabled.
* 
******************************************************************************/
CYBLE_GATT_ERR_CODE_T CyBle_CscssWriteEventHandler(CYBLE_GATTS_WRITE_REQ_PARAM_T *eventParam)
{
    CYBLE_CSCS_CHAR_VALUE_T wrReqParam;
    CYBLE_GATT_DB_ATTR_HANDLE_T tmpHandle;
    CYBLE_GATT_ERR_CODE_T gattErr = CYBLE_GATT_ERR_NONE;
    uint32 event = (uint32)CYBLE_EVT_CSCSS_CHAR_WRITE;
    uint8 handleWasFound = 1u;
    
    tmpHandle = eventParam->handleValPair.attrHandle;
    
    if(NULL != CyBle_CscsApplCallback)
    {
        /* Client Characteristic Configuration Descriptor Write Request */
        if(tmpHandle == cyBle_cscss.charInfo[CYBLE_CSCS_CSC_MEASUREMENT].descrHandle[CYBLE_CSCS_CCCD])
        {   
            /* Verify that optional notification property is enabled for the Characteristic */
            if(CYBLE_IS_NOTIFICATION_SUPPORTED(cyBle_cscss.charInfo[CYBLE_CSCS_CSC_MEASUREMENT].charHandle))
            {
                if(CYBLE_IS_NOTIFICATION_ENABLED_IN_PTR(eventParam->handleValPair.value.val))
                {
                    event = (uint32)CYBLE_EVT_CSCSS_NOTIFICATION_ENABLED;
                }
                else
                {
                    event = (uint32)CYBLE_EVT_CSCSS_NOTIFICATION_DISABLED;
                }
                
                wrReqParam.charIndex = CYBLE_CSCS_CSC_MEASUREMENT;
                
                /* Value is NULL for descriptors */
                wrReqParam.value = NULL;
            
            #if((CYBLE_GAP_ROLE_PERIPHERAL || CYBLE_GAP_ROLE_CENTRAL) && \
                (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES))
                /* Set flag to store bonding data to flash */
                if(cyBle_peerBonding == CYBLE_GAP_BONDING)
                {
                    cyBle_pendingFlashWrite |= CYBLE_PENDING_CCCD_FLASH_WRITE_BIT;
                }
            #endif /* (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES) */
            }
            else
            {
                gattErr = CYBLE_GATT_ERR_REQUEST_NOT_SUPPORTED;
            }
        }
        else if(tmpHandle == cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].descrHandle[CYBLE_CSCS_CCCD])
        {
            /* Verify that optional indication property is enabled for the Characteristic */
            if(CYBLE_IS_INDICATION_SUPPORTED(cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].charHandle))
            {
                if(CYBLE_IS_INDICATION_ENABLED_IN_PTR(eventParam->handleValPair.value.val))
                {
                    event = (uint32)CYBLE_EVT_CSCSS_INDICATION_ENABLED;
                }
                else
                {
                    event = (uint32)CYBLE_EVT_CSCSS_INDICATION_DISABLED;
                }
                
                wrReqParam.charIndex = CYBLE_CSCS_SC_CONTROL_POINT;
                
                /* Value is NULL for descriptors */
                wrReqParam.value = NULL;
            
            #if((CYBLE_GAP_ROLE_PERIPHERAL || CYBLE_GAP_ROLE_CENTRAL) && \
                (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES))
                /* Set flag to store bonding data to flash */
                if(cyBle_peerBonding == CYBLE_GAP_BONDING)
                {
                    cyBle_pendingFlashWrite |= CYBLE_PENDING_CCCD_FLASH_WRITE_BIT;
                }
            #endif /* (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES) */
            }
            else
            {
                gattErr = CYBLE_GATT_ERR_REQUEST_NOT_SUPPORTED;
            }
        }
        else if(tmpHandle == cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].charHandle)
        {
            if(CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE == cyBle_cscssReqHandle)
            {
                /* Verify if indication are enabled for CSC Control Point Characteristic */
                if(CYBLE_IS_INDICATION_SUPPORTED(cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].charHandle))
                {
                    if(CYBLE_IS_INDICATION_ENABLED(
                        cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].descrHandle[CYBLE_CSCS_CCCD]))
                    {
                        event = (uint32)CYBLE_EVT_CSCSS_CHAR_WRITE;
                        wrReqParam.charIndex = CYBLE_CSCS_CSC_MEASUREMENT;
                        wrReqParam.value = &eventParam->handleValPair.value;
                    }
                    else
                    {
                        /* The peer Client didn't enable indications for the characteristic */
                        gattErr = CYBLE_GATTS_ERR_CCCD_IMPROPERLY_CONFIGURED;
                    }
                }
                else
                {
                    /* Indications are not supported */
                    gattErr = CYBLE_GATT_ERR_REQUEST_NOT_SUPPORTED;
                }
            }
            else
            {
                gattErr = CYBLE_GATTS_ERR_PROCEDURE_ALREADY_IN_PROGRESS;
            }
        }
        else
        {
            /* No valid service handles were found */
            handleWasFound = 0u;
        }
        
        if((gattErr == CYBLE_GATT_ERR_NONE) && (handleWasFound != 0u))
        {
            /* Write value to GATT database */
            gattErr = CyBle_GattsWriteAttributeValue(&eventParam->handleValPair, 0u, 
                &eventParam->connHandle, CYBLE_GATT_DB_PEER_INITIATED);
            
            if(gattErr == CYBLE_GATT_ERR_NONE)
            {
                wrReqParam.connHandle = eventParam->connHandle;
                cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
                CyBle_CscsApplCallback(event, &wrReqParam);
            }
        }
    }

    if(CYBLE_GATT_ERR_NONE != gattErr)
    {
        /* Indicate that request was handled */
        cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
    }
    
    return(gattErr);
}


/******************************************************************************
* Function Name: CyBle_CscssConfirmationEventHandler
***************************************************************************//**
* 
*  Handles the Value Confirmation request event from the BLE stack.
* 
*  \param event_params: Pointer to a structure of type 'CYBLE_CONN_HANDLE_T'.
* 
* \return
*  None.
* 
******************************************************************************/
void CyBle_CscssConfirmationEventHandler(const CYBLE_CONN_HANDLE_T *eventParam)
{
    CYBLE_CSCS_CHAR_VALUE_T locCharValue;

    if((NULL != CyBle_CscsApplCallback) && (CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscssReqHandle))
    {
        if(cyBle_cscssReqHandle == cyBle_cscss.charInfo[CYBLE_CSCS_SC_CONTROL_POINT].charHandle)
        {
            locCharValue.connHandle = *eventParam;
            locCharValue.charIndex = CYBLE_CSCS_SC_CONTROL_POINT;
            locCharValue.value = NULL;
            cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
            cyBle_cscssReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
            CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSS_INDICATION_CONFIRMATION, &locCharValue);
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscssSetCharacteristicValue
****************************************************************************//**
* 
*  Sets characteristic value of the Cycling Speed and Cadence Service, which is
*  identified by charIndex, to the local database.
* 
*  \param charIndex:  The index of a service characteristic of
*                     type CYBLE_CSCS_CHAR_INDEX_T. Valid values are, 
*                     * CYBLE_CSCS_CSC_FEATURE
*                     * CYBLE_CSCS_SENSOR_LOCATION.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue: The pointer to the characteristic value data that should 
*					  be stored to the GATT database.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request is handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular characteristic.
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscssSetCharacteristicValue(CYBLE_CSCS_CHAR_INDEX_T charIndex,
    uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;

    if(CYBLE_CSCS_CHAR_COUNT > charIndex)
    {
        if(cyBle_cscss.charInfo[charIndex].charHandle != CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
        {
            CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
            
            locHandleValuePair.attrHandle = cyBle_cscss.charInfo[charIndex].charHandle;
            locHandleValuePair.value.len = attrSize;
            locHandleValuePair.value.val = attrValue;
            
            /* Store data in database */
            if(CyBle_GattsWriteAttributeValue(&locHandleValuePair, 0u, NULL, CYBLE_GATT_DB_LOCALLY_INITIATED)
                   == CYBLE_GATT_ERR_NONE)
            {
                apiResult = CYBLE_ERROR_OK;
            }
        }
        else
        {
            apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
        }
    }

    return (apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscssGetCharacteristicValue
****************************************************************************//**
* 
*  Gets a characteristic value of the Cycling Speed and Cadence Service, which
*  is identified by charIndex, from the GATT database.
* 
*  \param charIndex:  The index of a service characteristic of
*                     type CYBLE_CSCS_CHAR_INDEX_T. Valid value is, 
*                     * CYBLE_CSCS_SC_CONTROL_POINT.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue: The pointer to the location where characteristic value data should be stored.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request is handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Optional characteristic is absent.
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscssGetCharacteristicValue(CYBLE_CSCS_CHAR_INDEX_T charIndex,
    uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    
    if(CYBLE_CSCS_CHAR_COUNT > charIndex)
    {
        if(CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscss.charInfo[charIndex].charHandle)
        {
            CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
            
            locHandleValuePair.attrHandle = cyBle_cscss.charInfo[charIndex].charHandle;
            locHandleValuePair.value.len = attrSize;
            locHandleValuePair.value.val = attrValue;

            /* Read characteristic value from database */
            if(CyBle_GattsReadAttributeValue(&locHandleValuePair, NULL, CYBLE_GATT_DB_LOCALLY_INITIATED)
                == CYBLE_GATT_ERR_NONE)
            {
                apiResult = CYBLE_ERROR_OK;
            }
        }
        else
        {
            apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
        }
    }
    
    return (apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscssGetCharacteristicDescriptor
****************************************************************************//**
* 
*  Gets a characteristic descriptor of a specified characteristic of the Cycling
*  Speed and Cadence Service, from the GATT database.
* 
*  \param charIndex:    The index of a service characteristic of type CYBLE_CSCS_CHAR_INDEX_T. 
*                       Valid values are,
*                       * CYBLE_CSCS_CSC_MEASUREMENT 
*                       * CYBLE_CSCS_SC_CONTROL_POINT.
*  \param descrIndex:   The index of a service characteristic descriptor of type 
*                       CYBLE_CSCS_DESCR_INDEX_T. Valid value is
*                       * CYBLE_CSCS_CCCD.
*  \param attrSize:     The size of the characteristic descriptor attribute.
*  \param attrValue:   The pointer to the location where characteristic descriptor value data 
*                       should be stored.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request is handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular characteristic.
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscssGetCharacteristicDescriptor(CYBLE_CSCS_CHAR_INDEX_T charIndex,
    CYBLE_CSCS_DESCR_INDEX_T descrIndex, uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;

    if((CYBLE_CSCS_CHAR_COUNT > charIndex) && (CYBLE_CSCS_DESCR_COUNT > descrIndex))
    {
        if(CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscss.charInfo[charIndex].descrHandle[descrIndex])
        {
            CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
        
            locHandleValuePair.attrHandle = cyBle_cscss.charInfo[charIndex].descrHandle[descrIndex];
            locHandleValuePair.value.len = attrSize;
            locHandleValuePair.value.val = attrValue;
            
            if(CyBle_GattsReadAttributeValue(&locHandleValuePair,0u, CYBLE_GATT_DB_LOCALLY_INITIATED)
                 == CYBLE_GATT_ERR_NONE)
            {
                apiResult = CYBLE_ERROR_OK;
            }
        }
        else
        {
            apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
        }
    }
    
    return (apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscssSendNotification
****************************************************************************//**
* 
*  Sends notification with a characteristic value, which is specified by 
*  charIndex, of the Cycling Speed and Cadence Service to the Client device.
* 
*  On enabling notification successfully for a service characteristic it sends 
*  out a 'Handle Value Notification' which results in 
*  CYBLE_EVT_CSCSC_NOTIFICATION event at the GATT Client's end.
*
*  \param connHandle: The connection handle.
*  \param charIndex:  The index of a service characteristic of type
*                     CYBLE_CSCS_CHAR_INDEX_T. Valid value is 
*                     * CYBLE_CSCS_CSC_MEASUREMENT.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue:  The pointer to the characteristic value
*                     data that should be sent to the Client device.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request is handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of input parameter is failed.
*   * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this.
*                                     characteristic.
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_NTF_DISABLED - Notification is not enabled by the client.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscssSendNotification(CYBLE_CONN_HANDLE_T connHandle,
    CYBLE_CSCS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    /* Store new data in database */
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    
    if(charIndex == CYBLE_CSCS_CSC_MEASUREMENT)  
    {
        /* Send Notification if it is enabled and connected */
        if(CYBLE_STATE_CONNECTED != CyBle_GetState())
        {
            apiResult = CYBLE_ERROR_INVALID_STATE;
        }
        else if(!CYBLE_IS_NOTIFICATION_ENABLED(cyBle_cscss.charInfo[charIndex].descrHandle[CYBLE_CSCS_CCCD]))
        {
            apiResult = CYBLE_ERROR_NTF_DISABLED;
        }
        else
        {
            CYBLE_GATTS_HANDLE_VALUE_NTF_T ntfReqParam;
            
            /* Fill all fields of write request structure ... */
            ntfReqParam.attrHandle = cyBle_cscss.charInfo[charIndex].charHandle;
            ntfReqParam.value.val = attrValue;
            ntfReqParam.value.len = attrSize;
            
            /* Send notification to the Client using previously filled structure */
            apiResult = CyBle_GattsNotification(connHandle, &ntfReqParam);
        }
    }
    return (apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscssSendIndication
****************************************************************************//**
* 
*  Sends indication with a characteristic value, which is specified by 
*  charIndex, of the Cycling Speed and Cadence Service to the Client device.
* 
*  On enabling indication successfully it sends out a 'Handle Value Indication' 
*  which results in CYBLE_EVT_CSCSC_INDICATION or 
*  CYBLE_EVT_GATTC_HANDLE_VALUE_IND (if service specific callback function is 
*  not registered) event at the GATT Client's end.
*
*  \param connHandle: The connection handle.
*  \param charIndex:  The index of a service characteristic of type 
*                     CYBLE_CSCS_CHAR_INDEX_T.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue:  The pointer to the characteristic value
*                     data that should be sent to the Client device.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request is handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of input parameter is failed.
*   * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this.
*                                      characteristic.
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_IND_DISABLED - Indication is not enabled by the client.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the CSCS service-specific callback is registered 
*      (with CyBle_CscsRegisterAttrCallback):
*  * CYBLE_EVT_CSCSS_INDICATION_CONFIRMED - in case if the indication is
*                                successfully delivered to the peer device.
*  .
*   Otherwise (if the CSCS service-specific callback is not registered):
*  * CYBLE_EVT_GATTS_HANDLE_VALUE_CNF - in case if the indication is
*                                successfully delivered to the peer device.
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscssSendIndication(CYBLE_CONN_HANDLE_T connHandle,
    CYBLE_CSCS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    /* Store new data in database */
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_OK;
    
    if(charIndex == CYBLE_CSCS_SC_CONTROL_POINT)
    {
        /* Send Indication if it is enabled and connected */
        if(CYBLE_STATE_CONNECTED != CyBle_GetState())
        {
            apiResult = CYBLE_ERROR_INVALID_STATE;
        }
        else if(!CYBLE_IS_INDICATION_ENABLED(cyBle_cscss.charInfo[charIndex].descrHandle[CYBLE_CSCS_CCCD]))
        {
            apiResult = CYBLE_ERROR_IND_DISABLED;
        }
        else
        {
            if(cyBle_cscss.charInfo[charIndex].charHandle != CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
            {
                CYBLE_GATTS_HANDLE_VALUE_IND_T indReqParam;
                
                /* Fill all fields of write request structure ... */
                indReqParam.attrHandle = cyBle_cscss.charInfo[charIndex].charHandle;
                indReqParam.value.val = attrValue;
                indReqParam.value.len = attrSize;
                
                /* Send indication to client using previously filled structure */
                apiResult = CyBle_GattsIndication(connHandle, &indReqParam);
                /* Save handle to support service specific value confirmation response from client */
                if(apiResult == CYBLE_ERROR_OK)
                {
                    cyBle_cscssReqHandle = indReqParam.attrHandle;
                }
            }
            else
            {
                apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
            }
        }
    }
    return (apiResult);
}

#endif /* CYBLE_CSCS_SERVER */


#ifdef CYBLE_CSCS_CLIENT

/*******************************************************************************
* Function Name: CyBle_CscscDiscoverCharacteristicsEventHandler
****************************************************************************//**
* 
*  This function is called on receiving a "CYBLE_EVT_GATTC_READ_BY_TYPE_RSP"
*  event. Based on the service UUID, an appropriate data structure is populated
*  using the data received as part of the callback.
* 
*  \param discCharInfo: The pointer to a characteristic information structure.
* 
*******************************************************************************/
void CyBle_CscscDiscoverCharacteristicsEventHandler(const CYBLE_DISC_CHAR_INFO_T *discCharInfo)
{
    /* CSCS characteristics UUIDs */
    static const CYBLE_UUID16 cyBle_cscscCharUuid[CYBLE_CSCS_CHAR_COUNT] =
    {
        CYBLE_UUID_CHAR_CSC_MSRMT,
        CYBLE_UUID_CHAR_CSC_FEATURE,
        CYBLE_UUID_CHAR_SENSOR_LOCATION,
        CYBLE_UUID_CHAR_SC_CONTROL_POINT
    };
    uint8 i;
    static CYBLE_GATT_DB_ATTR_HANDLE_T *cscsLastEndHandle = NULL;

    /* Update last characteristic endHandle to declaration handle of this characteristic */ 
    if(cscsLastEndHandle != NULL)
    {
        *cscsLastEndHandle = discCharInfo->charDeclHandle - 1u;
        cscsLastEndHandle = NULL;
    }

    for(i = (uint8) CYBLE_CSCS_CSC_MEASUREMENT; i < (uint8) CYBLE_CSCS_CHAR_COUNT; i++)
    {
        if(cyBle_cscscCharUuid[i] == discCharInfo->uuid.uuid16)
        {
            cyBle_cscsc.characteristics[i].charInfo.valueHandle = discCharInfo->valueHandle;
            cyBle_cscsc.characteristics[i].charInfo.properties  = discCharInfo->properties;
            cscsLastEndHandle = &cyBle_cscsc.characteristics[i].endHandle;
            break;
        }
    }

    /* Initially characteristic endHandle equals to the Service endHandle.
    * Characteristic endHandle will be updated to declaration handler of the
    * following characteristic,in the following characteristic discovery 
    * procedure.
    */
    if(cscsLastEndHandle != NULL)
    {
        *cscsLastEndHandle = cyBle_serverInfo[cyBle_disCount].range.endHandle;
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscDiscoverCharDescriptorsEventHandler
****************************************************************************//**
* 
*  This function is called on receiving a "CYBLE_EVT_GATTC_FIND_INFO_RSP" event. 
*  This event is generated when a server successfully sends the data for 
*  "CYBLE_EVT_GATTC_FIND_INFO_REQ". Based on the service UUID, an appropriate data 
*  structure is populated to the service with a service callback.
* 
*  \param discCharInfo: The pointer to a characteristic information structure.
* 
*******************************************************************************/
void CyBle_CscscDiscoverCharDescriptorsEventHandler(CYBLE_CSCS_CHAR_INDEX_T charIndex,
                                                    CYBLE_DISC_DESCR_INFO_T * discDescrInfo)
{
    if(discDescrInfo->uuid.uuid16 == CYBLE_UUID_CHAR_CLIENT_CONFIG)
    {
        if((cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD] ==
            CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE) && (charIndex == CYBLE_CSCS_CSC_MEASUREMENT))
        {
            cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD] =
                discDescrInfo->descrHandle;
        }
        else if((cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD] ==
            CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE) && (charIndex == CYBLE_CSCS_SC_CONTROL_POINT))
        {
            cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD] =
                discDescrInfo->descrHandle;
        }
        else    /* Duplication of descriptor */
        {
            CyBle_ApplCallback((uint32)CYBLE_EVT_GATTC_DESCR_DUPLICATION, &discDescrInfo->uuid);
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscNotificationEventHandler
****************************************************************************//**
* 
*  Handles the Notification Event for the Cycling Speed and Cadence Service.
* 
*  \param eventParam: The pointer to the CYBLE_GATTC_HANDLE_VALUE_NTF_PARAM_T
*                      data structure specified by the event.
* 
*******************************************************************************/
void CyBle_CscscNotificationEventHandler(CYBLE_GATTC_HANDLE_VALUE_NTF_PARAM_T *eventParam)
{
    if(NULL != CyBle_CscsApplCallback)
    {
        if(cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].charInfo.valueHandle == 
            eventParam->handleValPair.attrHandle)
        {
            CYBLE_CSCS_CHAR_VALUE_T ntfParam;
            
            ntfParam.charIndex = CYBLE_CSCS_CSC_MEASUREMENT;
            ntfParam.connHandle = eventParam->connHandle;
            ntfParam.value = &eventParam->handleValPair.value;
            
            CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_NOTIFICATION, (void *)&ntfParam);
            cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscIndicationEventHandler
****************************************************************************//**
* 
*  Handles the Indication Event for the Cycling Speed and Cadence Service.
* 
*  \param eventParam: The pointer to the CYBLE_GATTC_HANDLE_VALUE_NTF_PARAM_T
*                      data structure specified by the event.
* 
*******************************************************************************/
void CyBle_CscscIndicationEventHandler(CYBLE_GATTC_HANDLE_VALUE_IND_PARAM_T *eventParam)
{
    if(NULL != CyBle_CscsApplCallback)
    {
        if(cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].charInfo.valueHandle == 
            eventParam->handleValPair.attrHandle)
        {
            CYBLE_CSCS_CHAR_VALUE_T ntfParam;

            ntfParam.charIndex = CYBLE_CSCS_SC_CONTROL_POINT;
            ntfParam.connHandle = eventParam->connHandle;
            ntfParam.value = &eventParam->handleValPair.value;
            
            CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_INDICATION, (void *)&ntfParam);
            cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscReadResponseEventHandler
****************************************************************************//**
* 
*  Handles the Read Response Event for the Cycling Speed and Cadence Service.
* 
*  \param eventParam: The pointer to the data that came with a read response for CSCS.
* 
*******************************************************************************/
void CyBle_CscscReadResponseEventHandler(CYBLE_GATTC_READ_RSP_PARAM_T *eventParam)
{
    uint8 flag = 1u;
    uint8 attrVal = 0u;
    CYBLE_CSCS_CHAR_INDEX_T idx;
    
    if((NULL != CyBle_CscsApplCallback) && (CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscscReqHandle))
    {
        if(cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_FEATURE].charInfo.valueHandle == cyBle_cscscReqHandle)
        {
            idx = CYBLE_CSCS_CSC_FEATURE;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_SENSOR_LOCATION].charInfo.valueHandle == cyBle_cscscReqHandle)
        {
            idx = CYBLE_CSCS_SENSOR_LOCATION;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD] == 
            cyBle_cscscReqHandle)
        {
            /* Attribute is Characteristic Descriptor */
            attrVal = 1u;
            idx = CYBLE_CSCS_CSC_MEASUREMENT;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD] == 
            cyBle_cscscReqHandle)
        {
            /* Attribute is Characteristic Descriptor */
            attrVal = 1u;
            idx = CYBLE_CSCS_SC_CONTROL_POINT;
        }
        else
        {
            /* No CSCS Characteristic were requested for read */
            flag = 0u;
        }

        if(0u != flag)
        {
            /* Read response for characteristic */
            if(attrVal == 0u)
            {
                CYBLE_CSCS_CHAR_VALUE_T rdRspParam;

                /* Fill Cycling Speed and Cadence Service read response parameter structure with
                  Characteristic info. */
                rdRspParam.connHandle = eventParam->connHandle;
                rdRspParam.charIndex = idx;
                rdRspParam.value = &eventParam->value;

                CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_READ_CHAR_RESPONSE, (void *)&rdRspParam);
            }
            else /* Read response for characteristic descriptor */
            {
                CYBLE_CSCS_DESCR_VALUE_T rdRspParam;

                /* Fill Cycling Speed and Cadence Service read response parameter structure with
                  Characteristic Descriptor info. */
                rdRspParam.connHandle = eventParam->connHandle;
                rdRspParam.charIndex = idx;
                rdRspParam.descrIndex = CYBLE_CSCS_CCCD;
                rdRspParam.value = &eventParam->value;

                CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_READ_DESCR_RESPONSE, (void *)&rdRspParam);
            }

            cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
            cyBle_cscscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscWriteResponseEventHandler
****************************************************************************//**
* 
*  Handles the Write Response Event for the Cycling Speed and Cadence Service.
* 
*  \param eventParam: The pointer to the CYBLE_CONN_HANDLE_T data structure.
* 
*******************************************************************************/
void CyBle_CscscWriteResponseEventHandler(const CYBLE_CONN_HANDLE_T *eventParam)
{
    uint8 flag = 1u;
    uint8 attrType = 0u;
    CYBLE_CSCS_CHAR_INDEX_T idx;

    if((NULL != CyBle_CscsApplCallback) && (CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscscReqHandle))
    {
        if(cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_FEATURE].charInfo.valueHandle == cyBle_cscscReqHandle)
        {
            idx = CYBLE_CSCS_CSC_FEATURE;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_SENSOR_LOCATION].charInfo.valueHandle == cyBle_cscscReqHandle)
        {
            idx = CYBLE_CSCS_SENSOR_LOCATION;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].charInfo.valueHandle == cyBle_cscscReqHandle)
        {
            idx = CYBLE_CSCS_SC_CONTROL_POINT;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD] == 
            cyBle_cscscReqHandle)
        {
            /* Attribute is Characteristic Descriptor */
            attrType = 1u;
            idx = CYBLE_CSCS_CSC_MEASUREMENT;
        }
        else if(cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD] == 
            cyBle_cscscReqHandle)
        {
            /* Attribute is Characteristic Descriptor */
            attrType = 1u;
            idx = CYBLE_CSCS_SC_CONTROL_POINT;
        }
        else
        {
            /* No CSCS Characteristic were requested for write */
            flag = 0u;
        }
        
        if(0u != flag)
        {
            /* This should be cleared before calling to */
            cyBle_cscscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
            
            /* Write response for characteristic */
            if(attrType == 0u)
            {
                CYBLE_CSCS_CHAR_VALUE_T rdRspParam;

                /* Fill Cycling Speed and Cadence Service write response parameter structure with
                  Characteristic info. */
                rdRspParam.connHandle = *eventParam;
                rdRspParam.charIndex = idx;
                rdRspParam.value = NULL;

                CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_WRITE_CHAR_RESPONSE, (void *)&rdRspParam);
            }
            else /* Write response for characteristic descriptor */
            {
                CYBLE_CSCS_DESCR_VALUE_T rdRspParam;

                /* Fill Cycling Speed and Cadence Service write response parameter structure with
                  Characteristic Descriptor info. */
                rdRspParam.connHandle = *eventParam;
                rdRspParam.charIndex = idx;
                rdRspParam.descrIndex = CYBLE_CSCS_CCCD;
                rdRspParam.value = NULL;

                CyBle_CscsApplCallback((uint32)CYBLE_EVT_CSCSC_WRITE_DESCR_RESPONSE, (void *)&rdRspParam);
            }

            cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
        }
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscErrorResponseEventHandler
****************************************************************************//**
* 
*  Handles the Error Response Event for the Cycling Speed and Cadence Service.
* 
*  \param eventParam: The pointer to the CYBLE_GATTC_ERR_RSP_PARAM_T structure.
* 
*******************************************************************************/
void CyBle_CscscErrorResponseEventHandler(const CYBLE_GATTC_ERR_RSP_PARAM_T *eventParam)
{
    if(CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_cscscReqHandle)
    {
        cyBle_cscscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
    }
}


/*******************************************************************************
* Function Name: CyBle_CscscSetCharacteristicValue
****************************************************************************//**
* 
*  This function is used to write the characteristic (which is identified by
*  charIndex) value attribute in the server. As a result a Write Request is 
*  sent to the GATT Server and on successful execution of the request on the 
*  Server side the CYBLE_EVT_CSCSS_CHAR_WRITE events is generated.
*  On successful request execution on the Server side the Write Response is 
*  sent to the Client.
* 
*  \param connHandle:    The connection handle.
*  \param charIndex:     The index of a service characteristic.
*  \param attrSize:      Size of the characteristic value attribute.
*  \param attrValue:    Pointer to the characteristic value data 
*                        that should be sent to the server device. 
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request was sent successfully;
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this.
*                                      characteristic.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular characteristic.
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the CSCS service-specific callback is registered 
*      (with CyBle_CscsRegisterAttrCallback):
*  * CYBLE_EVT_CSCSC_WRITE_CHAR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index, etc.) are 
*                                provided with event parameter structure
*                                of type CYBLE_CSCS_CHAR_VALUE_T.
*  .
*   Otherwise (if the CSCS service-specific callback is not registered):
*  * CYBLE_EVT_GATTC_WRITE_RSP - in case if the requested attribute is 
*                                successfully wrote on the peer device.
*  * CYBLE_EVT_GATTC_ERROR_RSP - in case if there some trouble with the 
*                                requested attribute on the peer device,
*                                the details are provided with event parameters 
*                                structure (CYBLE_GATTC_ERR_RSP_PARAM_T).
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscscSetCharacteristicValue(CYBLE_CONN_HANDLE_T connHandle, CYBLE_CSCS_CHAR_INDEX_T charIndex,
    uint8 attrSize, uint8 *attrValue)
{
    CYBLE_GATTC_WRITE_CMD_REQ_T wrReqParam;
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;

    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if((attrValue != NULL) && (charIndex == CYBLE_CSCS_SC_CONTROL_POINT))
    {
        if(CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE !=  
           cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].charInfo.valueHandle)
        {
            /* Fill all fields of write command request structure ... */
            wrReqParam.value.val = attrValue;
            wrReqParam.value.len = attrSize;
            wrReqParam.attrHandle = cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].charInfo.valueHandle;

            /* Send request to write characteristic value */
            apiResult = CyBle_GattcWriteCharacteristicValue(connHandle, &wrReqParam);
            
            if(apiResult == CYBLE_ERROR_OK)
            {
                cyBle_cscscReqHandle = wrReqParam.attrHandle;
            }
        }
        else
        {
            apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
        }
    }
    else
    {
        /* Validation of input parameters failed */
    }

    return(apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscscGetCharacteristicValue
****************************************************************************//**
* 
*  Sends a request to peer device to get characteristic value of the Cycling 
*  Speed and Cadence Service, which is identified by charIndex.
* 
*  \param connHandle:    The connection handle.
*  \param charIndex:     The index of a service characteristic.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request was sent successfully;
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this
*                                      characteristic.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular characteristic.
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the CSCS service-specific callback is registered 
*      (with CyBle_CscsRegisterAttrCallback):
*  * CYBLE_EVT_CSCSC_READ_CHAR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index , value, etc.) are 
*                                provided with event parameter structure
*                                of type CYBLE_CSCS_CHAR_VALUE_T.
*  .
*   Otherwise (if the CSCS service-specific callback is not registered):
*  * CYBLE_EVT_GATTC_READ_RSP - in case if the requested attribute is 
*                                successfully read on the peer device,
*                                the details (handle, value, etc.) are 
*                                provided with event parameters 
*                                structure (CYBLE_GATTC_READ_RSP_PARAM_T).
*  * CYBLE_EVT_GATTC_ERROR_RSP - in case if there some trouble with the 
*                                requested attribute on the peer device,
*                                the details are provided with event parameters 
*                                structure (CYBLE_GATTC_ERR_RSP_PARAM_T).
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscscGetCharacteristicValue(CYBLE_CONN_HANDLE_T connHandle, CYBLE_CSCS_CHAR_INDEX_T charIndex)
{
    CYBLE_GATT_DB_ATTR_HANDLE_T tmpCharHandle;
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_OK;

    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else
    {
        /* Select characteristic */
        switch(charIndex)
        {
        case CYBLE_CSCS_CSC_FEATURE:
            tmpCharHandle = cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_FEATURE].charInfo.valueHandle;
            break;
        case CYBLE_CSCS_SENSOR_LOCATION:
            tmpCharHandle = cyBle_cscsc.characteristics[CYBLE_CSCS_SENSOR_LOCATION].charInfo.valueHandle;
            break;
        default:
            /* Characteristic wasn't found */
            apiResult = CYBLE_ERROR_INVALID_PARAMETER;
            break;
        }

        if(apiResult == CYBLE_ERROR_OK)
        {
            if(tmpCharHandle != CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
            {
                /* Send request to read characteristic value */
                apiResult = CyBle_GattcReadCharacteristicValue(connHandle, tmpCharHandle);
            
                if(apiResult == CYBLE_ERROR_OK)
                {
                    cyBle_cscscReqHandle = tmpCharHandle;
                }
            }
            else
            {
                apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
            }
        }
    }
    return(apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscscSetCharacteristicDescriptor
****************************************************************************//**
* 
*  Sends a request to peer device to get characteristic descriptor of specified
*  characteristic of the Cycling Speed and Cadence Service.
*
*  Internally, Write Request is sent to the GATT Server and on successful 
*  execution of the request on the Server side the following events can be 
*  generated: 
*  * CYBLE_EVT_CSCSS_NOTIFICATION_ENABLED 
*  * CYBLE_EVT_CSCSS_NOTIFICATION_DISABLED
*  * CYBLE_EVT_CSCSS_INDICATION_ENABLED 
*  * CYBLE_EVT_CSCSS_INDICATION_DISABLED
* 
*  \param connHandle:      The connection handle.
*  \param charIndex:       The index of a CSCS characteristic.
*  \param descrIndex:      The index of a CSCS characteristic descriptor.
*  \param attrSize:        The size of the characteristic descriptor attribute.
*  \param attrValue:      The pointer to the characteristic descriptor value 
*                          data that should be sent to the server device.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - the  request was sent successfully.
*   * CYBLE_ERROR_INVALID_STATE - connection with the client is not established.
*   * CYBLE_ERROR_INVALID_PARAMETER - validation of the input parameters failed.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this
*                                      characteristic.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular descriptor.
** \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the CSCS service-specific callback is registered 
*      (with CyBle_CscsRegisterAttrCallback):
*  * CYBLE_EVT_CSCSC_WRITE_DESCR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index, descr index etc.) are 
*                                provided with event parameter structure
*                                of type CYBLE_CSCS_DESCR_VALUE_T.
*  .
*   Otherwise (if the CSCS service-specific callback is not registered):
*  * CYBLE_EVT_GATTC_WRITE_RSP - in case if the requested attribute is 
*                                successfully wrote on the peer device.
*  * CYBLE_EVT_GATTC_ERROR_RSP - in case if there some trouble with the 
*                                requested attribute on the peer device,
*                                the details are provided with event parameters 
*                                structure (CYBLE_GATTC_ERR_RSP_PARAM_T).
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscscSetCharacteristicDescriptor(CYBLE_CONN_HANDLE_T connHandle,
                                                         CYBLE_CSCS_CHAR_INDEX_T charIndex,
                                                         CYBLE_CSCS_DESCR_INDEX_T descrIndex,
                                                         uint8 attrSize,
                                                         uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    
    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if((attrValue != NULL) && (descrIndex == CYBLE_CSCS_CCCD) && (attrSize == CYBLE_CCCD_LEN))
    {
        if((charIndex == CYBLE_CSCS_CSC_MEASUREMENT) || (charIndex == CYBLE_CSCS_SC_CONTROL_POINT))
        {
            CYBLE_GATTC_WRITE_REQ_T writeReqParam;
            
            /* Fill all fields of write request structure ... */
            writeReqParam.value.val = attrValue;
            writeReqParam.value.len = attrSize;
          
            if(charIndex == CYBLE_CSCS_CSC_MEASUREMENT)
            {
                writeReqParam.attrHandle =
                    cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD];
            }
            else
            {
                writeReqParam.attrHandle =
                    cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD];
            }

            if(writeReqParam.attrHandle != CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
            {
                /* ... and send a request to the Server device. */        
                apiResult = CyBle_GattcWriteCharacteristicDescriptors(connHandle, &writeReqParam);
                
                if(apiResult == CYBLE_ERROR_OK)
                {
                    cyBle_cscscReqHandle =
                        cyBle_cscsc.characteristics[charIndex].descriptors[CYBLE_CSCS_CCCD];
                }
            }
            else
            {
                apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
            }
        }
    }
    else
    {
        /* The characteristic has not been discovered or has invalid fields */   
    }
    
    /* Return the status */
    return(apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscscGetCharacteristicDescriptor
****************************************************************************//**
* 
*  Sends a request to peer device to get characteristic descriptor of specified
*  characteristic of the Cycling Speed and Cadence Service.
* 
*  \param connHandle:      The connection handle.
*  \param charIndex:       The index of a Service Characteristic.
*  \param descrIndex:      The index of a Service Characteristic Descriptor.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request was sent successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_INVALID_STATE - Connection with the Client is not established.
*   * CYBLE_ERROR_INVALID_OPERATION - Cannot process a request to send PDU due to
*                                     invalid operation performed by the 
*                                     application.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Peer device doesn't have a 
*                                                particular descriptor.
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*  If the CSCS service-specific callback is registered 
*      (with CyBle_CscsRegisterAttrCallback):
*  * CYBLE_EVT_CSCSC_READ_DESCR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index, descr index, value, etc.) 
*                                are provided with event parameter structure
*                                of type CYBLE_CSCS_DESCR_VALUE_T. 
*  .
*  Otherwise (if the CSCS service-specific callback is not registered):
*  * CYBLE_EVT_GATTC_READ_RSP - in case if the requested attribute is 
*                                successfully read on the peer device,
*                                the details (handle, value, etc.) are 
*                                provided with event parameters 
*                                structure (CYBLE_GATTC_READ_RSP_PARAM_T).
*  * CYBLE_EVT_GATTC_ERROR_RSP - in case if there some trouble with the 
*                                requested attribute on the peer device,
*                                the details are provided with event parameters 
*                                structure (CYBLE_GATTC_ERR_RSP_PARAM_T).
*
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscscGetCharacteristicDescriptor(CYBLE_CONN_HANDLE_T connHandle,
                                                   CYBLE_CSCS_CHAR_INDEX_T charIndex,
                                                   CYBLE_CSCS_DESCR_INDEX_T descrIndex)
{
    CYBLE_GATT_DB_ATTR_HANDLE_T tmpHandle;
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    
    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if(((charIndex == CYBLE_CSCS_CSC_MEASUREMENT) || (charIndex == CYBLE_CSCS_SC_CONTROL_POINT)) &&
        (descrIndex == CYBLE_CSCS_CCCD))
    {
        if(charIndex == CYBLE_CSCS_CSC_MEASUREMENT)
        {
            tmpHandle = cyBle_cscsc.characteristics[CYBLE_CSCS_CSC_MEASUREMENT].descriptors[CYBLE_CSCS_CCCD];
        }
        else
        {
            tmpHandle = cyBle_cscsc.characteristics[CYBLE_CSCS_SC_CONTROL_POINT].descriptors[CYBLE_CSCS_CCCD];
        }
        
        if(tmpHandle != CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
        {
            apiResult = CyBle_GattcReadCharacteristicDescriptors(connHandle, tmpHandle);
            
            if(apiResult == CYBLE_ERROR_OK)
            {
                cyBle_cscscReqHandle = tmpHandle;
            }
        }
        else
        {
            apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
        }
    }
    else
    {
        /* Characteristic has not been discovered or had invalid fields */
    }

    return(apiResult);
}


/*******************************************************************************
* Function Name: CyBle_CscscStoreProfileData
****************************************************************************//**
* 
*  Stores the structure with discovered attributes of Cycling Speed and Cadence
*  Server device to the Flash.
* 
*  \param isForceWrite:  If value is set to 0, then stack will check if flash write 
*                        is permissible. 
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - On successful operation.
*  * CYBLE_ERROR_FLASH_WRITE_NOT_PERMITED - Flash Write is not complete.
* 
*******************************************************************************/
CYBLE_API_RESULT_T CyBle_CscscStoreProfileData(uint8 isForceWrite)
{
    return(CyBle_StoreAppData((uint8 *) &cyBle_cscsc, (const uint8 *) &cyBle_flashCscsc, sizeof(cyBle_cscsc),
            isForceWrite));
}

#endif /* CYBLE_CSCS_CLIENT */


/* [] END OF FILE */
