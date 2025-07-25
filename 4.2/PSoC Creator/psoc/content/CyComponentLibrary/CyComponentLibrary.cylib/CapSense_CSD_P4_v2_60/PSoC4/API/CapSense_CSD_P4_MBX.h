/*******************************************************************************
* File Name: `$INSTANCE_NAME`_MBX.h
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides constants and structure declarations for the tuner
*  communication for the CapSense CSD component.
*
* Note:
*
********************************************************************************
* Copyright 2013-2016, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#if !defined(CY_CAPSENSE_CSD_MBX_`$INSTANCE_NAME`_H)
#define CY_CAPSENSE_CSD_MBX_`$INSTANCE_NAME`_H

#include "`$INSTANCE_NAME`.h"
#include "`$INSTANCE_NAME`_PVT.h"

#if(0u != `$INSTANCE_NAME`_CSHL_API_GENERATE)
    #include "`$INSTANCE_NAME`_CSHL.h"
#endif /* (0u != `$INSTANCE_NAME`_CSHL_API_GENERATE) */

#if(`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u)
    #include "`$INSTANCE_NAME`_GESTURE.h"
#endif /* (`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u) */
/***************************************
*   Condition compilation parameters
***************************************/
#if defined(__GNUC__) || defined(__ARMCC_VERSION)
    #define `$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC __attribute__ ((packed))
#else
    #define `$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC
#endif /* (defined(__GNUC__) || defined(__ARMCC_VERSION)) */

#if defined(__ICCARM__)
    #define `$INSTANCE_NAME`_PACKED_STRUCT_IAR __packed
#else
    #define `$INSTANCE_NAME`_PACKED_STRUCT_IAR
#endif /* (__ICCARM__) */

#if defined(__GNUC__)
    #define `$INSTANCE_NAME`_NO_STRICT_VOLATILE __attribute__((optimize("-fno-strict-volatile-bitfields")))
#else
    #define `$INSTANCE_NAME`_NO_STRICT_VOLATILE
#endif /* (defined(__GNUC__)) */


/***************************************
*           API Constants
***************************************/

/* Selected ID for this version of Tuner */
#define `$INSTANCE_NAME`_TYPE_ID                (0x04u)

#define `$INSTANCE_NAME`_BUSY_FLAG              (`$INSTANCE_NAME`_TYPE_ID | 0x80u)
#define `$INSTANCE_NAME`_HAVE_MSG               (sizeof(`$INSTANCE_NAME`_MAILBOX) | 0x8000u)

#define `$INSTANCE_NAME`_UPDATE_GESTURE_PARAMS  (`$INSTANCE_NAME`_MAX_UINT_8)

#define `$INSTANCE_NAME`_IS_ANY_GESTURES_EN     ((0u != `$INSTANCE_NAME`_CLICK_GEST_ENABLED) ||\
                                                 (0u != `$INSTANCE_NAME`_ZOOM_GEST_ENABLED)  ||\
                                                 (0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED)||\
                                                 (0u != `$INSTANCE_NAME`_DT_SCROLL_GEST_ENABLED)   ||\
                                                 (0u != `$INSTANCE_NAME`_FLICK_GEST_ENABLED) ||\
                                                 (0u != `$INSTANCE_NAME`_ROTATE_GEST_ENABLED)||\
                                                 (0u != `$INSTANCE_NAME`_EDGE_SWIPE_GEST_ENABLED))

#define `$INSTANCE_NAME`_MBX_TP_FILTERS_MASK    (`$INSTANCE_NAME`_XY_IIR_MASK |\
                                                 `$INSTANCE_NAME`_XY_JITTER_MASK |\
                                                 `$INSTANCE_NAME`_XY_BALLISTIC_MASK |\
                                                 `$INSTANCE_NAME`_XY_ADAPTIVE_IIR_MASK)

#define `$INSTANCE_NAME`_MBX_TP_IIR_COEF_MASK   (0x07u)

/* Check Sum to identify data */
#define `$INSTANCE_NAME`_CHECK_SUM      (`$CheckSum`u)
#define `$INSTANCE_NAME`_TOTAL_SENSOR_MASK_COUNT     (((`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT - 1u) / 8u) + 1u)

#define `$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT           (`$INSTANCE_NAME`_TOTAL_WIDGET_COUNT + \
                                                                 `$INSTANCE_NAME`_TOTAL_TOUCH_PADS_COUNT + \
                                                                 `$INSTANCE_NAME`_TOTAL_MATRIX_BUTTONS_COUNT)

