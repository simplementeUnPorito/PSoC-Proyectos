/***************************************************************************//**
* \file CYBLE_bls.c
* \version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
* 
* \brief
*  This file contains the source code for the Blood Pressure Service.
* 
********************************************************************************
* \copyright
* Copyright 2014-2018, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/


#include "`$INSTANCE_NAME`_eventHandler.h"

static CYBLE_CALLBACK_T CyBle_BlsApplCallback;

#ifdef CYBLE_BLS_SERVER

`$BlsServer`
    
static CYBLE_GATT_DB_ATTR_HANDLE_T cyBle_blssReqHandle;

#endif /* CYBLE_BLS_SERVER */

#ifdef CYBLE_BLS_CLIENT
    
/* Server's Blood Pressure Service characteristics GATT DB handles structure */
CYBLE_BLSC_T cyBle_blsc;

/* Internal storage for last request handle to check the response */
static CYBLE_GATT_DB_ATTR_HANDLE_T cyBle_blscReqHandle;
#endif /* CYBLE_BLS_CLIENT */


/****************************************************************************** 
* Function Name: CyBle_BlsInit
***************************************************************************//**
* 
*  This function initializes the BLS Service.
* 
******************************************************************************/
void CyBle_BlsInit(void)
{
#ifdef CYBLE_BLS_CLIENT
    if(cyBle_serverInfo[CYBLE_SRVI_BLS].range.startHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        (void)memset(&cyBle_blsc, 0, sizeof(cyBle_blsc));
    }
    cyBle_blscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
#endif /* CYBLE_GATT_ROLE_CLIENT */
}


/******************************************************************************
* Function Name: CyBle_BlsRegisterAttrCallback
***************************************************************************//**
* 
*  Registers a callback function for service specific attribute operations.
*  Service specific write requests from peer device will not be handled with
*  unregistered callback function.
* 
*  \param callbackFunc: An application layer event callback function to receive 
*                    events from the BLE Component. The definition of 
*                    CYBLE_CALLBACK_T for Blood Pressure Service is:\n
*                    typedef void (* CYBLE_CALLBACK_T) (uint32 eventCode, 
*                                                     void *eventParam)
*                    * eventCode indicates the event that triggered this 
*                      callback (e.g. CYBLE_EVT_BASS_NOTIFICATION_ENABLED)
*                    * eventParam contains the parameters corresponding to the 
*                      current event (e.g. Pointer to CYBLE_BLS_CHAR_VALUE_T 
*                      structure that contains details of the characteristic 
*                      for which notification enabled event was triggered).
* 
******************************************************************************/
void CyBle_BlsRegisterAttrCallback(CYBLE_CALLBACK_T callbackFunc)
{
    CyBle_BlsApplCallback = callbackFunc;
}


#ifdef CYBLE_BLS_SERVER


