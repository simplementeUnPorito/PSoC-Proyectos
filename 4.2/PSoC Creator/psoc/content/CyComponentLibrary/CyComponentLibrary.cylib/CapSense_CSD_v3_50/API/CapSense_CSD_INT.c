/*******************************************************************************
* File Name: `$INSTANCE_NAME`_INT.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code of Interrupt Service Routine (ISR)
*  for CapSense CSD component.
*
* Note:
*
********************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "`$INSTANCE_NAME`.h"
`$CY_API_CALLBACK_HEADER_INCLUDE`


/*******************************************************************************
*  Place your includes, defines and code here 
********************************************************************************/
/* `#START `$INSTANCE_NAME`_IsrCH_ISR_intc` */

/* `#END` */


#if (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_ONE_CHANNEL_DESIGN)
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_IsrCH0_ISR
    ********************************************************************************
    *
    * Summary:
    *  This ISR is executed when measure window is closed. The measure window 
    *  depends on scan resolution parameter of sensor. 
    *  The ISR has two modes: 
    *   1. Scans single sensor and stores measure result.
    *   2. Stores result of current measure and starts next scan till all 
    *      enabled sensors will be scanned.
    *  This interrupt handler only used in one channel designs.
    *
    * Parameters:
    *  None
    *
    * Return:
    *  None
    *
    * Global Variables:
    *  `$INSTANCE_NAME`_csv - used to provide status and mode of scanning process.
    *   Mode - single scan or scan of all enabled sensors.
    *   Status - scan in progress or ready for new scan.
    *  `$INSTANCE_NAME`_sensorIndex - used to store sensor scanning sensor number.
    *
    * Reentrant:
    *  No
    *
    *******************************************************************************/
    CY_ISR(`$INSTANCE_NAME`_IsrCH0_ISR)
    {
        #ifdef `$INSTANCE_NAME`_ONE_CHANNEL_CH0_ISR_ENTRY_CALLBACK
            `$INSTANCE_NAME`_IsrCH0_ISR_EntryCallback();
        #endif /* `$INSTANCE_NAME`_ONE_CHANNEL_CH0_ISR_ENTRY_CALLBACK */

        /*  Place your Interrupt code here. */
        /* `#START `$INSTANCE_NAME`_ONE_CHANNEL_IsrCH0_ISR_ENTER` */
    
        /* `#END` */

        /* Save results and disable sensor */
        `$INSTANCE_NAME`_PostScan(`$INSTANCE_NAME`_sensorIndex);
                
        if ((`$INSTANCE_NAME`_csv & `$INSTANCE_NAME`_SW_CTRL_SINGLE_SCAN) != 0u)
        {
            `$INSTANCE_NAME`_csv &= (uint8)~`$INSTANCE_NAME`_SW_STS_BUSY;
        }
        else
        {
            /* Proceed the scanning */
            `$INSTANCE_NAME`_sensorIndex = `$INSTANCE_NAME`_FindNextSensor(`$INSTANCE_NAME`_sensorIndex);
            
            /* Check end of scan */
            if(`$INSTANCE_NAME`_sensorIndex < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT)
            {
                `$INSTANCE_NAME`_PreScan(`$INSTANCE_NAME`_sensorIndex);
            }
            else
            {
                `$INSTANCE_NAME`_csv &= (uint8)~`$INSTANCE_NAME`_SW_STS_BUSY;
            } 
        }

        /*  Place your Interrupt code here. */
        /* `#START `$INSTANCE_NAME`_ONE_CHANNEL_IsrCH0_ISR_EXIT` */
    
        /* `#END` */

        #ifdef `$INSTANCE_NAME`_ONE_CHANNEL_CH0_ISR_EXIT_CALLBACK
            `$INSTANCE_NAME`_IsrCH0_ISR_ExitCallback();
        #endif /* `$INSTANCE_NAME`_ONE_CHANNEL_CH0_ISR_EXIT_CALLBACK */
    }
 #endif  /* (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_ONE_CHANNEL_DESIGN) */


 #if (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN)   
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_IsrCH0_ISR
    ********************************************************************************
    *
    * Summary:
    *  This ISR is executed when measure window is closed. The measure window 
    *  depends on scan resolution parameter of sensor. 
    *  The ISR has two modes: 
    *   1. Scans single sensor or pair of sensors and stores measure result.
    *   2. Stores results of current measure when complete scan of sensors pair or 
    *      sensor scan and starts next enabled sensors pair or sensor scan. 
    *  This interrupt handler only used in two channel designs.
    *  The synchronization is added to scanning process. The ISR channel 0 or 
    *  channel 1 stores the result and starts next scan. It depends which channel
    *  scans longer. The biggest scan resolution parameter of sensor within pair 
    *  defines scanning time of pair.
    *
    * Parameters:
    *  None
    *
    * Return:
    *  None
    *
    * Global Variables:
    *  `$INSTANCE_NAME`_csv - used to provide status and mode of scanning process.
    *   Mode - single scan or scan of all enabled sensors.
    *   Status - scan in progress or ready for new scan.
    *  `$INSTANCE_NAME`_sensorIndex - used to store sensor scanning sensor number.
    *
    * Reentrant:
    *  No
    *
    *******************************************************************************/
    CY_ISR(`$INSTANCE_NAME`_IsrCH0_ISR)
    {
        #ifdef `$INSTANCE_NAME`_TWO_CHANNEL_CH0_ISR_ENTRY_CALLBACK
            `$INSTANCE_NAME`_IsrCH0_ISR_EntryCallback();
        #endif /* `$INSTANCE_NAME`_TWO_CHANNEL_CH0_ISR_ENTRY_CALLBACK */

        /*  Place your Interrupt code here. */
        /* `#START `$INSTANCE_NAME`_TWO_CHANNELS_IsrCH0_ISR_ENTER` */
    
        /* `#END` */
        
        `$INSTANCE_NAME`_CONTROL_REG &= ~`$INSTANCE_NAME`_CTRL_WINDOW_EN__CH0;
        `$INSTANCE_NAME`_PostScanCh0(`$INSTANCE_NAME`_sensorIndex);
        
        if((`$INSTANCE_NAME`_CONTROL_REG & `$INSTANCE_NAME`_CTRL_WINDOW_EN__CH1) == 0u)
        {
            if ((`$INSTANCE_NAME`_csv & `$INSTANCE_NAME`_SW_CTRL_SINGLE_SCAN) != 0u)
            {
                `$INSTANCE_NAME`_csv &= (uint8)~`$INSTANCE_NAME`_SW_STS_BUSY;
            }
            else
            {
                /* Procced the scanning */
                `$INSTANCE_NAME`_sensorIndex = `$INSTANCE_NAME`_FindNextPair(`$INSTANCE_NAME`_sensorIndex);
                
                /* Check end of scan conditions */
                if((`$INSTANCE_NAME`_sensorIndex < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0) || 
                   (`$INSTANCE_NAME`_sensorIndex < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH1))
                {
                    `$INSTANCE_NAME`_PreScan(`$INSTANCE_NAME`_sensorIndex);
                }
                else
                {
                    `$INSTANCE_NAME`_csv &= (uint8)~`$INSTANCE_NAME`_SW_STS_BUSY;
                }
            }
        }
        else
        {
            /* Do nothing */
        }

		/*  Place your Interrupt code here. */
        /* `#START `$INSTANCE_NAME`_TWO_CHANNELS_IsrCH0_ISR_EXIT` */
    
        /* `#END` */

        #ifdef `$INSTANCE_NAME`_TWO_CHANNEL_CH0_ISR_EXIT_CALLBACK
            `$INSTANCE_NAME`_IsrCH0_ISR_ExitCallback();
        #endif /* `$INSTANCE_NAME`_TWO_CHANNEL_CH0_ISR_EXIT_CALLBACK */
    }

    
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_IsrCH1_ISR
    ********************************************************************************
    *
    * Summary:
    *  This ISR is executed when measure window is closed. The measure window 
    *  depends on scan resolution parameter of sensor. 
    *  The ISR has two modes: 
    *   1. Scans single sensor or pair of sensors and stores measure result.
    *   2. Stores results of current measure when complete scan of sensors pair or 
    *      sensor scan and starts next enabled sensors pair or sensor scan. 
    *  This interrupt handler only used in two channel designs.
    *  The synchronization is added to scanning process. The ISR channel 0 or 
    *  channel 1 stores the result and starts next scan. It depends which channel
    *  scans longer. The biggest scan resolution parameter of sensor within pair 
    *  defines scanning time of pair.
    *
    * Parameters:
    *  None
    *
    * Return:
    *  None
    *
    * Global Variables:
    *  `$INSTANCE_NAME`_csv - used to provide status and mode of scanning process.
    *   Mode - single scan or scan of all enabled sensors.
    *   Status - scan in progress or ready for new scan.
    *  `$INSTANCE_NAME`_sensorIndex - used to store sensor scanning sensor number.
    *
    * Reentrant:
    *  No
    *
    *******************************************************************************/
    CY_ISR(`$INSTANCE_NAME`_IsrCH1_ISR)
    {
        #ifdef `$INSTANCE_NAME`_TWO_CHANNEL_CH1_ISR_ENTRY_CALLBACK
            `$INSTANCE_NAME`_IsrCH1_ISR_EntryCallback();
        #endif /* `$INSTANCE_NAME`_TWO_CHANNEL_CH1_ISR_ENTRY_CALLBACK */

        /*  Place your Interrupt code here */
        /* `#START `$INSTANCE_NAME`_TWO_CHANNELS_IsrCH1_ISR_ENTER` */
    
        /* `#END` */
        
        `$INSTANCE_NAME`_CONTROL_REG &= (uint8)~`$INSTANCE_NAME`_CTRL_WINDOW_EN__CH1;
        `$INSTANCE_NAME`_PostScanCh1(`$INSTANCE_NAME`_sensorIndex + `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0);
        
        if((`$INSTANCE_NAME`_CONTROL_REG & `$INSTANCE_NAME`_CTRL_WINDOW_EN__CH0) == 0u)
        {
            if ((`$INSTANCE_NAME`_csv & `$INSTANCE_NAME`_SW_CTRL_SINGLE_SCAN) != 0u)
            {
                `$INSTANCE_NAME`_csv &= (uint8)~`$INSTANCE_NAME`_SW_STS_BUSY;
            }
            else 
            {
                /* Procced the scanning */
                `$INSTANCE_NAME`_sensorIndex = `$INSTANCE_NAME`_FindNextPair(`$INSTANCE_NAME`_sensorIndex);
                
                /* Check end of scan conditions */
                if((`$INSTANCE_NAME`_sensorIndex < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH0) || 
                   (`$INSTANCE_NAME`_sensorIndex < `$INSTANCE_NAME`_TOTAL_SENSOR_COUNT__CH1))
                {
                    `$INSTANCE_NAME`_PreScan(`$INSTANCE_NAME`_sensorIndex);
                }
                else
                {
                    `$INSTANCE_NAME`_csv &= ~`$INSTANCE_NAME`_SW_STS_BUSY;
                }
            }
        }
        else
        {
            /* Do nothing */
        }

		/*  Place your Interrupt code here */
        /* `#START `$INSTANCE_NAME`_TWO_CHANNELS_IsrCH1_ISR_EXIT` */
    
        /* `#END` */

        #ifdef `$INSTANCE_NAME`_TWO_CHANNEL_CH1_ISR_EXIT_CALLBACK
            `$INSTANCE_NAME`_IsrCH1_ISR_ExitCallback();
        #endif /* `$INSTANCE_NAME`_TWO_CHANNEL_CH1_ISR_EXIT_CALLBACK */
    }
#endif  /* (`$INSTANCE_NAME`_DESIGN_TYPE == `$INSTANCE_NAME`_TWO_CHANNELS_DESIGN) */


/* [] END OF FILE */
