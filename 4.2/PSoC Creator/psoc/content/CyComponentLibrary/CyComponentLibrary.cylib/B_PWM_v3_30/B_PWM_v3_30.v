/*******************************************************************************
 *
 * FILENAME:  B_PWM_v3_30.v
 * UM Name:   B_PWM_v3_30
 * @Version@
 *
 * DESCRIPTION:
 *   The PWM User Module is a 8 or 16-bit PWM with dual outputs and multiple
 *    output modes.
 *
 *
 *------------------------------------------------------------------------------
 *                 Data Path register definitions
 *------------------------------------------------------------------------------
 *
 *  INSTANCE NAME:  pwmdp
 *
 *  DESCRIPTION:
 *    This data path implements the counter, terminal count and both
 *    compare registers.
 *
 *  REGISTER USAGE:
 *   F0 => Period of counter.
 *   F1 => na
 *   D0 => Compare value for channel 1
 *   D1 => Compare value for channel 2 (Period of the counter for Center Aligned mode)
 *   A0 => Counter
 *   A1 => na
 *
 *------------------------------------------------------------------------------
 *
 * Todo:
 *
********************************************************************************
* Copyright 2008-2015, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions,
* disclaimers, and limitations in the end user license agreement accompanying
* the software package with which this file was provided.
********************************************************************************/