/******************************************************************************
* Function Name: CyBle_BlssSetCharacteristicValue
***************************************************************************//**
* 
*  Sets the value of a characteristic which is identified by charIndex.
* 
*  \param charIndex: The index of a service characteristic.
*  \param attrSize: The size of the characteristic value attribute.
*  \param attrValue: The pointer to the characteristic value data that should be 
*              stored to the GATT database.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The request handled successfully.
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed.
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Optional characteristic is absent
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlssSetCharacteristicValue(CYBLE_BLS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_OK;

    if(charIndex >= CYBLE_BLS_CHAR_COUNT)
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(cyBle_blss.charInfo[charIndex].charHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
    }
    else
    {
        CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
        
        /* Store characteristic value into GATT database */
        locHandleValuePair.attrHandle = cyBle_blss.charInfo[charIndex].charHandle;
        locHandleValuePair.value.len = attrSize;
        locHandleValuePair.value.val = attrValue;
        
        if(CYBLE_GATT_ERR_NONE != CyBle_GattsWriteAttributeValue(&locHandleValuePair,
                                    0u, NULL, CYBLE_GATT_DB_LOCALLY_INITIATED))
        {
            apiResult = CYBLE_ERROR_INVALID_PARAMETER;
        }
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlssGetCharacteristicValue
***************************************************************************//**
* 
*  Gets a characteristic value of the Blood pressure service, which is 
*  identified by charIndex.
* 
*  \param charIndex: The index of a service characteristic.
*  \param attrSize: The size of the characteristic value attribute.
*  \param attrValue: The pointer to the characteristic value data that should be
*               in the GATT database.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The request handled successfully
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Optional characteristic is absent
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlssGetCharacteristicValue(CYBLE_BLS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_OK;
    
    /* Check the parameters */
    if(charIndex >= CYBLE_BLS_CHAR_COUNT)
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(cyBle_blss.charInfo[charIndex].charHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
    }
    else
    {
        CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
        
        /* Get characteristic value from GATT database */
        locHandleValuePair.attrHandle = cyBle_blss.charInfo[charIndex].charHandle;
        locHandleValuePair.value.len = attrSize;
        locHandleValuePair.value.val = attrValue;
        
        if(CYBLE_GATT_ERR_NONE != CyBle_GattsReadAttributeValue(&locHandleValuePair,
                                    0u, CYBLE_GATT_DB_LOCALLY_INITIATED))
        {
            apiResult = CYBLE_ERROR_INVALID_PARAMETER;
        }  
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlssGetCharacteristicDescriptor
***************************************************************************//**
* 
*  Gets a characteristic descriptor of a specified characteristic of the Blood
*  pressure service from the local GATT database.
* 
*  \param charIndex: The index of the characteristic.
*  \param descrIndex: The index of the characteristic descriptor.
*  \param attrSize: The size of the characteristic descriptor attribute.
*  \param attrValue: The pointer to the location where characteristic descriptor 
*               value data should be stored.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The request handled successfully
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Optional descriptor is absent
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlssGetCharacteristicDescriptor(CYBLE_BLS_CHAR_INDEX_T charIndex, 
                                                         CYBLE_BLS_DESCR_INDEX_T descrIndex,
                                                         uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult = CYBLE_ERROR_OK;
    
    /* Check parameters */
    if((charIndex >= CYBLE_BLS_CHAR_COUNT) || (descrIndex >= CYBLE_BLS_DESCR_COUNT))
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
	else if(cyBle_blss.charInfo[charIndex].cccdHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
    }
    else
    {
        CYBLE_GATT_HANDLE_VALUE_PAIR_T locHandleValuePair;
        
        /* Get data from database */
        locHandleValuePair.attrHandle = cyBle_blss.charInfo[charIndex].cccdHandle;
        locHandleValuePair.value.len = attrSize;
        locHandleValuePair.value.val = attrValue;

        if(CYBLE_GATT_ERR_NONE != CyBle_GattsReadAttributeValue(&locHandleValuePair,
                                    0u, CYBLE_GATT_DB_LOCALLY_INITIATED))
        {
            apiResult = CYBLE_ERROR_INVALID_PARAMETER;
        }
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlssSendNotification
***************************************************************************//**
* 
*  Sends a notification of the specified characteristic to the Client device.
*
*  On enabling notification successfully for a service characteristic it sends 
*  out a 'Handle Value Notification' which results in 
*  CYBLE_EVT_BLSC_NOTIFICATION event at the GATT Client's end.
*  
*  \param connHandle: The connection handle which consist of the device ID and 
*                     ATT connection ID.
*  \param charIndex:  The index of the service characteristic.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue:  The pointer to the characteristic value data that should 
*                     be sent to the client device.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed.
*   * CYBLE_ERROR_INVALID_OPERATION - This operation is not permitted.
*   * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - Optional characteristic is 
*                                               absent.
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_NTF_DISABLED - Notification is not enabled by the client.
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlssSendNotification(CYBLE_CONN_HANDLE_T connHandle,
                    CYBLE_BLS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult;
    
    /* Send Notification if it is enabled and connected */
    if(CYBLE_STATE_CONNECTED != CyBle_GetState())
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if(charIndex >= CYBLE_BLS_CHAR_COUNT)
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(cyBle_blss.charInfo[charIndex].charHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
        apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
    }
    else if(!CYBLE_IS_NOTIFICATION_ENABLED(cyBle_blss.charInfo[charIndex].cccdHandle))
    {
        apiResult = CYBLE_ERROR_NTF_DISABLED;
    }
    else
    {
        CYBLE_GATTS_HANDLE_VALUE_NTF_T ntfParam;
        
        /* Fill all fields of write request structure ... */
        ntfParam.attrHandle = cyBle_blss.charInfo[charIndex].charHandle; 
        ntfParam.value.val = attrValue;
        ntfParam.value.len = attrSize;
        
        /* Send notification to client using previously filled structure */
        apiResult = CyBle_GattsNotification(connHandle, &ntfParam);
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlssSendIndication
***************************************************************************//**
* 
*  Sends an indication of the specified characteristic to the Client device.
* 
*  On enabling indication successfully it sends out a 'Handle Value Indication'
*  which results in CYBLE_EVT_BLSC_INDICATION or 
*  CYBLE_EVT_GATTC_HANDLE_VALUE_IND (if service specific callback function is 
*  not registered) event at the GATT Client's end.
* 
*  \param connHandle: The connection handle which consist of the device ID and ATT 
*                     connection ID.
*  \param charIndex:  The index of the service characteristic.
*  \param attrSize:   The size of the characteristic value attribute.
*  \param attrValue:  The pointer to the characteristic value data that should be
*                     sent to the client device.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*   * CYBLE_ERROR_OK - The request handled successfully.
*   * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameter failed.
*   * CYBLE_ERROR_INVALID_OPERATION - This operation is not permitted.
*   * CYBLE_ERROR_INVALID_STATE - Connection with the client is not established.
*   * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed.
*   * CYBLE_ERROR_IND_DISABLED - Indication is not enabled by the client.
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the BLS service-specific callback is registered 
*      (with CyBle_BlsRegisterAttrCallback):
*  * CYBLE_EVT_BLSS_INDICATION_CONFIRMED - In case if the indication is
*                                successfully delivered to the peer device.
*  .
*   Otherwise (if the BLS service-specific callback is not registered):
*  * CYBLE_EVT_GATTS_HANDLE_VALUE_CNF - In case if the indication is
*                                successfully delivered to the peer device.
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlssSendIndication(CYBLE_CONN_HANDLE_T connHandle,
                    CYBLE_BLS_CHAR_INDEX_T charIndex, uint8 attrSize, uint8 *attrValue)
{
    CYBLE_API_RESULT_T apiResult;
    
    /* Send Indication if it is enabled and connected */
    if(CYBLE_STATE_CONNECTED != CyBle_GetState())
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if(charIndex >= CYBLE_BLS_CHAR_COUNT)
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(charIndex != CYBLE_BLS_BPM)
    {
        apiResult = CYBLE_ERROR_INVALID_OPERATION;
    }
    else if(!CYBLE_IS_INDICATION_ENABLED(cyBle_blss.charInfo[charIndex].cccdHandle))
    {
        apiResult = CYBLE_ERROR_IND_DISABLED;
    }
    else
    {
        CYBLE_GATTS_HANDLE_VALUE_IND_T indParam;
        
        /* Fill all fields of write request structure ... */
        indParam.attrHandle = cyBle_blss.charInfo[charIndex].charHandle; 
        indParam.value.val = attrValue;
        indParam.value.len = attrSize;
        
        /* Send indication to client using previously filled structure */
        apiResult = CyBle_GattsIndication(connHandle, &indParam);
        
        /* Save handle to support service specific value confirmation response from client */
        if(apiResult == CYBLE_ERROR_OK)
        {
            cyBle_blssReqHandle = indParam.attrHandle;
        }
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlssConfirmationEventHandler
***************************************************************************//**
* 
*  Handles the Value Confirmation request event from the BLE stack.
* 
*  \param eventParam - Pointer to a structure of type CYBLE_CONN_HANDLE_T
* 
******************************************************************************/
void CyBle_BlssConfirmationEventHandler(const CYBLE_CONN_HANDLE_T *eventParam)
{
    if((CyBle_BlsApplCallback != NULL) && (cyBle_blss.charInfo[CYBLE_BLS_BPM].charHandle == cyBle_blssReqHandle))
    {   
        CYBLE_BLS_CHAR_VALUE_T locCharIndex;
        
        cyBle_blssReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
        
        locCharIndex.connHandle = *eventParam;
        locCharIndex.charIndex = CYBLE_BLS_BPM;
        locCharIndex.value = NULL;
        
        cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
        CyBle_BlsApplCallback((uint32)CYBLE_EVT_BLSS_INDICATION_CONFIRMED, &locCharIndex);
    }
}


/******************************************************************************
* Function Name: CyBle_BlssWriteEventHandler
***************************************************************************//**
* 
*  Handles the Write Request Event.
* 
*  \param void *eventParam: The pointer to the data structure specified by the
*                           event.
* 
* \return
*   CYBLE_GATT_ERR_CODE_T - A function return state if it succeeded 
*                           (CYBLE_GATT_ERR_NONE) or GATT error codes returned
*                           by CyBle_GattsWriteAttributeValue().
* 
******************************************************************************/
CYBLE_GATT_ERR_CODE_T CyBle_BlssWriteEventHandler(CYBLE_GATTS_WRITE_REQ_PARAM_T *eventParam)
{
    CYBLE_GATT_ERR_CODE_T gattErr = CYBLE_GATT_ERR_NONE;
    
    if(NULL != CyBle_BlsApplCallback)
    {
	    CYBLE_BLS_CHAR_VALUE_T locCharIndex;
        locCharIndex.connHandle = eventParam->connHandle;
	    locCharIndex.value = NULL;
    
        for (locCharIndex.charIndex = CYBLE_BLS_BPM; locCharIndex.charIndex < CYBLE_BLS_BPF; locCharIndex.charIndex++)
        {
            if(eventParam->handleValPair.attrHandle == cyBle_blss.charInfo[locCharIndex.charIndex].cccdHandle)
            {
                gattErr = CyBle_GattsWriteAttributeValue(&eventParam->handleValPair,
                            0u, &eventParam->connHandle, CYBLE_GATT_DB_PEER_INITIATED);
            
                if(gattErr == CYBLE_GATT_ERR_NONE)
                {
                    uint32 eventCode;
                    
                    if(locCharIndex.charIndex == CYBLE_BLS_ICP)
                    {
                        if(CYBLE_IS_NOTIFICATION_ENABLED_IN_PTR(eventParam->handleValPair.value.val))
                        {
                            eventCode = (uint32) CYBLE_EVT_BLSS_NOTIFICATION_ENABLED;
                        }
                        else
                        {
                            eventCode = (uint32) CYBLE_EVT_BLSS_NOTIFICATION_DISABLED;
                        }
                    }
                    else
                    {
                        if(CYBLE_IS_INDICATION_ENABLED_IN_PTR(eventParam->handleValPair.value.val))
                        {
                            eventCode = (uint32) CYBLE_EVT_BLSS_INDICATION_ENABLED;
                        }
                        else
                        {
                            eventCode = (uint32) CYBLE_EVT_BLSS_INDICATION_DISABLED;
                        }
                    }
                #if((CYBLE_GAP_ROLE_PERIPHERAL || CYBLE_GAP_ROLE_CENTRAL) && \
                    (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES))
                    /* Set flag to store bonding data to flash */
                    if(cyBle_peerBonding == CYBLE_GAP_BONDING)
                    {
                        cyBle_pendingFlashWrite |= CYBLE_PENDING_CCCD_FLASH_WRITE_BIT;
                    }
                #endif /* (CYBLE_BONDING_REQUIREMENT == CYBLE_BONDING_YES) */
                    
                    CyBle_BlsApplCallback(eventCode, &locCharIndex);
                }
				    
                cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
                break;
			}
        }
    }

    return (gattErr);
}

#endif /* CYBLE_BLS_SERVER */

#ifdef CYBLE_BLS_CLIENT


/******************************************************************************
* Function Name: CyBle_BlscGetCharacteristicValue
***************************************************************************//**
* 
*  This function is used to read the characteristic Value from a server
*  which is identified by charIndex.
*  
*  \param connHandle: The connection handle.
*  \param charIndex: The index of the service characteristic.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The read request was sent successfully  
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - The peer device doesn't have
*                                               the particular characteristic
*  * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed
*  * CYBLE_ERROR_INVALID_STATE - Connection with the server is not established
*  * CYBLE_ERROR_INVALID_OPERATION - Operation is invalid for this 
*                                     characteristic
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the BLS service-specific callback is registered 
*      (with CyBle_BlsRegisterAttrCallback):
*  * CYBLE_EVT_BLSC_READ_CHAR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index , value, etc.) are 
*                                provided with event parameter structure
*                                of type CYBLE_BLS_CHAR_VALUE_T.
*  .
*   Otherwise (if the BLS service-specific callback is not registered):
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
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlscGetCharacteristicValue(CYBLE_CONN_HANDLE_T connHandle, CYBLE_BLS_CHAR_INDEX_T charIndex)
{
    CYBLE_API_RESULT_T apiResult;

    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if(charIndex >= CYBLE_BLS_CHAR_COUNT)
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
	else if(cyBle_blsc.charInfo[charIndex].valueHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
		apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
	}
    else if((CYBLE_CHAR_PROP_READ & cyBle_blsc.charInfo[charIndex].properties) == 0u)
    {
        apiResult = CYBLE_ERROR_INVALID_OPERATION;
    }
    else
    {
        apiResult = CyBle_GattcReadCharacteristicValue(connHandle, cyBle_blsc.charInfo[charIndex].valueHandle);
        
        if(apiResult == CYBLE_ERROR_OK)
        {
            cyBle_blscReqHandle = cyBle_blsc.charInfo[charIndex].valueHandle;
        }
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlscSetCharacteristicDescriptor
***************************************************************************//**
* 
*  Sends a request to set characteristic descriptor of specified Blood Pressure
*  Service characteristic on the server device.
*
*  Internally, Write Request is sent to the GATT Server and on successful 
*  execution of the request on the Server side the following events can be 
*  generated: 
*  * CYBLE_EVT_BLSS_INDICATION_ENABLED 
*  * CYBLE_EVT_BLSS_INDICATION_DISABLED
*  * CYBLE_EVT_BLSS_NOTIFICATION_ENABLED 
*  * CYBLE_EVT_BLSS_NOTIFICATION_DISABLED
* 
*  \param connHandle: The BLE peer device connection handle.
*  \param charIndex: The index of the service characteristic.
*  \param descrIndex: The index of the service characteristic descriptor.
*  \param attrSize: The size of the characteristic descriptor value attribute.
*  \param attrValue: Pointer to the characteristic descriptor value data that should
*               be sent to the server device.
*               
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The request was sent successfully
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed
*  * CYBLE_ERROR_INVALID_STATE - The state is not valid
*  * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - The peer device doesn't have
*                                               the particular characteristic
*  * CYBLE_ERROR_INVALID_OPERATION - This operation is not permitted on 
*                                     the specified attribute
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*   If the BLS service-specific callback is registered 
*      (with CyBle_BlsRegisterAttrCallback):
*  * CYBLE_EVT_BLSC_WRITE_DESCR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index, descr index etc.) are 
*                                provided with event parameter structure
*                                of type CYBLE_BLS_DESCR_VALUE_T.
*  .
*   Otherwise (if the BLS service-specific callback is not registered):
*  * CYBLE_EVT_GATTC_WRITE_RSP - in case if the requested attribute is 
*                                successfully wrote on the peer device.
*  * CYBLE_EVT_GATTC_ERROR_RSP - in case if there some trouble with the 
*                                requested attribute on the peer device,
*                                the details are provided with event parameters 
*                                structure (CYBLE_GATTC_ERR_RSP_PARAM_T).
*
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlscSetCharacteristicDescriptor(CYBLE_CONN_HANDLE_T connHandle, 
    CYBLE_BLS_CHAR_INDEX_T charIndex, CYBLE_BLS_DESCR_INDEX_T descrIndex, uint8 attrSize, uint8 * attrValue)
{
    CYBLE_API_RESULT_T apiResult;

    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if((charIndex >= CYBLE_BLS_CHAR_COUNT)
         || (descrIndex >= CYBLE_BLS_DESCR_COUNT)
         || (attrSize != CYBLE_CCCD_LEN))
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(cyBle_blsc.charInfo[charIndex].cccdHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
		apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
	}
    else
    {
        CYBLE_GATTC_WRITE_REQ_T writeReqParam;
        
        /* Fill all fields of write request structure ... */
        writeReqParam.attrHandle = cyBle_blsc.charInfo[charIndex].cccdHandle;
        writeReqParam.value.val = attrValue;
        writeReqParam.value.len = CYBLE_CCCD_LEN;

        /* ... and send request to server device. */
        apiResult = CyBle_GattcWriteCharacteristicDescriptors(connHandle, &writeReqParam);
        
        /* Save handle to support service specific read response from device */
        if(apiResult == CYBLE_ERROR_OK)
        {
            cyBle_blscReqHandle = writeReqParam.attrHandle;
        }
    }

    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlscGetCharacteristicDescriptor
***************************************************************************//**
* 
*  Sends a request to get characteristic descriptor of specified Blood Pressure
*  Service characteristic from the server device. This function call can result 
*  in the generation of the following events based on the response from the server 
*  device.
*  * CYBLE_EVT_BLSC_READ_DESCR_RESPONSE
*  * CYBLE_EVT_GATTC_ERROR_RSP
* 
*  \param connHandle: The BLE peer device connection handle.
*  \param charIndex: The index of a service characteristic.
*  \param descrIndex: The index of a service characteristic descriptor.
* 
* \return
*  Return value is of type CYBLE_API_RESULT_T.
*  * CYBLE_ERROR_OK - The request was sent successfully
*  * CYBLE_ERROR_INVALID_PARAMETER - Validation of the input parameters failed
*  * CYBLE_ERROR_INVALID_STATE - The state is not valid
*  * CYBLE_ERROR_MEMORY_ALLOCATION_FAILED - Memory allocation failed
*  * CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE - The peer device doesn't have
*                                               the particular descriptor
*  * CYBLE_ERROR_INVALID_OPERATION - This operation is not permitted on 
*                                     the specified attribute
*
* \events
*  In case of successful execution (return value = CYBLE_ERROR_OK)
*  the next events can appear: \n
*  If the BLS service-specific callback is registered 
*      (with CyBle_BlsRegisterAttrCallback):
*  * CYBLE_EVT_BLSC_READ_DESCR_RESPONSE - in case if the requested attribute is
*                                successfully wrote on the peer device,
*                                the details (char index, descr index, value, etc.) 
*                                are provided with event parameter structure
*                                of type CYBLE_BLS_DESCR_VALUE_T. 
*  .
*  Otherwise (if the BLS service-specific callback is not registered):
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
******************************************************************************/
CYBLE_API_RESULT_T CyBle_BlscGetCharacteristicDescriptor(CYBLE_CONN_HANDLE_T connHandle,
                       CYBLE_BLS_CHAR_INDEX_T charIndex, CYBLE_BLS_DESCR_INDEX_T descrIndex)
{
    CYBLE_API_RESULT_T apiResult;

    if(CyBle_GetClientState() != CYBLE_CLIENT_STATE_DISCOVERED)
    {
        apiResult = CYBLE_ERROR_INVALID_STATE;
    }
    else if((charIndex >= CYBLE_BLS_CHAR_COUNT) || (descrIndex >= CYBLE_BLS_DESCR_COUNT))
    {
        apiResult = CYBLE_ERROR_INVALID_PARAMETER;
    }
    else if(cyBle_blsc.charInfo[charIndex].cccdHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
    {
		apiResult = CYBLE_ERROR_GATT_DB_INVALID_ATTR_HANDLE;
	}
    else
    {
        apiResult = CyBle_GattcReadCharacteristicDescriptors(connHandle, cyBle_blsc.charInfo[charIndex].cccdHandle);
        
        if(apiResult == CYBLE_ERROR_OK)
        {
            cyBle_blscReqHandle = cyBle_blsc.charInfo[charIndex].cccdHandle;
        }
    }
    
    return (apiResult);
}


/******************************************************************************
* Function Name: CyBle_BlscDiscoverCharacteristicsEventHandler
***************************************************************************//**
* 
*  This function is called on receiving a "CYBLE_EVT_GATTC_READ_BY_TYPE_RSP"
*  event. Based on the service UUID, an appropriate data structure is populated
*  using the data received as part of the callback.
* 
*  \param discCharInfo:  The pointer to a characteristic information structure.
*  
******************************************************************************/
void CyBle_BlscDiscoverCharacteristicsEventHandler(CYBLE_DISC_CHAR_INFO_T *discCharInfo)
{
    /* Blood Pressure Service characteristics UUIDs */
    static const CYBLE_UUID16 cyBle_blscCharUuid[CYBLE_BLS_CHAR_COUNT] =
    {
        CYBLE_UUID_CHAR_BP_MSRMT,
        CYBLE_UUID_CHAR_INTRMDT_CUFF_PRSR,
        CYBLE_UUID_CHAR_BP_FEATURE
    };
    static CYBLE_GATT_DB_ATTR_HANDLE_T *blsLastEndHandle = NULL;
    uint8 i;
    
    /* Update last characteristic endHandle to declaration handle of this characteristic */
    if(blsLastEndHandle != NULL)
    {
        *blsLastEndHandle = discCharInfo->charDeclHandle - 1u;
        blsLastEndHandle = NULL;
    }
    
    for(i = 0u; i < ((uint8) CYBLE_BLS_CHAR_COUNT); i++)
    {
        if(cyBle_blscCharUuid[i] == discCharInfo->uuid.uuid16)
        {
            if(cyBle_blsc.charInfo[i].valueHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
            {
                cyBle_blsc.charInfo[i].valueHandle = discCharInfo->valueHandle;
                cyBle_blsc.charInfo[i].properties = discCharInfo->properties;
                blsLastEndHandle = &cyBle_blsc.charInfo[i].endHandle;
            }
            else
            {
                CyBle_ApplCallback(CYBLE_EVT_GATTC_CHAR_DUPLICATION, &discCharInfo->uuid);
            }
        }
    }
    
    /* Init characteristic endHandle to Service endHandle.
       Characteristic endHandle will be updated to the declaration
       Handler of the following characteristic,
       in the following characteristic discovery procedure. */
    if(blsLastEndHandle != NULL)
    {
        *blsLastEndHandle = cyBle_serverInfo[CYBLE_SRVI_BLS].range.endHandle;
    }
}


/******************************************************************************
* Function Name: CyBle_BlscDiscoverCharDescriptorsEventHandler
***************************************************************************//**
* 
*  This function is called on receiving a "CYBLE_EVT_GATTC_READ_BY_TYPE_RSP"
*  event. Based on the service UUID, an appropriate data structure is populated
*  using the data received as part of the callback.
* 
*  \param discCharInfo:  the pointer to a characteristic information structure.
* 
******************************************************************************/
void CyBle_BlscDiscoverCharDescriptorsEventHandler(CYBLE_DISC_DESCR_INFO_T * discDescrInfo)
{
    if(discDescrInfo->uuid.uuid16 == CYBLE_UUID_CHAR_CLIENT_CONFIG)
    {
        uint8 descrIdx = cyBle_disCount - CYBLE_SCDI_BLS_BPM;
        
        if(cyBle_blsc.charInfo[descrIdx].cccdHandle == CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE)
        {
            cyBle_blsc.charInfo[descrIdx].cccdHandle = discDescrInfo->descrHandle;
        }
        else    /* Duplication of descriptor */
        {
            CyBle_ApplCallback(CYBLE_EVT_GATTC_DESCR_DUPLICATION, &discDescrInfo->uuid);
        }
    }
}


/******************************************************************************
* Function Name: CyBle_BlscNotificationEventHandler
***************************************************************************//**
* 
*  Handles the Notification Event.
* 
*  \param eventParam: the pointer to a data structure specified by the event.
* 
******************************************************************************/
void CyBle_BlscNotificationEventHandler(CYBLE_GATTC_HANDLE_VALUE_NTF_PARAM_T *eventParam)
{
    if((NULL != CyBle_BlsApplCallback) && 
        (cyBle_blsc.charInfo[CYBLE_BLS_ICP].valueHandle == eventParam->handleValPair.attrHandle))
    {
        CYBLE_BLS_CHAR_VALUE_T locCharValue;
        locCharValue.connHandle = eventParam->connHandle;
        locCharValue.charIndex = CYBLE_BLS_ICP;
        locCharValue.value = &eventParam->handleValPair.value;
        
        cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
        CyBle_BlsApplCallback(CYBLE_EVT_BLSC_NOTIFICATION, &locCharValue);
    }
}


/******************************************************************************
* Function Name: CyBle_BlscIndicationEventHandler
***************************************************************************//**
* 
*  Handles the Indication Event.
* 
*  \param eventParam: the pointer to a data structure specified by the event.
* 
******************************************************************************/
void CyBle_BlscIndicationEventHandler(CYBLE_GATTC_HANDLE_VALUE_IND_PARAM_T *eventParam)
{
    if((NULL != CyBle_BlsApplCallback) &&
        (cyBle_blsc.charInfo[CYBLE_BLS_BPM].valueHandle == eventParam->handleValPair.attrHandle))
    {
        CYBLE_BLS_CHAR_VALUE_T locCharValue;
        locCharValue.charIndex = CYBLE_BLS_BPM;
        locCharValue.connHandle = eventParam->connHandle;
        locCharValue.value = &eventParam->handleValPair.value;
        
        cyBle_eventHandlerFlag &= (uint8) ~CYBLE_CALLBACK;
        CyBle_BlsApplCallback(CYBLE_EVT_BLSC_INDICATION, &locCharValue);
    }
}


/******************************************************************************
* Function Name: CyBle_BlscReadResponseEventHandler
***************************************************************************//**
* 
*  Handles the Read Response Event.
* 
*  \param CYBLE_GATTC_READ_RSP_PARAM_T *eventParam: the pointer to the data structure.
* 
******************************************************************************/
void CyBle_BlscReadResponseEventHandler(CYBLE_GATTC_READ_RSP_PARAM_T *eventParam)
{
    if((NULL != CyBle_BlsApplCallback) && (CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_blscReqHandle))
    {
        
        if(cyBle_blsc.charInfo[CYBLE_BLS_BPF].valueHandle == cyBle_blscReqHandle)
        {
            CYBLE_BLS_CHAR_VALUE_T locCharValue;
            
            locCharValue.connHandle = eventParam->connHandle;
            locCharValue.charIndex = CYBLE_BLS_BPF;
            locCharValue.value = &eventParam->value;
            
            cyBle_blscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
            cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
            CyBle_BlsApplCallback((uint32)CYBLE_EVT_BLSC_READ_CHAR_RESPONSE, &locCharValue);
        }
        else
        {
            CYBLE_BLS_CHAR_INDEX_T i;
            
            for(i = CYBLE_BLS_BPM; i < CYBLE_BLS_BPF; i++)
            {
                if(cyBle_blsc.charInfo[i].cccdHandle == cyBle_blscReqHandle)
                {
                    CYBLE_BLS_DESCR_VALUE_T locDescrValue;
                    
                    locDescrValue.connHandle = eventParam->connHandle;
                    locDescrValue.charIndex = i;
                    locDescrValue.descrIndex = CYBLE_BLS_CCCD;
                    locDescrValue.value = &eventParam->value;

                    cyBle_blscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
                    cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
                    CyBle_BlsApplCallback((uint32)CYBLE_EVT_BLSC_READ_DESCR_RESPONSE, &locDescrValue);
                    break;
                }
            }
        }
    }
}


/******************************************************************************
* Function Name: CyBle_BlscWriteResponseEventHandler
***************************************************************************//**
* 
*  Handles the Write Response Event.
* 
*  \param eventParam: the pointer to a data structure specified by the event.
* 
******************************************************************************/
void CyBle_BlscWriteResponseEventHandler(const CYBLE_CONN_HANDLE_T *eventParam)
{
    if((NULL != CyBle_BlsApplCallback) && (CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE != cyBle_blscReqHandle))
    {
        CYBLE_BLS_CHAR_INDEX_T i;
        
        for(i = CYBLE_BLS_BPM; i < CYBLE_BLS_BPF; i++)
        {
            if(cyBle_blsc.charInfo[i].cccdHandle == cyBle_blscReqHandle)
            {
                CYBLE_BLS_DESCR_VALUE_T locDescIndex;
                
                locDescIndex.connHandle = *eventParam;
                locDescIndex.charIndex = i;
                locDescIndex.descrIndex = CYBLE_BLS_CCCD;
                locDescIndex.value = NULL;

                cyBle_blscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
                cyBle_eventHandlerFlag &= (uint8)~CYBLE_CALLBACK;
                CyBle_BlsApplCallback((uint32)CYBLE_EVT_BLSC_WRITE_DESCR_RESPONSE, &locDescIndex);
                break;
            }
        }
    }
}


/******************************************************************************
* Function Name: CyBle_BlscErrorResponseEventHandler
***************************************************************************//**
* 
*  Handles the Error Response Event.
* 
*  \param eventParam: pointer to the data structure specified by the event.
* 
******************************************************************************/
void CyBle_BlscErrorResponseEventHandler(const CYBLE_GATTC_ERR_RSP_PARAM_T *eventParam)
{
    if((eventParam != NULL) && (eventParam->attrHandle == cyBle_blscReqHandle))
    {
        cyBle_blscReqHandle = CYBLE_GATT_INVALID_ATTR_HANDLE_VALUE;
    }
}


#endif /* CYBLE_BLS_CLIENT */


/* [] END OF FILE */
