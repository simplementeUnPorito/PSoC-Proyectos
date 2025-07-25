/*******************************************************************************
* File Name: `$INSTANCE_NAME`.c
* Version `$CY_MAJOR_VERSION`.`$CY_MINOR_VERSION`
*
* Description:
*  This file provides the API source code for the FILT component.
*
* Note:
*  
*******************************************************************************
* Copyright 2008-2013, Cypress Semiconductor Corporation.  All rights reserved.
* You may use this file only in accordance with the license, terms, conditions, 
* disclaimers, and limitations in the end user license agreement accompanying 
* the software package with which this file was provided.
********************************************************************************/

#include "`$INSTANCE_NAME`_PVT.h"


/*******************************************************************************
* FILT component internal variables.
*******************************************************************************/

uint8 `$INSTANCE_NAME`_initVar = 0x0u;


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Init
********************************************************************************
*
* Summary:
*  Initialize component's parameters to the parameters set by user in the 
*  customizer of the component placed onto schematic. Usually called in 
*  `$INSTANCE_NAME`_Start().
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
        /* Power on DFB before initializing the RAMs */
    `$INSTANCE_NAME`_PM_ACT_CFG_REG |= `$INSTANCE_NAME`_PM_ACT_MSK;

    /* Turn off Run Bit */
    `$INSTANCE_NAME`_CR_REG &= (uint8)~`$INSTANCE_NAME`_RUN_MASK;
                
    /* Enable the DFB RAMS */
    `$INSTANCE_NAME`_RAM_EN_REG = `$INSTANCE_NAME`_RAM_DIR_BUS;
        
    /* Put DFB RAM on the bus */
    `$INSTANCE_NAME`_RAM_DIR_REG = `$INSTANCE_NAME`_RAM_DIR_BUS;
        
    /* Write DFB RAMs */
    /* Control Store RAMs */
    (void)memcpy( `$INSTANCE_NAME`_CSA_RAM,
        `$INSTANCE_NAME`_control, `$INSTANCE_NAME`_CSA_RAM_SIZE); 
    (void)memcpy(`$INSTANCE_NAME`_CSB_RAM,
        `$INSTANCE_NAME`_control, `$INSTANCE_NAME`_CSB_RAM_SIZE); 
    /* CFSM RAM */
    (void)memcpy(`$INSTANCE_NAME`_CFSM_RAM,
        `$INSTANCE_NAME`_cfsm, `$INSTANCE_NAME`_CFSM_RAM_SIZE); 
    /* Data RAMs */
    (void)memcpy(`$INSTANCE_NAME`_DA_RAM,
        `$INSTANCE_NAME`_data_a, `$INSTANCE_NAME`_DA_RAM_SIZE); 
    (void)memcpy(`$INSTANCE_NAME`_DB_RAM,
        `$INSTANCE_NAME`_data_b, `$INSTANCE_NAME`_DB_RAM_SIZE); 
    /* ACU RAM */
    (void)memcpy(`$INSTANCE_NAME`_ACU_RAM,
        `$INSTANCE_NAME`_acu, `$INSTANCE_NAME`_ACU_RAM_SIZE); 

    /* Take DFB RAM off the bus */
    `$INSTANCE_NAME`_RAM_DIR_REG = `$INSTANCE_NAME`_RAM_DIR_DFB;

    /* Set up interrupt and DMA events */
    `$INSTANCE_NAME`_SetInterruptMode(`$INSTANCE_NAME`_INIT_INTERRUPT_MODE);
    `$INSTANCE_NAME`_SetDMAMode(`$INSTANCE_NAME`_INIT_DMA_MODE);
        
    /* Clear any pending interrupts */
    /* Bits [2..0] of this register are readonly. */
    `$INSTANCE_NAME`_SR_REG = 0xf8u;   
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Enable
********************************************************************************
*  
* Summary: 
*  Enables the DFB run bit.
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
    /* Power on DFB in Active mode */
    `$INSTANCE_NAME`_PM_ACT_CFG_REG |= `$INSTANCE_NAME`_PM_ACT_MSK;
        
    /* Power on DFB in Alternative Active mode */
    `$INSTANCE_NAME`_PM_STBY_CFG_REG |= `$INSTANCE_NAME`_PM_STBY_MSK;

    /* Turn on Run Bit */
    `$INSTANCE_NAME`_CR_REG |= `$INSTANCE_NAME`_RUN_MASK;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Start