`include "cypress.v"
`ifdef B_PWM_V_v3_30_ALREADY_INCLUDED
`else
`define B_PWM_V_v3_30_ALREADY_INCLUDED
module B_PWM_v3_30 (
    input   wire    reset,      /* system reset signal                        */
    input   wire    clock,      /* System clock                               */
    input   wire    kill,       /* Kill signal                                */
    input   wire    capture,    /* Hardware capture (Hidden when Capture Type is set to None) */
    input   wire    cmp_sel,    /* Compare Select input (Hidden when setup to use internal state machine) */
    input   wire    trigger,    /* Trigger input                              */
    input   wire    enable,     /* Hardware enable                            */
    output  wire    tc,         /* Terminal count output                      */
    output  wire    pwm1,       /* PWM 1 output in dual output modes          */
    output  wire    pwm2,       /* PWM 2 output in dual output modes          */
    output  wire    pwm,        /* PWM output in single output modes          */
    output  wire    ph1,        /* PWM with dead-band Phase1 output           */
    output  wire    ph2,        /* PWM with dead-band Phase2 output           */
    output  wire    interrupt); /* Interrupt request output signal            */


    /**************************************************************************/
    /* Parameters                                                             */
    /**************************************************************************/
    /* localparams */

    localparam [7:0]    PWM_8_BIT    = 8'd8;
    localparam [7:0]    PWM_16_BIT   = 8'd16;
    parameter  [7:0]    Resolution   = PWM_8_BIT;

    localparam PWM_CAP_MODE_NONE   = 2'd0;
    localparam PWM_CAP_MODE_RISE   = 2'd1;
    localparam PWM_CAP_MODE_FALL   = 2'd2;
    localparam PWM_CAP_MODE_EITHER = 2'd3;
    parameter [1:0] CaptureMode = PWM_CAP_MODE_NONE;

    localparam PWM_ENMODE_CRONLY = 2'd0;
    localparam PWM_ENMODE_HWONLY = 2'd1;
    localparam PWM_ENMODE_CR_HW  = 2'd2;
    parameter [1:0] EnableMode = PWM_ENMODE_CRONLY;

    localparam PWM_MODE_ONE_OUTPUT      = 3'd0;
    localparam PWM_MODE_TWO_OUTPUT      = 3'd1;
    localparam PWM_MODE_DUAL_EDGE       = 3'd2;
    localparam PWM_MODE_CENTER_ALIGN    = 3'd3;
    localparam PWM_MODE_HWSELECT        = 3'd4;
    localparam PWM_MODE_DITHER          = 3'd5;
    parameter [2:0] PWMMode = PWM_MODE_ONE_OUTPUT;

    localparam PWM_KILLMODE_DISABLED    = 3'd0;
    localparam PWM_KILLMODE_ASYNCH      = 3'd1;
    localparam PWM_KILLMODE_SINGLE_CYC  = 3'd2;
    localparam PWM_KILLMODE_LATCHED     = 3'd3;
    localparam PWM_KILLMODE_MINTIME     = 3'd4;
    parameter [2:0] KillMode = PWM_KILLMODE_DISABLED;

    localparam PWM_RUNMODE_CONTINUOUS     = 2'd0;
    localparam PWM_RUNMODE_ONESHOT_SINGLE = 2'd1;
    localparam PWM_RUNMODE_ONESHOT_MULTI  = 2'd2;
    parameter [1:0] RunMode = PWM_RUNMODE_CONTINUOUS;   /* TODO: Implement */

    localparam PWM_TRIGMODE_NONE         = 2'd0;
    localparam PWM_TRIGMODE_RISINGEDGE   = 2'd1;
    localparam PWM_TRIGMODE_FALLINGEDGE  = 2'd2;
    localparam PWM_TRIGMODE_EITHEREDGE   = 2'd3;
    parameter [1:0] TriggerMode = PWM_TRIGMODE_NONE;

    localparam PWM_DBMODE_DISABLED      = 2'd0;
    localparam PWM_DBMODE_1_3_CLOCKS    = 2'd1;
    localparam PWM_DBMODE_255_CLOCKS    = 2'd2;
    parameter [1:0] DeadBand = PWM_DBMODE_DISABLED;

    localparam PWM_DITHER_OFFSET0  = 2'd0;
    localparam PWM_DITHER_OFFSET25 = 2'd1;
    localparam PWM_DITHER_OFFSET50 = 2'd2;
    localparam PWM_DITHER_OFFSET75 = 2'd3;
    parameter [1:0] DitherOffset = PWM_DITHER_OFFSET0;

    localparam PWM_CTRL_CMPMODE_LT  = 3'h1; /* Compare Less than               */
    localparam PWM_CTRL_CMPMODE_LTE = 3'h2; /* Compare Less than or equal to   */
    localparam PWM_CTRL_CMPMODE_EQ  = 3'h0; /* Compare Equal to                */
    localparam PWM_CTRL_CMPMODE_GT  = 3'h3; /* Compare Greater than            */
    localparam PWM_CTRL_CMPMODE_GTE = 3'h4; /* Compare Greater than or equal to*/
    localparam PWM_CTRL_CMPMODE_SW  = 3'h5; /* Compare Greater than or equal to*/
    parameter [3:0] CompareType1    = PWM_CTRL_CMPMODE_LT;
    parameter [3:0] CompareType2    = PWM_CTRL_CMPMODE_LT;

    /* Control Register Bits*/
    localparam PWM_CTRL_ENABLE      = 8'h7; /* Enable the PWM                 */
    localparam PWM_CTRL_UNUSED      = 8'h6; /* Unused                         */
    localparam PWM_CTRL_CMPMODE2_2  = 8'h5; /* Compare mode 2                 */
    localparam PWM_CTRL_CMPMODE2_1  = 8'h4; /* Compare mode 2                 */
    localparam PWM_CTRL_CMPMODE2_0  = 8'h3; /* Compare mode 2                 */
    localparam PWM_CTRL_CMPMODE1_2  = 8'h2; /* Compare mode 1                 */
    localparam PWM_CTRL_CMPMODE1_1  = 8'h1; /* Compare mode 1                 */
    localparam PWM_CTRL_CMPMODE1_0  = 8'h0; /* Compare mode 1                 */

    localparam PWM_DBCTRL_DBCNT_1    = 8'h1; /* Dead Band Count 1                 */
    localparam PWM_DBCTRL_DBCNT_0    = 8'h0; /* Dead Band Count 0                 */

    /* Datapath Implementation */
    localparam RESET_PERIOD_SHIFT_OP    = (PWMMode == PWM_MODE_CENTER_ALIGN) ? `CS_ALU_OP__XOR : `CS_ALU_OP_PASS;
    localparam RESET_PERIOD_SRC_B       = (PWMMode == PWM_MODE_CENTER_ALIGN) ? `CS_SRCB_A0 : `CS_SRCB_D0;
    localparam RESET_PERIOD_A0_SRC      = (PWMMode == PWM_MODE_CENTER_ALIGN) ? `CS_A0_SRC__ALU : `CS_A0_SRC___F0;

    /* Status Register Implementation */
    /* Status Register Bits */
    localparam PWM_STS_CMP1         = 8'h0; /* Compare output 1               */
    localparam PWM_STS_CMP2         = 8'h1; /* Compare output 1               */
    localparam PWM_STS_TC           = 8'h2; /* Terminal Count                 */
    localparam PWM_STS_FIFO_FULL    = 8'h3; /* FIFO Full Status               */
    localparam PWM_STS_FIFO_NEMPTY  = 8'h4; /* FIFO Not Empty Status          */
    localparam PWM_STS_KILL         = 8'h5; /* Kill Event                     */

    /* Parameters */
    parameter UseStatus = 1;
    parameter CompareStatusEdgeSense = 1;

    parameter dpconfig0ALL = {
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:    Reset Period */
        `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:    Dec A0 (A0 = A0 - 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:    Reset Period*/
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:    Reset Period */
          8'hFF, 8'h00, /*CFG9:     */
          8'hFF, 8'hFF, /*CFG11-10:     */
        `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:     */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
        1'h0, `SC_FIFO1__A0, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
        `SC_FB_NOCHN, `SC_CMP1_NOCHN,
        `SC_CMP0_NOCHN, /*CFG15-14:     */
         10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_FX,
        `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:     */
    };

    parameter dpconfig0CA = {
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:    Reset Period */
        `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:    Dec A0 (A0 = A0 - 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:    Reset Period */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:    Reset Period */
        `CS_ALU_OP__INC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:    Inc A0 (A0 = A0 + 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:    Reset Period */
          8'hFF, 8'h00, /*CFG9:     */
          8'hFF, 8'hFF, /*CFG11-10:     */
        `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_ARITH,
        `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:     */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
        1'h0, `SC_FIFO1__A0, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
        `SC_FB_NOCHN, `SC_CMP1_NOCHN,
        `SC_CMP0_NOCHN, /*CFG15-14:     */
         10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_FX,
        `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:     */
    };

    parameter dpconfig1ALL = {
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:    Reset Period */
        `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:    Dec A0 (A0 = A0 - 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:    Reset Period*/
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:    Reset Period */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:    Reset Period */
          8'hFF, 8'h00, /*CFG9:     */
          8'hFF, 8'hFF, /*CFG11-10:     */
        `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_CHAIN,
        `SC_CI_A_CHAIN, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:     */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
        1'h0, `SC_FIFO1__A0, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_CHNED,
        `SC_FB_CHNED, `SC_CMP1_CHNED,
        `SC_CMP0_CHNED, /*CFG15-14:     */
         10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_FX,
        `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:     */
    };

    parameter dpconfig1CA = {
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM0:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM1:    Reset Period */
        `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM2:    Dec A0 (A0 = A0 - 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM3:    Reset Period */
        `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM4:    Idle */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM5:    Reset Period */
        `CS_ALU_OP__INC, `CS_SRCA_A0, `CS_SRCB_D0,
        `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM6:    Inc A0 (A0 = A0 + 1) */
        RESET_PERIOD_SHIFT_OP, `CS_SRCA_A0, RESET_PERIOD_SRC_B,
        `CS_SHFT_OP_PASS, RESET_PERIOD_A0_SRC, `CS_A1_SRC_NONE,
        `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
        `CS_CMP_SEL_CFGA, /*CFGRAM7:    Reset Period */
          8'hFF, 8'h00, /*CFG9:     */
          8'hFF, 8'hFF, /*CFG11-10:     */
        `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_CHAIN,
        `SC_CI_A_CHAIN, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
        `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
        `SC_SI_A_DEFSI, /*CFG13-12:     */
        `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
        1'h0, `SC_FIFO1__A0, `SC_FIFO0_BUS,
        `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_CHNED,
        `SC_FB_CHNED, `SC_CMP1_CHNED,
        `SC_CMP0_CHNED, /*CFG15-14:     */
         10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_FX,
        `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
        `SC_WRK16CAT_DSBL /*CFG17-16:     */
    };

    parameter dpconfig0 = (PWMMode == PWM_MODE_CENTER_ALIGN) ? dpconfig0CA : dpconfig0ALL;
    parameter dpconfig1 = (PWMMode == PWM_MODE_CENTER_ALIGN) ? dpconfig1CA : dpconfig1ALL;

    /* Internal signals */
    wire           cmp1;
    wire           cmp2;
    wire           cmp1_eq;         /* A0 is equal to compare value 1         */
    wire           cmp1_less;       /* A0 is less than to compare value 1     */
    wire           cmp2_eq;         /* A0 is equal to compare value 2         */
    wire           cmp2_less;       /* A0 is less than to compare value 2     */

    /* Clock Enable block signal */
    wire           ClockOutFromEnBlock;

    /* wires for output registering logic */
    wire            tc_i;
    reg             tc_i_reg;
    wire            pwm1_i;
    reg             pwm1_i_reg;
    wire            pwm2_i;
    reg             pwm2_i_reg;
    wire            pwm_i;
    reg             pwm_i_reg;
    wire            ph1_i;
    reg             ph1_i_reg;
    wire            ph2_i;
    reg             ph2_i_reg;

    /* Dummy connections */
    wire     nc1, nc2, nc3, nc4, nc5, nc6, nc7;

    /* Control Register Output        */
    wire [7:0] control;

    /* Control Signals */
    wire        ctrl_enable;
    wire [2:0]  ctrl_cmpmode2;
    wire [2:0]  ctrl_cmpmode1;

    wire     hwEnable;
    wire     hwCapture;
    reg prevCapture;
    wire capt_rising;
    wire capt_falling;

    /* Dead-Band Impl */
    wire db_edge_rise;
    wire db_edge_fall;
    reg pwm_db_reg;
    wire pwm_db;
    wire db_ph1_run;
    reg  db_ph1_run_temp;
    wire db_ph2_run;
    reg  db_ph2_run_temp;
    wire db_tc;
    wire db_cnt_zero;
    reg [1:0] db_cnt;
    wire [1:0] db_cnt_load;
    wire db_run;
    wire [2:0] db_csaddr;
    wire    [7:0]   dbcontrol;    /* Dead Band Control Register Output */

    /* Kill Impl */
    reg sc_kill_tmp;
    wire sc_kill;
    reg ltch_kill_reg;
    wire min_kill;
    wire km_tc;
    reg min_kill_reg;
    wire km_run = min_kill_reg;
    wire final_kill;

    /* Triggers */
    wire    final_enable;
    wire    trig_out;
    reg     trig_last;
    reg     trig_disable;
    wire    trig_rise;
    wire    trig_fall;

    /* Dither Impl */
    wire dith_sel;
    reg [1:0] dith_count;

    /* PWM output(s) */
    wire pwm_temp;

    /* Run Mode */
    reg     runmode_enable;

    /* Datapath Implementation */
    wire [2:0] cs_addr;
    wire final_capture;
    wire up_cnt_final;
    reg  up_cnt;

    /* Status Register Implementation */
    wire 	fifo_nempty;
    wire 	fifo_full;
    wire    [6:0]   status;                         /* Status Register Input          */
    wire    cmp1_status;
    reg		cmp1_status_reg;
    wire    cmp2_status;
    reg     cmp2_status_reg;
    reg     final_kill_reg;

    /* Compare Outputs */
    wire compare1;
    wire compare2;

    /* Clock Enable Block Component instance */
    cy_psoc3_udb_clock_enable_v1_0 #(.sync_mode(`TRUE))
    clock_enable_block (
                        /* output */.clock_out(ClockOutFromEnBlock),
                        /* input */ .clock_in(clock),
                        /* input */ .enable(1'b1)
                        );


    /**************************************************************************/
    /* Control Register Implementation                                        */
    /**************************************************************************/
    generate
        if((EnableMode != PWM_ENMODE_HWONLY) || (CompareType1 == PWM_CTRL_CMPMODE_SW) ||
            (CompareType2 == PWM_CTRL_CMPMODE_SW))
        begin
            cy_psoc3_control #(.cy_force_order(`TRUE), .cy_ctrl_mode_1(8'h00), .cy_ctrl_mode_0(8'hFF))
            ctrlreg(
                /* input          */ .clock(ClockOutFromEnBlock),
                /* output [07:00] */ .control(control)
            );

            assign ctrl_enable    = control[PWM_CTRL_ENABLE];
        end
        else
        begin
            assign ctrl_enable = 1'b1;
            assign control = 8'd0;
        end
    endgenerate

    generate
        if(CompareType2 == PWM_CTRL_CMPMODE_SW)
        begin : sCMP2SW
            assign ctrl_cmpmode2  = {control[PWM_CTRL_CMPMODE2_2], control[PWM_CTRL_CMPMODE2_1],
                                     control[PWM_CTRL_CMPMODE2_0]};
        end
        else
        begin
            assign ctrl_cmpmode2  = CompareType2;
        end
    endgenerate

    generate
        if(CompareType1 == PWM_CTRL_CMPMODE_SW)
        begin : sCMP1SW
            assign ctrl_cmpmode1  = {control[PWM_CTRL_CMPMODE1_2], control[PWM_CTRL_CMPMODE1_1],
                                     control[PWM_CTRL_CMPMODE1_0]};
        end
        else
        begin
            assign ctrl_cmpmode1  = CompareType1;
        end
    endgenerate


    /**************************************************************************/
    /*  Capture input implementation                                          */
    /**************************************************************************/


    /**************************************************************************/
    /*  Hardware Block Descriptions
    /*              _________           |-------------------------------------|
    /*  trigger----|  Trig   |------|   |--| Run Mode|          ___________   |
    /*             |_________|      |------|_________|-----&&--|enable     |  |
    /*              N,RE,FE,EE              C, OSS, OSM    |   |         tc|--|-
    /*                                      _________      |   |  PWM      |
    /*                                     | En Mode |-----|   |___________|
    /*  enable-----------------------------|_________|
    /*                                       HW,SW,HW&SW
    /**************************************************************************/

    always @(posedge ClockOutFromEnBlock)
    begin
        prevCapture <= capture;
    end
    assign capt_rising = !prevCapture & capture;
    assign capt_falling = prevCapture & !capture;
    assign hwCapture = (CaptureMode == PWM_CAP_MODE_NONE) ? 1'b0 :
                       (CaptureMode == PWM_CAP_MODE_RISE) ? capt_rising :
                       (CaptureMode == PWM_CAP_MODE_FALL) ? capt_falling :
                       /*(CaptureMode == PWM_CAP_MODE_EITHER) ?*/ (capt_rising | capt_falling);


    /**************************************************************************/
    /* Enable Mode Block Implementations                                      */
    /**************************************************************************/
    assign hwEnable = (EnableMode == PWM_ENMODE_CRONLY) ? ctrl_enable :
                      (EnableMode == PWM_ENMODE_HWONLY) ? enable :
                      (ctrl_enable & enable);


    /**************************************************************************/
    /* Trigger Mode Block Implementations                                     */
    /**************************************************************************/
    always @(posedge ClockOutFromEnBlock)
    begin   /*Capture the Trigger Input */
        trig_last <= trigger;
    end

    assign trig_rise = trigger & !trig_last;
    assign trig_fall = !trigger & trig_last;

    assign trig_out = (TriggerMode == PWM_TRIGMODE_NONE) ? 1'b1 :
                      (TriggerMode == PWM_TRIGMODE_RISINGEDGE) ? trig_rise :
                      (TriggerMode == PWM_TRIGMODE_FALLINGEDGE) ? trig_fall :
                      /*(TriggerMode == PWM_TRIGMODE_EITHEREDGE) ?*/ (trig_rise | trig_fall);


    /**************************************************************************/
    /* Run Mode Block Implementations                                         */
    /**************************************************************************/
    generate
        if(RunMode == PWM_RUNMODE_CONTINUOUS)
        begin : sRMC
            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if(reset)
                    runmode_enable <= 1'b0;
                else if(!hwEnable)
                    runmode_enable <= 1'b0;
                else if(trig_out & hwEnable)
                    runmode_enable <= 1'b1;
            end

            assign final_enable = runmode_enable;
        end
        else if(RunMode == PWM_RUNMODE_ONESHOT_SINGLE)
        begin : sRMOSS
            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if(reset)
                begin
                    runmode_enable <= 1'b0;
                    trig_disable <= 1'b0;
                end
                else if(!hwEnable)
                begin
                    runmode_enable <= 1'b0;
                end
                else if(runmode_enable & tc_i)
                begin
                    runmode_enable <= 1'b0;
                    trig_disable <= 1'b1;
                end
                else if(trig_out & !trig_disable & hwEnable)
                begin
                    runmode_enable <= 1'b1;
                end
            end

            assign final_enable = runmode_enable;
        end
        else if(RunMode == PWM_RUNMODE_ONESHOT_MULTI)
        begin : sRMOSM
            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if(reset)
                    runmode_enable <= 1'b0;
                else if(!hwEnable)
                    runmode_enable <= 1'b0;
                else if(trig_out)
                    runmode_enable <= 1'b1;
                else if(runmode_enable & tc_i & hwEnable)
                    runmode_enable <= 1'b0;
            end

            assign final_enable = runmode_enable;
        end
    endgenerate


    /**************************************************************************/
    /* Kill Implementation                                                    */
    /**************************************************************************/
    /* Single Cycle: Kill as soon as kill goes high but don't re-enable until terminal count */
    always @(posedge ClockOutFromEnBlock)
    begin
        if(tc_i)
        begin
            sc_kill_tmp <= 1'b0;
        end
        else
        begin
            sc_kill_tmp <= kill ? (!sc_kill_tmp ? 1'b1 : sc_kill_tmp) : sc_kill_tmp;
        end
    end

    /* Latched kill doesn't re-enable the outputs until the UM is reset or the control register bit is cleared */
    always @(posedge ClockOutFromEnBlock or posedge reset)
    begin
        if(reset)
        begin
            ltch_kill_reg <= 1'b0;
        end
        else
        begin
            ltch_kill_reg <= kill ? (!ltch_kill_reg ? 1'b1 : ltch_kill_reg) : ltch_kill_reg;
        end
    end

    /* Min Time Kill doesn't re-enable ouptuts until kill is released and atleast the min time has elapsed */
    always @(posedge ClockOutFromEnBlock or posedge reset)
    begin
        if(reset)
        begin
            min_kill_reg <= 1'b0;
        end
        else if(kill)
        begin
            min_kill_reg <= !min_kill_reg ? 1'b1 : min_kill_reg;
        end
        else if(km_tc)
        begin
            min_kill_reg <= 1'b0;
        end
    end

    assign sc_kill = ~(kill | sc_kill_tmp);
    assign min_kill = kill | min_kill_reg;


    assign final_kill = (KillMode == PWM_KILLMODE_ASYNCH) ? !kill :
                        (KillMode == PWM_KILLMODE_SINGLE_CYC) ? sc_kill :
                        (KillMode == PWM_KILLMODE_LATCHED) ? !ltch_kill_reg :
                        (KillMode == PWM_KILLMODE_MINTIME) ? !min_kill :
                        /*(KillMode == PWM_KILLMODE_DISABLED) ?*/ 1'b1; /* Default */

    generate
        if(KillMode == PWM_KILLMODE_MINTIME)
        begin : sKM
            cy_psoc3_dp8 #(.cy_dpconfig_a (
            {
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC___D0, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM0:    Preload Period (A0 <= D0) */
                `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM1:    Dec A0  ( A0 <= A0 - 1 ) */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM2:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM3:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM4:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM5:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM6:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM7:    Idle  */
                  8'hFF, 8'h00, /*CFG9:     */
                  8'hFF, 8'hFF, /*CFG11-10:     */
                `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_ARITH,
                `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
                `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
                `SC_SI_A_DEFSI, /*CFG13-12:     */
                `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
                1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
                `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
                `SC_FB_NOCHN, `SC_CMP1_NOCHN,
                `SC_CMP0_NOCHN, /*CFG15-14:     */
                 10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
                `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
                `SC_WRK16CAT_DSBL /*CFG17-16:     */
            }))
            killmodecounterdp (
            /*  input                   */  .clk(ClockOutFromEnBlock),
            /*  input   [02:00]         */  .cs_addr({2'b0,km_run}),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(km_tc),              /* Terminal Count (A0 == 0)  */
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat()
            );
        end /* end of if statement in generate for kill mode*/
        else
        begin
            assign km_tc = 1'b0;
        end
    endgenerate


    /**************************************************************************/
    /* Dead-Band Implementation     (See Datasheet for implementation details)*/
    /**************************************************************************/
    generate
        if(DeadBand != PWM_DBMODE_DISABLED)
        begin : sDBen
            always @(posedge ClockOutFromEnBlock)
            begin
                pwm_db_reg <= pwm_db;
                ph1_i_reg <= ph1_i;
                ph2_i_reg <= ph2_i;
            end

            /**************************************************************************/
            /* If a rising edge is detected on the pwm output then we need to delay ph1 
            /* going high by dead band counts 
            /* If a falling edge is detected on the pwm output then we need to dalay 
            /* ph2 going high by dead band counts 
            /* The ph1 disable signal goes high on rising edge detect and stays high 
            /* until tc is reached on the dead band counter
            /* The ph2 disable signal goes high on falling edge detect and stays high 
            /* until tc is reached on the dead band counter */
            /**************************************************************************/
            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if(reset)
                begin
                    db_ph1_run_temp <= 1'b0;
                    db_ph2_run_temp <= 1'b0;
                end
                else if(db_edge_rise)
                begin
                    db_ph1_run_temp <= 1'b1;
                end
                else if(db_edge_fall)
                begin
                    db_ph2_run_temp <= 1'b1;
                end
                else if(db_tc)
                begin
                    db_ph1_run_temp <= 1'b0;
                    db_ph2_run_temp <= 1'b0;
                end
            end

            assign pwm_db = (PWMMode == PWM_MODE_TWO_OUTPUT) ? pwm1_i : pwm_i;
            assign ph1 = ph1_i_reg;
            assign ph2 = ph2_i_reg;

            /* This just puts the deadband output out 1 clock cycle on both edges. */
            assign ph1_i = pwm_db & !db_ph1_run;

            /* This just puts the deadband output out 1 clock cycle on both edges. */
            assign ph2_i = !pwm_db & !db_ph2_run & final_kill;

            assign db_csaddr = {2'b0,(db_ph1_run|db_ph2_run) & !db_tc};
            assign db_ph1_run = db_ph1_run_temp | db_edge_rise;
            assign db_ph2_run = db_ph2_run_temp | db_edge_fall;
            assign db_edge_rise = pwm_db & !pwm_db_reg;
            assign db_edge_fall = !pwm_db & pwm_db_reg;
        end
    endgenerate

    generate
        if(DeadBand == PWM_DBMODE_255_CLOCKS)
        begin : sDB255
            cy_psoc3_dp8 #(.cy_dpconfig_a (
            {
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC___D0, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM0:    Preload Period (A0 <= D0) */
                `CS_ALU_OP__DEC, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM1:    Dec A0  ( A0 <= A0 - 1 ) */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM2:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM3:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM4:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM5:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM6:    Idle */
                `CS_ALU_OP_PASS, `CS_SRCA_A0, `CS_SRCB_D0,
                `CS_SHFT_OP_PASS, `CS_A0_SRC__ALU, `CS_A1_SRC_NONE,
                `CS_FEEDBACK_DSBL, `CS_CI_SEL_CFGA, `CS_SI_SEL_CFGA,
                `CS_CMP_SEL_CFGA, /*CFGRAM7:    Idle */
                  8'hFF, 8'h00, /*CFG9:     */
                  8'hFF, 8'hFF, /*CFG11-10:     */
                `SC_CMPB_A0_D1, `SC_CMPA_A0_D1, `SC_CI_B_ARITH,
                `SC_CI_A_ARITH, `SC_C1_MASK_DSBL, `SC_C0_MASK_DSBL,
                `SC_A_MASK_DSBL, `SC_DEF_SI_0, `SC_SI_B_DEFSI,
                `SC_SI_A_DEFSI, /*CFG13-12:     */
                `SC_A0_SRC_ACC, `SC_SHIFT_SL, 1'h0,
                1'h0, `SC_FIFO1_BUS, `SC_FIFO0_BUS,
                `SC_MSB_DSBL, `SC_MSB_BIT0, `SC_MSB_NOCHN,
                `SC_FB_NOCHN, `SC_CMP1_NOCHN,
                `SC_CMP0_NOCHN, /*CFG15-14:     */
                 10'h00, `SC_FIFO_CLK__DP,`SC_FIFO_CAP_AX,
                `SC_FIFO__EDGE,`SC_FIFO__SYNC,`SC_EXTCRC_DSBL,
                `SC_WRK16CAT_DSBL /*CFG17-16:     */
            }))
            deadbandcounterdp (
            /*  input                   */  .clk(ClockOutFromEnBlock),
            /*  input   [02:00]         */  .cs_addr(db_csaddr),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(1'b0),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(),
            /*  output                  */  .cl0(),
            /*  output                  */  .z0(db_tc),              /* Terminal Count (A0 == 0)  */
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(),
            /*  output                  */  .cl1(),
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /*  output                  */  .f1_bus_stat(),
            /*  output                  */  .f1_blk_stat()
            );
        end /* end of if statement in generate for deadband mode*/
        else if(DeadBand == PWM_DBMODE_1_3_CLOCKS)
        begin

            /* Instantiate the control register */
            cy_psoc3_control #(.cy_force_order(`TRUE), .cy_ctrl_mode_1(8'h00), .cy_ctrl_mode_0(8'hFF))
            dbctrlreg (
                /* input          */ .clock(ClockOutFromEnBlock),
                /* output [07:00] */ .control(dbcontrol)
            );

            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if(reset)
                begin
                    db_cnt <= 2'b0;
                end
                else
                begin
                    if(db_cnt_zero)
                    begin
                        db_cnt <= db_cnt_load;
                    end
                    else if(db_run)
                    begin
                        db_cnt <= db_cnt - 1;
                    end
                end
            end

            assign db_cnt_load = {dbcontrol[PWM_DBCTRL_DBCNT_1], dbcontrol[PWM_DBCTRL_DBCNT_0]};
            assign db_run = (db_ph1_run|db_ph2_run);
            assign db_cnt_zero = (db_cnt == 2'd0);
            assign db_tc = db_cnt_zero;
        end
        else
        begin
            assign db_tc = 1'b0;
        end
    endgenerate


    /**************************************************************************/
    /* Dither implementation                                                  */
    /**************************************************************************/
    always @(posedge ClockOutFromEnBlock or posedge reset)
    begin
        if(reset)
        begin
            dith_count <= 0;
        end
        else
        begin
            if(tc_i)
            begin
                dith_count <= dith_count + 1;
            end
        end
    end

    assign dith_sel = (DitherOffset == PWM_DITHER_OFFSET0) ? 1'b0 :
                      (DitherOffset == PWM_DITHER_OFFSET25) ? ((dith_count == 0) ? 1'b1 : 1'b0) :
                      (DitherOffset == PWM_DITHER_OFFSET50) ? ((dith_count == 0 || dith_count == 2) ? 1'b1 : 1'b0) :
                      /*(DitherOffset == PWM_DITHER_OFFSET75) ? */((dith_count == 3) ? 1'b0 : 1'b1) ;


    /**************************************************************************/
    /* Status Register Implementation                                         */
    /**************************************************************************/
    generate
        if(UseStatus)
        begin
            /* Instantiate the status register and interrupt hook*/
            cy_psoc3_statusi #(.cy_force_order(1), .cy_md_select(7'h27),
            .cy_int_mask(7'h7F))
            stsreg(
            /* input          */  .clock(ClockOutFromEnBlock),
            /* input  [06:00] */  .status(status),
            /* output         */  .interrupt(interrupt),
            /* input          */  .reset(reset)
            );

            if(CompareStatusEdgeSense == 1)
            begin : sCMP1EdgeSense
                reg prevCompare1;
                always @(posedge ClockOutFromEnBlock)
                begin
                    prevCompare1 <= cmp1;
                end
                assign cmp1_status = !prevCompare1 & cmp1;
            end
            else
            begin
                assign cmp1_status = cmp1;
            end

            if((CompareStatusEdgeSense == 1) && (PWMMode !=PWM_MODE_ONE_OUTPUT) &&
               (PWMMode != PWM_MODE_CENTER_ALIGN) && (PWMMode != PWM_MODE_DITHER))
            begin : sCMP2EdgeSense
                reg prevCompare2;

                always @(posedge ClockOutFromEnBlock)
                begin
                    prevCompare2 <= cmp2;
                end

                assign cmp2_status = !prevCompare2 & cmp2;
            end
            else
            begin
                assign cmp2_status = cmp2;
            end

            /* Register combinational logic before feeding into macrocell */
            always @(posedge ClockOutFromEnBlock or posedge reset)
            begin
                if (reset)
                begin
                    cmp1_status_reg <= 1'b0;
                    cmp2_status_reg <= 1'b0;
                    final_kill_reg <= 1'b0;
                end
                else
                begin
                    cmp1_status_reg <= cmp1_status;
                    cmp2_status_reg <= cmp2_status;
                    final_kill_reg <= !final_kill;
                end
            end

            assign status[6] = 1'h0;                    /* unused bits of the status register*/
            assign status[PWM_STS_CMP1] = cmp1_status_reg;
            assign status[PWM_STS_CMP2] = cmp2_status_reg;
            assign status[PWM_STS_TC] = tc_i & final_enable;
            assign status[PWM_STS_FIFO_FULL] = fifo_full;
            assign status[PWM_STS_FIFO_NEMPTY] = 1'b0;
            assign status[PWM_STS_KILL] = final_kill_reg;
        end
    endgenerate


    /**************************************************************************/
    /* Datapath Implementation                                                */
    /**************************************************************************/
    generate
        if(PWMMode == PWM_MODE_CENTER_ALIGN)
        begin : sCA
            /**************************************************************************/
            /* Center Aligned implementation                                          */
            /**************************************************************************/
            always @(posedge ClockOutFromEnBlock)
            begin
                if(cmp2_eq)
                begin
                    up_cnt <= 1'b0;
                end
                else if(tc_i)
                begin
                    up_cnt <= 1'b1;
                end
            end
            assign up_cnt_final = up_cnt | tc_i;
            assign cs_addr = {up_cnt_final,reset | final_enable,reset};
        end
        else
        begin : sNoCA
            assign cs_addr = {tc_i,final_enable,reset};
        end

    endgenerate

    generate
        if(Resolution == PWM_8_BIT)
        begin : sP8
            cy_psoc3_dp8 #(.cy_dpconfig_a(dpconfig0)) pwmdp(
            /*  input                   */  .clk(ClockOutFromEnBlock),
            /*  input   [02:00]         */  .cs_addr(cs_addr),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(final_capture),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output                  */  .ce0(cmp1_eq),     /* Compare1 ( A0 == D0 )*/
            /*  output                  */  .cl0(cmp1_less),   /* Compare1 ( A0 < D0 ) */
            /*  output                  */  .z0(tc_i),           /* tc ( A0 == 0 )       */
            /*  output                  */  .ff0(),
            /*  output                  */  .ce1(cmp2_eq),     /* Compare2 ( A0 == D1 )*/
            /*  output                  */  .cl1(cmp2_less),   /* Compare2 ( A0 < D1 ) */
            /*  output                  */  .z1(),
            /*  output                  */  .ff1(),
            /*  output                  */  .ov_msb(),
            /*  output                  */  .co_msb(),
            /*  output                  */  .cmsb(),
            /*  output                  */  .so(),
            /*  output                  */  .f0_bus_stat(),
            /*  output                  */  .f0_blk_stat(),
            /* TODO: Can't use this because we exceed the number of outputs allowed from one Datapath. */
            /*  output                  */  .f1_bus_stat(fifo_nempty),
            /*  output                  */  .f1_blk_stat(fifo_full)
            );
        end /* end of if statement in generate */
        else
        begin : sP16
            cy_psoc3_dp16 #(.cy_dpconfig_a(dpconfig0),
            .cy_dpconfig_b(dpconfig1)) pwmdp(
            /*  input                   */  .clk(ClockOutFromEnBlock),
            /*  input   [02:00]         */  .cs_addr(cs_addr),
            /*  input                   */  .route_si(1'b0),
            /*  input                   */  .route_ci(1'b0),
            /*  input                   */  .f0_load(1'b0),
            /*  input                   */  .f1_load(final_capture),
            /*  input                   */  .d0_load(1'b0),
            /*  input                   */  .d1_load(1'b0),
            /*  output  [01:00]         */  .ce0({cmp1_eq, nc2}),    /* Compare1 ( A0 == D0 )  */
            /*  output  [01:00]         */  .cl0({cmp1_less, nc3}),  /* Compare1 ( A0 < D0 )   */
            /*  output  [01:00]         */  .z0({tc_i, nc1}),          /* tc ( A0 == 0 )         */
            /*  output  [01:00]         */  .ff0(),
            /*  output  [01:00]         */  .ce1({cmp2_eq, nc4}),    /* Compare2 ( A0 == D1 )  */
            /*  output  [01:00]         */  .cl1({cmp2_less, nc5}),  /* Compare2 ( A0 < D1 )   */
            /*  output  [01:00]         */  .z1(),
            /*  output  [01:00]         */  .ff1(),
            /*  output  [01:00]         */  .ov_msb(),
            /*  output  [01:00]         */  .co_msb(),
            /*  output  [01:00]         */  .cmsb(),
            /*  output  [01:00]         */  .so(),
             /*  output  [01:00]         */  .f0_bus_stat(),
            /*  output  [01:00]         */  .f0_blk_stat(),
            /*  output  [01:00]         */  .f1_bus_stat({fifo_nempty,nc6}),  /* TODO: Can't exceed 6 outputs. */
            /*  output  [01:00]         */  .f1_blk_stat({fifo_full,nc7})
            );
        end /* end of else statement in generate */
    endgenerate


    /**************************************************************************/
    /* Pulse Width output(s) implementation                                   */
    /**************************************************************************/
    generate
        if(CompareType1 == PWM_CTRL_CMPMODE_SW)
        begin : sCMP1SW_OUTS
            assign compare1 = (ctrl_cmpmode1 == PWM_CTRL_CMPMODE_LT)  ? cmp1_less :
                              (ctrl_cmpmode1 == PWM_CTRL_CMPMODE_LTE) ? (cmp1_less | cmp1_eq) :
                              (ctrl_cmpmode1 == PWM_CTRL_CMPMODE_EQ)  ? cmp1_eq :
                              (ctrl_cmpmode1 == PWM_CTRL_CMPMODE_GT)  ? (!cmp1_less & !cmp1_eq):
                              /*(ctrl_cmpmode1 == PWM_CTRL_CMPMODE_GTE)?*/  !cmp1_less;
        end
        else
        begin
            assign compare1 = (CompareType1 == PWM_CTRL_CMPMODE_LT)  ? cmp1_less :
                              (CompareType1 == PWM_CTRL_CMPMODE_LTE) ? (cmp1_less | cmp1_eq) :
                              (CompareType1 == PWM_CTRL_CMPMODE_EQ)  ? cmp1_eq :
                              (CompareType1 == PWM_CTRL_CMPMODE_GT)  ? (!cmp1_less & !cmp1_eq):
                              /*(CompareType1 == PWM_CTRL_CMPMODE_GTE)?*/  !cmp1_less;
        end
    endgenerate

    generate
        if(CompareType2 == PWM_CTRL_CMPMODE_SW)
        begin : sCMP2SW_OUTS
            assign compare2 = (ctrl_cmpmode2 == PWM_CTRL_CMPMODE_LT)  ? cmp2_less :
                              (ctrl_cmpmode2 == PWM_CTRL_CMPMODE_LTE) ? (cmp2_less | cmp2_eq) :
                              (ctrl_cmpmode2 == PWM_CTRL_CMPMODE_EQ)  ? cmp2_eq :
                              (ctrl_cmpmode2 == PWM_CTRL_CMPMODE_GT)  ? (!cmp2_less & !cmp2_eq):
                              /*(ctrl_cmpmode2 == PWM_CTRL_CMPMODE_GTE)?*/  !cmp2_less;
        end
        else
        begin
            assign compare2 = (CompareType2 == PWM_CTRL_CMPMODE_LT)  ? cmp2_less :
                              (CompareType2 == PWM_CTRL_CMPMODE_LTE) ? (cmp2_less | cmp2_eq) :
                              (CompareType2 == PWM_CTRL_CMPMODE_EQ)  ? cmp2_eq :
                              (CompareType2 == PWM_CTRL_CMPMODE_GT)  ? (!cmp2_less & !cmp2_eq):
                              /*(CompareType2 == PWM_CTRL_CMPMODE_GTE)?*/  !cmp2_less;
        end
    endgenerate

    /* Register the pwm output to avoid glitches on the output terminal*/
    always @(posedge ClockOutFromEnBlock)
    begin
        pwm_i_reg <= pwm_i ;

        /* Register pwm1 and pw2 for avoiding glitches on the outputs*/
        pwm1_i_reg <= pwm1_i;
        pwm2_i_reg <= pwm2_i;

        /* Register the tc to avoid glitches on the output terminal */
        tc_i_reg <= tc_i & final_enable;
    end

    assign tc = tc_i_reg;
    assign final_capture = hwCapture & hwEnable;
    assign pwm = pwm_i_reg;
    assign pwm1 = pwm1_i_reg;
    assign pwm2 = pwm2_i_reg;
    assign pwm_i = pwm_temp & final_enable;
    assign pwm1_i = (PWMMode == PWM_MODE_TWO_OUTPUT) ? (cmp1 & final_enable) : 1'b0;
    assign pwm2_i = (PWMMode == PWM_MODE_TWO_OUTPUT) ? (cmp2 & final_enable) : 1'b0;
    assign cmp1 = final_kill & compare1;

    /* if cmp2 is used the implement otherwise remove the wasted macrocell */
    assign cmp2 = (PWMMode != PWM_MODE_ONE_OUTPUT) ? (final_kill & compare2) : 1'b0;

    assign pwm_temp = (PWMMode == PWM_MODE_DITHER) ? ((!dith_sel) ? cmp1 : cmp2) :
                      (PWMMode == PWM_MODE_HWSELECT) ? ((!cmp_sel) ? cmp1 : cmp2) :
                      (PWMMode == PWM_MODE_DUAL_EDGE) ? (cmp1 & cmp2) :
                      (PWMMode == PWM_MODE_CENTER_ALIGN) ? cmp1 :
                      (PWMMode == PWM_MODE_ONE_OUTPUT) ? cmp1 :
                      1'b0;

endmodule
`endif /* B_PWM_V_v3_30_ALREADY_INCLUDED */