#define `$INSTANCE_NAME`_WIDGET_RESOLUTION_PARAMETERS_COUNT     (`$INSTANCE_NAME`_WIDGET_CSHL_PARAMETERS_COUNT + \
                                                                 `$INSTANCE_NAME`_TOTAL_GENERICS_COUNT)


/***************************************
*      Type defines for mailboxes
***************************************/
typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
{
    uint16 apiResolution;

    `$SizeReplacementString` fingerThreshold;
    `$SizeReplacementString` noiseThreshold;
    `$SizeReplacementString` hysteresis;
    uint8 debounce;

    uint8 modulatorIDAC;
    #if (`$INSTANCE_NAME`_IDAC_CNT == 2u)
        uint8 compensationIDAC;
    #endif /* ( (`$INSTANCE_NAME`_IDAC_CNT == 2u) */

    uint8 analogSwitchDivider;
    uint8 modulatorDivider;
    uint8 idacRange;
    uint8 scanResolution;
}`$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_INBOX_CSD_CONFIG;

#if(`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u)
#if((0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK) || (0u != `$INSTANCE_NAME`_IS_ANY_GESTURES_EN))
    typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
    {
        #if(0u != `$INSTANCE_NAME`_CLICK_GEST_ENABLED)
            uint16 clickRadiusX;            /* Click X Radius Pixels */
            uint16 clickRadiusY;            /* Click Y Radius Pixels */
            uint16 doubleClickRadius;       /* Double click max radius */
            uint16 stDoubleClickTimeoutMax; /* Double click max timeout */
            uint16 stDoubleClickTimeoutMin; /* Double click min timeout */
            uint16 stClickTimeoutMax;       /* Single click max timeout */
            uint16 stClickTimeoutMin;       /* Single click min timeout */
            uint16 dtClickTimeoutMax;       /* Two finger click max timeout */
            uint16 dtClickTimeoutMin;       /* Two finger click min timeout */
        #endif /* (0u != `$INSTANCE_NAME`_CLICK_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_EDGE_SWIPE_GEST_ENABLED)
            uint16 edgeSwipeTime;          /* Edge Swipe Time */
            uint16 edgeSwipeCompleteTimeout;  /* Edge Swipe Complete Timeout */
            uint8  edgeSwipeActiveDistance; /* Active Edge Swipe threshold */
            uint8  bottomAngleThreshold;    /* Bottom angle threshold */
            uint8  topAngleThreshold;       /* Top angle threshold */
            uint8  widthOfDisambiguation;   /* Width of disambiguation region */
        #endif /* (0u != `$INSTANCE_NAME`_EDGE_SWIPE_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_ZOOM_GEST_ENABLED)
            uint8 dtPanToZoomDebounce;      /* Debounce Scroll to Zoom count */
            uint8 dtZoomDebounce;           /* Debounce Zoom count */
            uint8 zoomActiveDistanceX;      /* Zoom Active distance threshold X */
            uint8 zoomActiveDistanceY;      /* Zoom Active distance threshold Y */
        #endif /* (0u != `$INSTANCE_NAME`_ZOOM_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED)
            uint8 stScrThreshold1X;         /* One finger Scroll Threshold 1X */
            uint8 stScrThreshold2X;         /* One finger Scroll Threshold 2X */
            uint8 stScrThreshold3X;         /* One finger Scroll Threshold 3X */
            uint8 stScrThreshold4X;         /* One finger Scroll Threshold 4X */
            uint8 stScrThreshold1Y;         /* One finger Scroll Threshold 1Y; */
            uint8 stScrThreshold2Y;         /* One finger Scroll Threshold 2Y; */
            uint8 stScrThreshold3Y;         /* One finger Scroll Threshold 3Y; */
            uint8 stScrThreshold4Y;         /* One finger Scroll Threshold 4Y; */
            uint8 stScrStep1;               /* One finger Scroll Step 1 */
            uint8 stScrStep2;               /* One finger Scroll Step 2 */
            uint8 stScrStep3;               /* One finger Scroll Step 3 */
            uint8 stScrStep4;               /* One finger Scroll Step 4 */
            uint8 stScrDebounce;            /* One finger Scroll Debounce count */
            uint8 stInScrActiveDistanceX;   /* One finger Inertial scroll Active distance threshold X */
            uint8 stInScrActiveDistanceY;   /* One finger Inertial scroll Active distance threshold Y */
            uint8 stInScrCountLevel;        /* One finger Inertial scroll count level X */
        #endif /* (0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_DT_SCROLL_GEST_ENABLED)
            uint8 dtScrThreshold1X;         /* Two finger Scroll Threshold 1X */
            uint8 dtScrThreshold2X;         /* Two finger Scroll Threshold 2X */
            uint8 dtScrThreshold3X;         /* Two finger Scroll Threshold 3X */
            uint8 dtScrThreshold4X;         /* Two finger Scroll Threshold 4X */
            uint8 dtScrThreshold1Y;         /* Two finger Scroll Threshold 1Y; */
            uint8 dtScrThreshold2Y;         /* Two finger Scroll Threshold 2Y; */
            uint8 dtScrThreshold3Y;         /* Two finger Scroll Threshold 3Y; */
            uint8 dtScrThreshold4Y;         /* Two finger Scroll Threshold 4Y; */
            uint8 dtScrStep1;               /* Two finger Scroll Step 1 */
            uint8 dtScrStep2;               /* Two finger Scroll Step 2 */
            uint8 dtScrStep3;               /* Two finger Scroll Step 3 */
            uint8 dtScrStep4;               /* Two finger Scroll Step 4 */
            uint8 dtScrDebounce;            /* Two finger Scroll Debounce count */
            uint8 dtInScrActiveDistanceX;   /* Two finger Inertial scroll Active distance threshold X */
            uint8 dtInScrActiveDistanceY;   /* Two finger Inertial scroll Active distance threshold Y */
            uint8 dtInScrCountLevel;        /* Two finger Inertial scroll count level Y */
        #endif /* (0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_FLICK_GEST_ENABLED)
            uint16 flickSampleTime;         /* Flick Sample Time */
            uint8 flickActiveDistanceX;     /* Flick Active distance threshold X */
            uint8 flickActiveDistanceY;     /* Flick Active distance threshold Y */
        #endif /* (0u != `$INSTANCE_NAME`_FLICK_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_ROTATE_GEST_ENABLED)
            uint8 rotateDebounce;           /* Rotate debounce limit */
        #endif /* (0u != `$INSTANCE_NAME`_ROTATE_GEST_ENABLED) */

        #if(0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK)
            uint8 filtersMask;
        #endif /* (0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK) */

        #if(0u != (`$INSTANCE_NAME`_XY_ADAPTIVE_IIR_MASK & `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK))
            uint8 filterDivisor;
            uint8 largeMovThreshold;
            uint8 littleMovThreshold;
            uint8 maxFilterCoef;
            uint8 minFilterCoef;
            uint8 noMovThreshold;
        #endif /* (0u != (`$INSTANCE_NAME`_XY_ADAPTIVE_IIR_MASK & `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK)) */

    }`$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_INBOX_TMG_CONFIG;
#endif /* ((0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK) || (0u != `$INSTANCE_NAME`_IS_ANY_GESTURES_EN)) */
#endif /* (`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u) */

