/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the source code to the API for the PRS component
*
* Note:
*  None
*
********************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
*******************************************************************************/

#include "`$INSTANCE_NAME`.h"

uint8 `$INSTANCE_NAME`_initVar = 0u;

`$INSTANCE_NAME`_BACKUP_STRUCT `$INSTANCE_NAME`_backup =
{
    0x00u, /* enableState; */

    #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
        /* Save dff register for time mult */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
            `$INSTANCE_NAME`_INIT_STATE, /* dffStatus; */
        #endif  /* End `$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE */

        /* Save A0 and A1 registers are none-retention */
        #if(`$INSTANCE_NAME`_PRS_SIZE <= 32u)
            `$INSTANCE_NAME`_DEFAULT_SEED, /* seed */

        #else
            `$INSTANCE_NAME`_DEFAULT_SEED_UPPER, /* seedUpper; */
            `$INSTANCE_NAME`_DEFAULT_SEED_LOWER, /* seedLower; */

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

    #endif  /* End (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
};


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Init
********************************************************************************
*
* Summary:
*  Initializes seed and polynomial registers with initial values.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Init(void) `=ReentrantKeil($INSTANCE_NAME . "_Init")`
{
    /* Writes seed value and ponynom value provided for customizer */
    #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u)
        `$INSTANCE_NAME`_WritePolynomial(`$INSTANCE_NAME`_DEFAULT_POLYNOM);
        `$INSTANCE_NAME`_WriteSeed(`$INSTANCE_NAME`_DEFAULT_SEED);
        #if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
            `$INSTANCE_NAME`_ResetSeedInit(`$INSTANCE_NAME`_DEFAULT_SEED);
        #endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */
            `$INSTANCE_NAME`_Enable();
    #else
        `$INSTANCE_NAME`_WritePolynomialUpper(`$INSTANCE_NAME`_DEFAULT_POLYNOM_UPPER);
        `$INSTANCE_NAME`_WritePolynomialLower(`$INSTANCE_NAME`_DEFAULT_POLYNOM_LOWER);
        `$INSTANCE_NAME`_WriteSeedUpper(`$INSTANCE_NAME`_DEFAULT_SEED_UPPER);
        `$INSTANCE_NAME`_WriteSeedLower(`$INSTANCE_NAME`_DEFAULT_SEED_LOWER);
        #if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
            `$INSTANCE_NAME`_ResetSeedInitUpper(`$INSTANCE_NAME`_DEFAULT_SEED_UPPER);
            `$INSTANCE_NAME`_ResetSeedInitLower(`$INSTANCE_NAME`_DEFAULT_SEED_LOWER);
        #endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */
            `$INSTANCE_NAME`_Enable();
    #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Enable
********************************************************************************
*
* Summary:
*  Starts PRS computation on rising edge of input clock.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Enable(void) `=ReentrantKeil($INSTANCE_NAME . "_Enable")`
{
        `$INSTANCE_NAME`_CONTROL_REG |= `$INSTANCE_NAME`_CTRL_ENABLE;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Start
********************************************************************************
*
* Summary:
*  Initializes seed and polynomial registers with initial values. Computation
*  of PRS starts on rising edge of input clock.
*
* Parameters:
*  void
*
* Return:
*  void
*
* Global variables:
*  `$INSTANCE_NAME`_initVar: global variable is used to indicate initial
*  configuration of this component.  The variable is initialized to zero and set
*  to 1 the first time `$INSTANCE_NAME`_Start() is called. This allows
*  enable/disable component without re-initialization in all subsequent calls
*  to the `$INSTANCE_NAME`_Start() routine.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`
{
    /* Writes seed value and ponynom value provided from customizer */
    if (`$INSTANCE_NAME`_initVar == 0u)
    {
        `$INSTANCE_NAME`_Init();
        `$INSTANCE_NAME`_initVar = 1u;
    }

    `$INSTANCE_NAME`_Enable();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Stop
********************************************************************************
*
* Summary:
*  Stops PRS computation.
*
* Parameters:
*  void
*
* Return:
*  void
*
*******************************************************************************/
void `$INSTANCE_NAME`_Stop(void) `=ReentrantKeil($INSTANCE_NAME . "_Stop")`
{
    `$INSTANCE_NAME`_CONTROL_REG &= ((uint8)~`$INSTANCE_NAME`_CTRL_ENABLE);
}


#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__APISINGLESTEP)
    /*******************************************************************************
    * FUNCTION NAME: `$INSTANCE_NAME`_Step
    ********************************************************************************
    *
    * Summary:
    *  Increments the PRS by one when API single step mode is used.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  void
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_Step(void) `=ReentrantKeil($INSTANCE_NAME . "_Step")`
    {
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
            /* Makes 4 pulse, 4x for Time Mult */
            `$INSTANCE_NAME`_EXECUTE_STEP;
            `$INSTANCE_NAME`_EXECUTE_STEP;
            `$INSTANCE_NAME`_EXECUTE_STEP;
            `$INSTANCE_NAME`_EXECUTE_STEP;

        #else
            /* One pulse without Time mult required */
            `$INSTANCE_NAME`_EXECUTE_STEP;

        #endif  /* End `$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE */
    }
#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__APISINGLESTEP) */


#if (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED)
    #if (`$INSTANCE_NAME`_PRS_SIZE <= 32u) /* 8-32 bits PRS */
        /*******************************************************************************
        * FUNCTION NAME: `$INSTANCE_NAME`_ResetSeedInit
        ********************************************************************************
        *
        * Summary:
        *  Increments the PRS by one when API single step mode is used.
        *
        * Parameters:
        *  void
        *
        * Return:
        *  void
        *
        *******************************************************************************/
        void `$INSTANCE_NAME`_ResetSeedInit(`$RegSizeReplacementString` seed)
                                            `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInit")`
        {
            uint8 enableInterrupts;

            /* Mask the Seed to cut unused bits */
            seed &= `$INSTANCE_NAME`_MASK;

            /* Change AuxControl reg, need to be safety */
            enableInterrupts = CyEnterCriticalSection();

            #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)
                /* Set FIFOs to single register */
                `$INSTANCE_NAME`_AUX_CONTROL_A_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

                #if(`$INSTANCE_NAME`_PRS_SIZE > 16u)       /* 17-32 bits PRS */
                    `$INSTANCE_NAME`_AUX_CONTROL_B_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */

                /* AuxControl reg settings are done */
                CyExitCriticalSection(enableInterrupts);

                /* Write Seed COPY */
                #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)          /* 16 bits PRS */
                    `$INSTANCE_NAME`_SEED_COPY_A__A1_REG = HI8(seed);
                    `$INSTANCE_NAME`_SEED_COPY_A__A0_REG = LO8(seed);

                #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)        /* 24 bits PRS */
                    `$INSTANCE_NAME`_SEED_COPY_B__A1_REG = LO8(HI16(seed));
                    `$INSTANCE_NAME`_SEED_COPY_B__A0_REG = HI8(seed);
                    `$INSTANCE_NAME`_SEED_COPY_A__A0_REG = LO8(seed);

                #else                                           /* 32 bits PRS */
                    `$INSTANCE_NAME`_SEED_COPY_B__A1_REG = HI8(HI16(seed));
                    `$INSTANCE_NAME`_SEED_COPY_A__A1_REG = LO8(HI16(seed));
                    `$INSTANCE_NAME`_SEED_COPY_B__A0_REG = HI8(seed);
                    `$INSTANCE_NAME`_SEED_COPY_A__A0_REG = LO8(seed);
                #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

            #else
                /* Set FIFOs to single register */
                #if (`$INSTANCE_NAME`_PRS_SIZE <= 8u)      /* 8 bits PRS */
                    `$INSTANCE_NAME`_AUX_CONTROL_A_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

                #elif (`$INSTANCE_NAME`_PRS_SIZE <= 16u)      /* 16 bits PRS */
                    `$INSTANCE_NAME`_AUX_CONTROL_A_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_B_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

                #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)      /* 24-39 bits PRS */
                    `$INSTANCE_NAME`_AUX_CONTROL_A_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_B_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_C_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

                #elif (`$INSTANCE_NAME`_PRS_SIZE <= 32u)      /* 40-55 bits PRS */
                    `$INSTANCE_NAME`_AUX_CONTROL_A_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_B_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_C_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
                    `$INSTANCE_NAME`_AUX_CONTROL_D_REG  |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

                #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */

                /* AuxControl reg setting are done */
                CyExitCriticalSection(enableInterrupts);

                /* Write Seed COPY */
                `$CySetRegReplacementString`(`$INSTANCE_NAME`_SEED_COPY_PTR, seed);

            #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
        }

    #else

        /*******************************************************************************
        * FUNCTION NAME: `$INSTANCE_NAME`_ResetSeedInitUpper
        ********************************************************************************
        *
        * Summary:
        *  Increments the PRS by one when API single step mode is used.
        *
        * Parameters:
        *  void
        *
        * Return:
        *  void
        *
        *******************************************************************************/
        void `$INSTANCE_NAME`_ResetSeedInitUpper(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInitUpper")`
        {
			uint8 enableInterrupts;

			/* Mask the Seed Upper half to cut unused bits */
            seed &= `$INSTANCE_NAME`_MASK;

			/* Change AuxControl reg, need to be safety */
            enableInterrupts = CyEnterCriticalSection();

            /* Set FIFOs to single register */
            `$INSTANCE_NAME`_AUX_CONTROL_A_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
            `$INSTANCE_NAME`_AUX_CONTROL_B_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
            `$INSTANCE_NAME`_AUX_CONTROL_C_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;

			#if (`$INSTANCE_NAME`_PRS_SIZE > 48u)               /* 49-64 bits PRS */
                `$INSTANCE_NAME`_AUX_CONTROL_D_REG |= `$INSTANCE_NAME`_AUXCTRL_FIFO_SINGLE_REG;
            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */

            /* AuxControl reg settings are done */
            CyExitCriticalSection(enableInterrupts);

            /* Write Seed Upper COPY */
            #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
                `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG = LO8(seed);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
                `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG = LO8(seed);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)        /* 56 bits PRS */
                `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG = HI8(seed);

            #else                                           /* 64 bits PRS */
                `$INSTANCE_NAME`_SEED_UPPER_COPY_D__A1_REG = HI8(HI16(seed));
                `$INSTANCE_NAME`_SEED_UPPER_COPY_C__A1_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_UPPER_COPY_B__A1_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_UPPER_COPY_A__A1_REG = LO8(seed);

            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
        }


        /*******************************************************************************
        * FUNCTION NAME: `$INSTANCE_NAME`_ResetSeedInitLower
        ********************************************************************************
        *
        * Summary:
        *  Increments the PRS by one when API single step mode is used.
        *
        * Parameters:
        *  void
        *
        * Return:
        *  void
        *
        *******************************************************************************/
        void `$INSTANCE_NAME`_ResetSeedInitLower(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_ResetSeedInitLower")`
        {
            /* Write Seed Lower COPY */
            #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
                `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A1_REG = HI8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG = LO8(seed);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
                `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A1_REG = HI8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG = LO8(seed);

            #else                                           /* 64 bits PRS */
                `$INSTANCE_NAME`_SEED_LOWER_COPY_D__A0_REG = HI8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_C__A0_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_LOWER_COPY_B__A0_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_LOWER_COPY_A__A0_REG = LO8(seed);

            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */
        }

    #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

#endif  /* End (`$INSTANCE_NAME`_RUN_MODE == `$INSTANCE_NAME`__CLOCKED) */


#if(`$INSTANCE_NAME`_PRS_SIZE <= 32u) /* 8-32 bits PRS */
    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_Read
    ********************************************************************************
    *
    * Summary:
    *  Reads PRS value.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns PRS value.
    *
    * Side Effects:
    *  The seed value is cut according to mask = 2^(Resolution) - 1.
    *  For example if PRS Resolution is 14 bits the mask value is:
    *  mask = 2^(14) - 1 = 0x3FFFu.
    *  The seed value = 0xFFFFu is cut:
    *  seed & mask = 0xFFFFu & 0x3FFFu = 0x3FFFu.
    *
    *******************************************************************************/
    `$RegSizeReplacementString` `$INSTANCE_NAME`_Read(void) `=ReentrantKeil($INSTANCE_NAME . "_Read")`
    {
        /* Read PRS */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)

            `$RegSizeReplacementString` seed;

            #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)          /* 16 bits PRS */
                seed = ((uint16) `$INSTANCE_NAME`_SEED_A__A1_REG) << 8u;
                seed |= `$INSTANCE_NAME`_SEED_A__A0_REG;

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)        /* 24 bits PRS */
                seed = ((uint32) (`$INSTANCE_NAME`_SEED_B__A1_REG)) << 16u;
                seed |= ((uint32) (`$INSTANCE_NAME`_SEED_B__A0_REG)) << 8u;
                seed |= `$INSTANCE_NAME`_SEED_A__A0_REG;

            #else                                           /* 32 bits PRS */
                seed = ((uint32) `$INSTANCE_NAME`_SEED_B__A1_REG) << 24u;
                seed |= ((uint32) `$INSTANCE_NAME`_SEED_A__A1_REG) << 16u;
                seed |= ((uint32) `$INSTANCE_NAME`_SEED_B__A0_REG) << 8u;
                seed |= `$INSTANCE_NAME`_SEED_A__A0_REG;

            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 8u) */

            return (seed  & `$INSTANCE_NAME`_MASK);

        #else

            return (`$CyGetRegReplacementString`(`$INSTANCE_NAME`_SEED_PTR) & `$INSTANCE_NAME`_MASK);

        #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WriteSeed
    ********************************************************************************
    *
    * Summary:
    *  Writes seed value.
    *
    * Parameters:
    *  seed:  Seed value.
    *
    * Return:
    *  void
    *
    * Side Effects:
    *  The seed value is cut according to mask = 2^(Resolution) - 1.
    *  For example if PRS Resolution is 14 bits the mask value is:
    *  mask = 2^(14) - 1 = 0x3FFFu.
    *  The seed value = 0xFFFFu is cut:
    *  seed & mask = 0xFFFFu & 0x3FFFu = 0x3FFFu.
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WriteSeed(`$RegSizeReplacementString` seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeed")`
    {
        /* Masks the Seed to cut unused bits */
        seed &= `$INSTANCE_NAME`_MASK;

        /* Writes Seed */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)

            #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)          /* 16 bits PRS */
                `$INSTANCE_NAME`_SEED_A__A1_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_A__A0_REG = LO8(seed);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)        /* 24 bits PRS */
                `$INSTANCE_NAME`_SEED_B__A1_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_B__A0_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_A__A0_REG = LO8(seed);

            #else                                           /* 32 bits PRS */
                `$INSTANCE_NAME`_SEED_B__A1_REG = HI8(HI16(seed));
                `$INSTANCE_NAME`_SEED_A__A1_REG = LO8(HI16(seed));
                `$INSTANCE_NAME`_SEED_B__A0_REG = HI8(seed);
                `$INSTANCE_NAME`_SEED_A__A0_REG = LO8(seed);
            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

            /* Resets triggers */
            #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
                if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
                {
                    `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
                }
            #else
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */

        #else

            `$CySetRegReplacementString`(`$INSTANCE_NAME`_SEED_PTR, seed);

        #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_ReadPolynomial
    ********************************************************************************
    *
    * Summary:
    *  Reads PRS polynomial value.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns PRS polynomial value.
    *
    *******************************************************************************/
    `$RegSizeReplacementString` `$INSTANCE_NAME`_ReadPolynomial(void)
                                `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomial")`
    {
        /* Reads polynomial */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)

            `$RegSizeReplacementString` polynomial;

            #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)          /* 16 bits PRS */
                polynomial = ((uint16) `$INSTANCE_NAME`_POLYNOM_A__D1_REG) << 8u;
                polynomial |= (`$INSTANCE_NAME`_POLYNOM_A__D0_REG);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)        /* 24 bits PRS */
                polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_B__D1_REG) << 16u;
                polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_B__D0_REG) << 8u;
                polynomial |= `$INSTANCE_NAME`_POLYNOM_A__D0_REG;

            #else                                           /* 32 bits PRS */
                polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_B__D1_REG) << 24u;
                polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_A__D1_REG) << 16u;
                polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_B__D0_REG) << 8u;
                polynomial |= `$INSTANCE_NAME`_POLYNOM_A__D0_REG;

            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

            return polynomial;

        #else

            return `$CyGetRegReplacementString`(`$INSTANCE_NAME`_POLYNOM_PTR);

        #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WritePolynomial
    ********************************************************************************
    *
    * Summary:
    *  Writes PRS polynomial value.
    *
    * Parameters:
    *  polynomial:  PRS polynomial.
    *
    * Return:
    *  void
    *
    * Side Effects:
    *  The polynomial value is cut according to mask = 2^(Resolution) - 1.
    *  For example if PRS Resolution is 14 bits the mask value is:
    *  mask = 2^(14) - 1 = 0x3FFFu.
    *  The polynomial value = 0xFFFFu is cut:
    *  polynomial & mask = 0xFFFFu & 0x3FFFu = 0x3FFFu.
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WritePolynomial(`$RegSizeReplacementString` polynomial)
                                          `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomial")`
    {
        /* Mask polynomial to cut unused bits */
        polynomial &= `$INSTANCE_NAME`_MASK;

        /* Write polynomial */
        #if (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE)

            #if (`$INSTANCE_NAME`_PRS_SIZE <= 16u)          /* 16 bits PRS */

                `$INSTANCE_NAME`_POLYNOM_A__D1_REG = HI8(polynomial);
                `$INSTANCE_NAME`_POLYNOM_A__D0_REG = LO8(polynomial);

            #elif (`$INSTANCE_NAME`_PRS_SIZE <= 24u)        /* 24 bits PRS */
                `$INSTANCE_NAME`_POLYNOM_B__D1_REG = LO8(HI16(polynomial));
                `$INSTANCE_NAME`_POLYNOM_B__D0_REG = HI8(polynomial);
                `$INSTANCE_NAME`_POLYNOM_A__D0_REG = LO8(polynomial);

            #else                                           /* 32 bits PRS */
                `$INSTANCE_NAME`_POLYNOM_B__D1_REG = HI8(HI16(polynomial));
                `$INSTANCE_NAME`_POLYNOM_A__D1_REG = LO8(HI16(polynomial));
                `$INSTANCE_NAME`_POLYNOM_B__D0_REG = HI8(polynomial);
                `$INSTANCE_NAME`_POLYNOM_A__D0_REG = LO8(polynomial);

            #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

            /* Resets triggers */
            #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
                if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
                {
                    `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
                }
            #else
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */

        #else

            `$CySetRegReplacementString`(`$INSTANCE_NAME`_POLYNOM_PTR, polynomial);

        #endif  /* End (`$INSTANCE_NAME`_TIME_MULTIPLEXING_ENABLE) */
    }

#else   /* 33-64 bits PRS */

    /*******************************************************************************
    *  Function Name: `$INSTANCE_NAME`_ReadUpper
    ********************************************************************************
    *
    * Summary:
    *  Reads upper half of PRS value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns upper half of PRS value.
    *
    * Side Effects:
    *  The upper half of seed value is cut according to
    *  mask = 2^(Resolution - 32) - 1.
    *  For example if PRS Resolution is 35 bits the mask value is:
    *  2^(35 - 32) - 1 = 2^(3) - 1 = 0x0000 0007u.
    *  The upper half of seed value = 0x0000 00FFu is cut:
    *  upper half of seed & mask = 0x0000 00FFu & 0x0000 0007u = 0x0000 0007u.
    *
    *******************************************************************************/
    uint32 `$INSTANCE_NAME`_ReadUpper(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadUpper")`
    {
        uint32 seed;

        /* Read PRS Upper */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            seed = `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)        /* 56 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG) << 16u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG;

        #else                                           /* 64 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG) << 24u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG) << 16u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_UPPER_A__A1_REG;

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        return (seed & `$INSTANCE_NAME`_MASK);
    }


    /*******************************************************************************
    *  Function Name: `$INSTANCE_NAME`_ReadLower
    ********************************************************************************
    *
    * Summary:
    *  Reads lower half of PRS value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns lower half of PRS value.
    *
    *******************************************************************************/
    uint32 `$INSTANCE_NAME`_ReadLower(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadLower")`
    {
        uint32 seed;

        /* Read PRS Lower */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_LOWER_B__A1_REG) << 24u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG) << 16u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_LOWER_A__A1_REG) << 24u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG) << 16u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG;

        #else                                           /* 64 bits PRS */
            seed = ((uint32) `$INSTANCE_NAME`_SEED_LOWER_D__A0_REG) << 24u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG) << 16u;
            seed |= ((uint32) `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG) << 8u;
            seed |= `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG;

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        return seed;
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WriteSeedUpper
    ********************************************************************************
    *
    * Summary:
    *  Writes upper half of seed value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  seed:  Upper half of seed value.
    *
    * Return:
    *  void
    *
    * Side Effects:
    *  The upper half of seed value is cut according to
    *  mask = 2^(Resolution - 32) - 1.
    *  For example if PRS Resolution is 35 bits the mask value is:
    *  2^(35 - 32) - 1 = 2^(3) - 1 = 0x0000 0007u.
    *  The upper half of seed value = 0x0000 00FFu is cut:
    *  upper half of seed & mask = 0x0000 00FFu & 0x0000 0007u = 0x0000 0007u.
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WriteSeedUpper(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeedUpper")`
    {
        /* Mask the Seed Upper half to cut unused bits */
        seed &= `$INSTANCE_NAME`_MASK;

        /* Write Seed Upper */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG = LO8(seed);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG = LO8(seed);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)        /* 56 bits PRS */
            `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG = LO8(HI16(seed));
            `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG = HI8(seed);

        #else                                           /* 64 bits PRS */
            `$INSTANCE_NAME`_SEED_UPPER_D__A1_REG = HI8(HI16(seed));
            `$INSTANCE_NAME`_SEED_UPPER_C__A1_REG = LO8(HI16(seed));
            `$INSTANCE_NAME`_SEED_UPPER_B__A1_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_UPPER_A__A1_REG = LO8(seed);

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        /* Resets triggers */
        #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
            if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
            {
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            }
        #else
            `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
        #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WriteSeedLower
    ********************************************************************************
    *
    * Summary:
    *  Writes lower half of seed value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  seed:  Lower half of seed value.
    *
    * Return:
    *  void
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WriteSeedLower(uint32 seed) `=ReentrantKeil($INSTANCE_NAME . "_WriteSeedLower")`
    {
        /* Write Seed Lower */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            `$INSTANCE_NAME`_SEED_LOWER_B__A1_REG = HI8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG = LO8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG = LO8(seed);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            `$INSTANCE_NAME`_SEED_LOWER_A__A1_REG = HI8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG = LO8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG = LO8(seed);

        #else                                           /* 64 bits PRS */
            `$INSTANCE_NAME`_SEED_LOWER_D__A0_REG = HI8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_C__A0_REG = LO8(HI16(seed));
            `$INSTANCE_NAME`_SEED_LOWER_B__A0_REG = HI8(seed);
            `$INSTANCE_NAME`_SEED_LOWER_A__A0_REG = LO8(seed);

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        /* Resets triggers */
        #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
            if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
            {
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            }
        #else
            `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
        #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_ReadPolynomialUpper
    ********************************************************************************
    *
    * Summary:
    *  Reads upper half of PRS polynomial value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns upper half of PRS polynomial value.
    *
    *******************************************************************************/
    uint32 `$INSTANCE_NAME`_ReadPolynomialUpper(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomialUpper")`
    {
        uint32 polynomial;

        /* Read Polynomial Upper */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            polynomial = `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)        /* 56 bits PRS */
            polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG) << 16u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG;

        #else                                           /* 64 bits PRS */
            polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG) << 24u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG) << 16u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_UPPER_A__D1_REG;

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        return polynomial;
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_ReadPolynomialLower
    ********************************************************************************
    *
    * Summary:
    *  Reads lower half of PRS polynomial value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  void
    *
    * Return:
    *  Returns lower half of PRS polynomial value.
    *
    *******************************************************************************/
    uint32 `$INSTANCE_NAME`_ReadPolynomialLower(void) `=ReentrantKeil($INSTANCE_NAME . "_ReadPolynomialLower")`
    {
        uint32 polynomial;

        /* Read Polynomial Lower */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            polynomial = ( (uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_B__D1_REG) << 24u;
            polynomial |= ( (uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG) << 16u;
            polynomial |= ( (uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG;

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_A__D1_REG) << 24u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG) << 16u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG;

        #else                                           /* 64 bits PRS */
            polynomial = ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_REG) << 24u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG) << 16u;
            polynomial |= ((uint32) `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG) << 8u;
            polynomial |= `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG;

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        return polynomial;
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WritePolynomialUpper
    ********************************************************************************
    *
    * Summary:
    *  Writes upper half of PRS polynomial value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  polynomial:  Upper half PRS polynomial value.
    *
    * Return:
    *  void
    *
    * Side Effects:
    *  The upper half of polynomial value is cut according to
    *  mask = 2^(Resolution - 32) - 1.
    *  For example if PRS Resolution is 35 bits the mask value is:
    *  2^(35 - 32) - 1 = 2^(3) - 1 = 0x0000 0007u.
    *  The upper half of polynomial value = 0x0000 00FFu is cut:
    *  upper half of polynomial & mask = 0x0000 00FFu & 0x0000 0007u = 0x0000 0007u.
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WritePolynomialUpper(uint32 polynomial)
                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomialUpper")`
    {
        /* Mask the polynomial upper half to cut unused bits */
        polynomial &= `$INSTANCE_NAME`_MASK;

        /* Write Polynomial Upper */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG = LO8(polynomial);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG = LO8(polynomial);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 56u)        /* 56 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG = LO8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG = LO8(polynomial);

        #else                                           /* 64 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_UPPER_D__D1_REG = HI8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_UPPER_C__D1_REG = LO8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_UPPER_B__D1_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_UPPER_A__D1_REG = LO8(polynomial);

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        /* Resets triggers */
        #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
            if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
            {
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            }
        #else
            `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
        #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    }


    /*******************************************************************************
    * Function Name: `$INSTANCE_NAME`_WritePolynomialLower
    ********************************************************************************
    *
    * Summary:
    *  Writes lower half of PRS polynomial value. Only generated for 33-64-bit PRS.
    *
    * Parameters:
    *  polynomial:  Lower half of PRS polynomial value.
    *
    * Return:
    *  void
    *
    *******************************************************************************/
    void `$INSTANCE_NAME`_WritePolynomialLower(uint32 polynomial)
                                                `=ReentrantKeil($INSTANCE_NAME . "_WritePolynomialLower")`
    {
        /* Write Polynomial Lower */
        #if (`$INSTANCE_NAME`_PRS_SIZE <= 40u)          /* 40 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_LOWER_B__D1_REG = HI8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG = LO8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG = LO8(polynomial);

        #elif (`$INSTANCE_NAME`_PRS_SIZE <= 48u)        /* 48 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_LOWER_A__D1_REG = HI8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG = LO8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG = LO8(polynomial);

        #else                                           /* 64 bits PRS */
            `$INSTANCE_NAME`_POLYNOM_LOWER_D__D0_REG = HI8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_C__D0_REG = LO8(HI16(polynomial));
            `$INSTANCE_NAME`_POLYNOM_LOWER_B__D0_REG = HI8(polynomial);
            `$INSTANCE_NAME`_POLYNOM_LOWER_A__D0_REG = LO8(polynomial);

        #endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */

        /* Resets triggers */
        #if (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK)
            if((`$INSTANCE_NAME`_sleepState & `$INSTANCE_NAME`_NORMAL_SEQUENCE) != 0u)
            {
                `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
            }
        #else
            `$INSTANCE_NAME`_EXECUTE_DFF_RESET;
        #endif  /* (`$INSTANCE_NAME`_WAKEUP_BEHAVIOUR == `$INSTANCE_NAME`__RESUMEWORK) */
    }
#endif  /* End (`$INSTANCE_NAME`_PRS_SIZE <= 32u) */


/* [] END OF FILE */