********************************************************************************
*
* Summary:
*  This method does the prep work necessary to setup DFB.  This includes loading 
*
* Parameters:  
*  void
* 
* Return: 
*  void
*
* Global variables:
*  `$INSTANCE_NAME`_initVar:  Used to check the initial configuration,
*  modified when this function is called for the first time.
*
* Note: 
*  Use `$INSTANCE_NAME`_InterruptConfig to control which events trigger 
*  interrupts in the DFB. 
*
*******************************************************************************/
void `$INSTANCE_NAME`_Start(void) `=ReentrantKeil($INSTANCE_NAME . "_Start")`
{
     /* If not Initialized then initialize all required hardware and software */
    if(`$INSTANCE_NAME`_initVar == 0u)
    {
        `$INSTANCE_NAME`_Init();
        `$INSTANCE_NAME`_initVar = 1u;
    }

    /* Enable the DFB block */
    `$INSTANCE_NAME`_Enable();
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Stop
********************************************************************************
*
* Summary:
*  Turn off the run bit.  If DMA control is used to feed the channels, allow 
*  arguments to turn one of the TD channels off. 
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
    `$INSTANCE_NAME`_CR_REG &= (uint8)~(`$INSTANCE_NAME`_RUN_MASK);

    /* Power off DFB in Active mode */
    `$INSTANCE_NAME`_PM_ACT_CFG_REG &= (uint8)~`$INSTANCE_NAME`_PM_ACT_MSK;
    
    /* Power off DFB in Alternative Active mode */
    `$INSTANCE_NAME`_PM_STBY_CFG_REG &= (uint8)~`$INSTANCE_NAME`_PM_STBY_MSK;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Read8
********************************************************************************
*
* Summary:
*  Get the value in one of the DFB Output Holding Registers 
*
* Parameters:  
*  channel:  `$INSTANCE_NAME`_CHANNEL_A or `$INSTANCE_NAME`_CHANNEL_B
*            
* Return: 
*  The most significant 8 bits of the current output value sitting in the 
*  selected channel's holding register or 0x00 for invalid channel numbers.
*
*******************************************************************************/
uint8 `$INSTANCE_NAME`_Read8(uint8 channel) `=ReentrantKeil($INSTANCE_NAME . "_Read8")`
{
    uint8 value;

    if (channel == `$INSTANCE_NAME`_CHANNEL_A)
    {
        value = `$INSTANCE_NAME`_HOLDAH_REG;
    }
    else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
    {
        value = `$INSTANCE_NAME`_HOLDBH_REG;
    }
    else
    {
        value = 0x0u;
    }
    return value;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Read16
********************************************************************************
*
* Summary:
*  Get the value in one of the DFB Output Holding Registers 
*
* Parameters:  
*  channel:  `$INSTANCE_NAME`_CHANNEL_A or `$INSTANCE_NAME`_CHANNEL_B
*            
* Return: 
*  The most significant 16 bits of the current output value sitting in the 
*  selected channel's holding register or 0x0000 for invalid channel numbers
*
* Note:
*  Order of the read is important.  On the read of the high byte, the DFB clears
*  the data ready bit.
*
*******************************************************************************/
#if defined(__C51__) || defined(__CX51__) 

    uint16 `$INSTANCE_NAME`_Read16(uint8 channel) `=ReentrantKeil($INSTANCE_NAME . "_Read16")`
    {
        uint16 val;
    
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {        
            val = `$INSTANCE_NAME`_HOLDAM_REG;
            val |= (uint16)(`$INSTANCE_NAME`_HOLDAH_REG) << 8u;
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {      
            val = `$INSTANCE_NAME`_HOLDBM_REG;
            val |= (uint16)`$INSTANCE_NAME`_HOLDBH_REG << 8u;
        }
        else
        {
            val = 0x0u;
        }
        return val;
    }

#else

    uint16 `$INSTANCE_NAME`_Read16(uint8 channel) `=ReentrantKeil($INSTANCE_NAME . "_Read16")`
    {
        uint16 val;

        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {        
            val = `$INSTANCE_NAME`_HOLDA16_REG;
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {      
            val = `$INSTANCE_NAME`_HOLDB16_REG;
        }
        else
        {
            val = 0x0u;
        }
        return val;
    }

#endif /* defined(__C51__) || defined(__CX51__) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Read24
********************************************************************************
*
* Summary:
*  Get the value in one of the DFB Output Holding Registers 
*
* Parameters:  
*  channel:  `$INSTANCE_NAME`_CHANNEL_A or `$INSTANCE_NAME`_CHANNEL_B
*            
* Return: 
*  The current 24-bit output value sitting in the selected channel's
*  holding register or 0x00000000 for invalid channel numbers
*
* Note:
*  Order of the read is important.  On the read of the high byte, the DFB clears
*  the data ready bit.
*
*******************************************************************************/
#if defined(__C51__) || defined(__CX51__)

    uint32 `$INSTANCE_NAME`_Read24(uint8 channel) `=ReentrantKeil($INSTANCE_NAME . "_Read24")`
    {
        uint32 val;
    
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {        
            val = `$INSTANCE_NAME`_HOLDA_REG;
            val |= (uint32)(`$INSTANCE_NAME`_HOLDAM_REG) << 8u;
            val |= (uint32)(`$INSTANCE_NAME`_HOLDAH_REG) << 16u;
            
            /* SignExtend */
            if((val & `$INSTANCE_NAME`_SIGN_BIT) == `$INSTANCE_NAME`_SIGN_BIT)
            {    
				val |= `$INSTANCE_NAME`_SIGN_BYTE;
			}
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {      
            val = `$INSTANCE_NAME`_HOLDB_REG;
            val |= (uint32)`$INSTANCE_NAME`_HOLDBM_REG << 8u;
            val |= (uint32)`$INSTANCE_NAME`_HOLDBH_REG << 16u;
            
            /* SignExtend */
            if((val & `$INSTANCE_NAME`_SIGN_BIT) == `$INSTANCE_NAME`_SIGN_BIT)
            {
				val |= `$INSTANCE_NAME`_SIGN_BYTE;
			}
        }
        else
        {
            val = 0x0u;
        }
        return val;
    }

#else

    uint32 `$INSTANCE_NAME`_Read24(uint8 channel) `=ReentrantKeil($INSTANCE_NAME . "_Read24")`
    {
        uint32 val;
         
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {        
            val = `$INSTANCE_NAME`_HOLDA24_REG;
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {      
            val = `$INSTANCE_NAME`_HOLDB24_REG;
        }
        else
        {
            val = 0x0u;
        }
        return val;
    }

#endif /* defined(__C51__) || defined(__CX51__) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Write8
********************************************************************************
*
* Summary:
*  Set the value in one of the DFB Input Staging Registers 
*
* Parameters:  
*  channel:  Use either `$INSTANCE_NAME`_CHANNEL_A or 
*            `$INSTANCE_NAME`_CHANNEL_B as arguments to the function.  
*  sample:   The 8-bit, right justified input sample. 
*
* Return: 
*  void
*
* Note:
*  Order of the write is important.  On the load of the high byte, the DFB sets
*  the input ready bit.
*
*******************************************************************************/
void `$INSTANCE_NAME`_Write8(uint8 channel, uint8 sample) `=ReentrantKeil($INSTANCE_NAME . "_Write8")`
{
    if (channel == `$INSTANCE_NAME`_CHANNEL_A)
    {
        `$INSTANCE_NAME`_STAGEAH_REG = sample;
    }
    else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
    {
        `$INSTANCE_NAME`_STAGEBH_REG = sample;
    }
	else
	{
		/* No value is loaded on bad channel input */
	}
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Write16
********************************************************************************
*
* Summary:
*  Set the value in one of the DFB Input Staging Registers 
*
* Parameters:  
*  channel:  Use either `$INSTANCE_NAME`_CHANNEL_A or 
*            `$INSTANCE_NAME`_CHANNEL_B as arguments to the function.  
*  sample:   The 16-bit, right justified input sample. 
*
* Return: 
*  void
*
* Note:
*  Order of the write is important.  On the load of the high byte, the DFB sets
*  the input ready bit.
*
*******************************************************************************/
#if defined(__C51__) || defined(__CX51__)

    void `$INSTANCE_NAME`_Write16(uint8 channel, uint16 sample) `=ReentrantKeil($INSTANCE_NAME . "_Write16")`
    {
        /* Write the STAGE MSB reg last as it signals a complete wrote to the 
           DFB.*/
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {
            `$INSTANCE_NAME`_STAGEAM_REG = (uint8)(sample);
            `$INSTANCE_NAME`_STAGEAH_REG = (uint8)(sample >> 8u);
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {
            `$INSTANCE_NAME`_STAGEBM_REG = (uint8)(sample);
            `$INSTANCE_NAME`_STAGEBH_REG = (uint8)(sample >> 8u);
        }
        else
		{
			/* No value is loaded on bad channel input */
		}
    }

#else

    void `$INSTANCE_NAME`_Write16(uint8 channel, uint16 sample) `=ReentrantKeil($INSTANCE_NAME . "_Write16")`
    {
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {
            `$INSTANCE_NAME`_STAGEA16_REG = sample;
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {
            `$INSTANCE_NAME`_STAGEB16_REG = sample;
        }
        else
		{
			/* No value is loaded on bad channel input */
		}
    }

#endif /* defined(__C51__) || defined(__CX51__) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_Write24
********************************************************************************
*
* Summary:
*  Set the value in one of the DFB Input Staging Registers 
*
* Parameters:  
*  channel:  Use either `$INSTANCE_NAME`_CHANNEL_A or 
*            `$INSTANCE_NAME`_CHANNEL_B as arguments to the function.  
*  sample:   The 24-bit, right justified input sample inside of a uint32. 
*
* Return: 
*  void
*
* Note:
*  Order of the write is important.  On the load of the high byte, the DFB sets
*  the input ready bit.
*
*******************************************************************************/
#if defined(__C51__) || defined(__CX51__)

    void `$INSTANCE_NAME`_Write24(uint8 channel, uint32 sample) `=ReentrantKeil($INSTANCE_NAME . "_Write24")`
    {
        /* Write the STAGE LSB reg last as it signals a complete wrote to 
           the DFB.*/
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {
            `$INSTANCE_NAME`_STAGEA_REG  = (uint8)(sample);
            `$INSTANCE_NAME`_STAGEAM_REG = (uint8)(sample >> 8u);
            `$INSTANCE_NAME`_STAGEAH_REG = (uint8)(sample >> 16u);
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {
            `$INSTANCE_NAME`_STAGEB_REG = (uint8)(sample);
            `$INSTANCE_NAME`_STAGEBM_REG = (uint8)(sample >> 8u);
            `$INSTANCE_NAME`_STAGEBH_REG = (uint8)(sample >> 16u);
        }
        else
		{
			/* No value is loaded on bad channel input */
		}
    }

#else

    void `$INSTANCE_NAME`_Write24(uint8 channel, uint32 sample) `=ReentrantKeil($INSTANCE_NAME . "_Write24")`
    {
        if (channel == `$INSTANCE_NAME`_CHANNEL_A)
        {
            `$INSTANCE_NAME`_STAGEA24_REG = sample;
        }
        else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
        {
            `$INSTANCE_NAME`_STAGEB24_REG = sample;
        }
        else
		{
			/* No value is loaded on bad channel input */
		}
    }

#endif /* defined(__C51__) || defined(__CX51__) */


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetCoherency
********************************************************************************
*
* Summary:
*  Sets the DFB coherency register with the user provided input 
*
* Parameters:  
*  channel:  `$INSTANCE_NAME`_CHANNEL_A or `$INSTANCE_NAME`_CHANNEL_B
*  byteSelect:  High byte, Middle byte or Low byte as the key coherency byte.
*            
* Return: 
*  None.
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetCoherency(uint8 channel, uint8 byteSelect) `=ReentrantKeil($INSTANCE_NAME . "_SetCoherency")`
{
    if (channel == `$INSTANCE_NAME`_CHANNEL_A)
    {
        `$INSTANCE_NAME`_COHER_REG &= 
                (uint8)(~(uint8)(`$INSTANCE_NAME`_STAGEA_COHER_MASK | `$INSTANCE_NAME`_HOLDA_COHER_MASK));
        `$INSTANCE_NAME`_COHER_REG |= byteSelect;
        `$INSTANCE_NAME`_COHER_REG |= (uint8)((uint8)byteSelect << 4u);
    }
    else if (channel == `$INSTANCE_NAME`_CHANNEL_B)
    {
        `$INSTANCE_NAME`_COHER_REG &= 
                (uint8)(~(uint8)(`$INSTANCE_NAME`_STAGEB_COHER_MASK | `$INSTANCE_NAME`_HOLDB_COHER_MASK));
        `$INSTANCE_NAME`_COHER_REG |= (uint8)((uint8)byteSelect << 2u);
        `$INSTANCE_NAME`_COHER_REG |= (uint8)((uint8)byteSelect << 6u);
    }
    else
    {
        /* Invalid channel value */
    }
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetCoherencyEx
********************************************************************************
* 
* Summary:
*  Configures the DFB coherency register for each of the staging and holding 
*  registers. Allows multiple registers with the same configuration to be set 
*  at the same time. This API should be used when the coherency of the staging 
*  and holding register of a channel is different. 
*
* Parameters:  
*  regSelect: This parameter is used to specify the registers that will undergo
*             the change in coherency. These are maskable and multiple registers
*             with the same configuration can passed by performing an OR 
*             operation on the following definitions. 
*            `$INSTANCE_NAME`_STAGEA_COHER, 
*            `$INSTANCE_NAME`_STAGEB_COHER,
*            `$INSTANCE_NAME`_HOLDA_COHER,
*            `$INSTANCE_NAME`_HOLDB_COHER.
*  key: The key coherency byte that will be chosen for the register(s).
*       `$INSTANCE_NAME`_KEY_LOW, 
*       `$INSTANCE_NAME`_KEY_MID,
*       `$INSTANCE_NAME`_KEY_HIGH.
*            
* Return: 
*  None.
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetCoherencyEx(uint8 regSelect, uint8 key) `=ReentrantKeil($INSTANCE_NAME . "_SetCoherencyEx")`
{
    uint8 keyReg;
    
    keyReg = (uint8)(key << 2u) | key;
    keyReg |= (uint8)(keyReg << 4u);
    
    `$INSTANCE_NAME`_COHER_REG &= (uint8)~regSelect;
    `$INSTANCE_NAME`_COHER_REG |= keyReg & regSelect;
}


/*******************************************************************************
* Function Name: `$INSTANCE_NAME`_SetDalign
********************************************************************************
* 
* Summary:
*  Configures the DFB dalign register for each of the staging and holding 
*  registers. Allows multiple registers with the same configuration to be set
*  at the same time. 
*
* Parameters:  
*  regSelect: This parameter is used to specify the registers that will undergo
*             the change in data alignment. These are maskable and multiple 
*             registers with the same configuration can passed by performing 
*             an OR operation on the following definitions.
*             `$INSTANCE_NAME`_STAGEA_DALIGN, 
*             `$INSTANCE_NAME`_STAGEB_DALIGN,
*             `$INSTANCE_NAME`_HOLDA_DALIGN,
*             `$INSTANCE_NAME`_HOLDB_DALIGN.
*  state: The state is use to either enable the data alignment bits for the 
*         corresponding registers or to disable them.
*         `$INSTANCE_NAME`_ENABLED,
*         `$INSTANCE_NAME`_DISABLED
*            
* Return: 
*  None.
*
*******************************************************************************/
void `$INSTANCE_NAME`_SetDalign(uint8 regSelect, uint8 state) `=ReentrantKeil($INSTANCE_NAME . "_SetDalign")`
{    
    if (state == `$INSTANCE_NAME`_ENABLED)
    {
        `$INSTANCE_NAME`_DALIGN_REG |= regSelect;
    }
    else if (state == `$INSTANCE_NAME`_DISABLED)
    {
        `$INSTANCE_NAME`_DALIGN_REG &= (uint8)(~regSelect);
    }
    else
    {
        /* Invalid state */
    }
}

/* [] END OF FILE */