/* Outbox structure definition */
typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
{
    uint8 onMask[`$INSTANCE_NAME`_TOTAL_SENSOR_MASK];

    #if (0u != `$INSTANCE_NAME`_TOTAL_CENTROIDS_COUNT)
        uint16 centroidPosition[`$INSTANCE_NAME`_TOTAL_CENTROIDS_COUNT];
    #endif  /* (0u != `$INSTANCE_NAME`_TOTAL_CENTROIDS_COUNT) */

    #if (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT)
        uint8 fingersNum[`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT];
        uint8 gestureID[`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT];
        #if((0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED) || (0u != `$INSTANCE_NAME`_DT_SCROLL_GEST_ENABLED))
            uint8 scrollCnt;
        #endif /* ((0u != `$INSTANCE_NAME`_ST_SCROLL_GEST_ENABLED) || (0u != `$INSTANCE_NAME`_DT_SCROLL_GEST_ENABLED)) */
    #endif /* (0u != `$INSTANCE_NAME`_TOUCH_PADS_GESTURES_COUNT) */

    #if (0u != `$INSTANCE_NAME`_TOTAL_MATRIX_BUTTONS_COUNT)
        uint8 mbPosition[`$INSTANCE_NAME`_TOTAL_MATRIX_BUTTONS_COUNT * 2u];
    #endif /* (0u != `$INSTANCE_NAME`_TOTAL_MATRIX_BUTTONS_COUNT) */

    #if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO)
        `$SizeReplacementString` fingerThreshold[`$INSTANCE_NAME`_THRESHOLD_TBL_SIZE];
        `$SizeReplacementString` noiseThreshold[`$INSTANCE_NAME`_THRESHOLD_TBL_SIZE];
        `$SizeReplacementString` hysteresis[`$INSTANCE_NAME`_WIDGET_PARAM_TBL_SIZE];
    #endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO) */

    `$SizeReplacementString` sensorSignal[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
    uint16 rawData[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
    uint16 baseLine[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];

    #if((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
        (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL))
        uint8 noReadMessage;
    #endif /* ((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
               (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL)) */


    #if((`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO) || (0u != `$INSTANCE_NAME`_AUTOCALIBRATION_ENABLE))
        uint8 modulationIDAC[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
        #if (`$INSTANCE_NAME`_IDAC_CNT == 2u)
            uint8 compensationIDAC[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
        #endif /* (`$INSTANCE_NAME`_IDAC_CNT == 2u) */
    #endif /* ((`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO) || (0u != `$INSTANCE_NAME`_AUTOCALIBRATION_ENABLE)) */

    #if (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO)
        uint8 analogSwitchDivider[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];
        uint8 modulatorDivider[`$INSTANCE_NAME`_TOTAL_SENSOR_COUNT];

        uint8 scanResolution[`$INSTANCE_NAME`_RESOLUTIONS_TBL_SIZE];
    #endif  /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_AUTO) */

    uint16 checkSum;

} `$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_OUTBOX;


/* Inbox structure definition */
#if((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
    (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL))
    typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
    {
        uint8 sensorIndex;

        #if(`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL)
            `$INSTANCE_NAME`_INBOX_CSD_CONFIG `$INSTANCE_NAME`_inboxCsdCfg;
        #endif /* (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL) */

        #if(`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u)
        #if((0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK) || (0u != `$INSTANCE_NAME`_IS_ANY_GESTURES_EN))
            `$INSTANCE_NAME`_INBOX_TMG_CONFIG `$INSTANCE_NAME`_inboxTmgCfg;
        #endif /* ((0u != `$INSTANCE_NAME`_TRACKPAD_GEST_POS_FILTERS_MASK) || (0u != `$INSTANCE_NAME`_IS_ANY_GESTURES_EN)) */
        #endif /* (`$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT > 0u) */
    } `$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_INBOX;

#endif  /* ((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
            (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL)) */


/* Mailbox structure definition */
typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
{
    uint8   type;               /* Must be first byte with values ranging from 0-119 */
    uint16  size;               /* Must be size of this data structure. Range between 0-127 */
    `$INSTANCE_NAME`_OUTBOX  outbox;
    #if((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
        (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL))
        `$INSTANCE_NAME`_INBOX inbox;
    #endif  /* ((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
                (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL)) */
}`$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_MAILBOX;


/* Mailboxes structure definition */
typedef `$INSTANCE_NAME`_PACKED_STRUCT_IAR struct
{
    uint8   numMailBoxes;       /* This must always be first. Represents # of mailboxes */
    `$INSTANCE_NAME`_MAILBOX    csdMailbox;
}`$INSTANCE_NAME`_PACKED_STRUCT_GNUC_ARMCC `$INSTANCE_NAME`_MAILBOXES;


extern uint16 `$INSTANCE_NAME`_TMG_edgeSwipeCompleteTimeout;

/***************************************
*        Function Prototypes
***************************************/
`$INSTANCE_NAME`_NO_STRICT_VOLATILE void `$INSTANCE_NAME`_InitMailbox(volatile `$INSTANCE_NAME`_MAILBOX *mbx);
`$INSTANCE_NAME`_NO_STRICT_VOLATILE void `$INSTANCE_NAME`_PostMessage(volatile `$INSTANCE_NAME`_MAILBOX *mbx);

#if((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
     (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL))
    `$INSTANCE_NAME`_NO_STRICT_VOLATILE void `$INSTANCE_NAME`_ReadMessage(volatile `$INSTANCE_NAME`_MAILBOX *mbx);
#endif  /* ((`$INSTANCE_NAME`_TUNING_METHOD != `$INSTANCE_NAME`__TUNING_NONE) && (0u != `$INSTANCE_NAME`_TOTAL_TRACKPAD_GESTURES_COUNT) ||\
            (`$INSTANCE_NAME`_TUNING_METHOD == `$INSTANCE_NAME`__TUNING_MANUAL)) */


#endif  /* (CY_CAPSENSE_CSD_MBX_`$INSTANCE_NAME`_H) */


/* [] END OF FILE */
