/* ============================================================================
 *   SeroalPlot v0.0 custom component
 *
 * Description:
 *   Implements interface for serial communication with SerialPlot charting software
 *   Uses UART communication to send data types:
         int8, int16, int32, uint8, uint16, uin32, float
 *   in:
 *      -single binary format 
 *      -custom frame (+header, +checksum)
 *      -ASCII
 *
 *
 * Credits:
 *   Serial PLOT v0.10.0
 *   by Yavuz Ozderya
 *   https://bitbucket.org/hyOzd/serialplot   
 *
 * ============================================================================
 * PROVIDED AS-IS, NO WARRANTY OF ANY KIND, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 * FREE TO SHARE, USE AND MODIFY UNDER TERMS: CREATIVE COMMONS - SHARE ALIKE
 * ============================================================================
*/


#ifndef `$INSTANCE_NAME`_H
#define `$INSTANCE_NAME`_H
 
    
#include <project.h>
#include <cytypes.h>
           
#define true  1
#define false 0

/***************************************
*        read-only parameters
***************************************/  

#define `$INSTANCE_NAME`_DataFormat      `=$DataFormat `           // Output data format. simple binary / ASCII / custom frame. 
#define `$INSTANCE_NAME`_DataType        `=$DataType   `           // Output data type: int8(uint8), int16(uint16), int32(uint32) and float.  
#define `$INSTANCE_NAME`_NumChan         `=$NumChannels`           // Number of output channels. Valid range [1 to 8].  
#define `$INSTANCE_NAME`_Checksum        `=$Checksum   `           // Enable data frame checksum.  
//#define `$INSTANCE_NAME`_UART            `=$UART       `           // instance name of UART used for communication   
//#define `$INSTANCE_NAME`_UART_mode       `=$UART_mode  `           // UART mode: Tx, Rx, Tx+Rx   
//#define `$INSTANCE_NAME`_range           `=$data_t     `           // int8, int16, int32, float32(single)      
//#define `$INSTANCE_NAME`_FrameHeader     `=$FrameHeader`           // Frame header: 0xAA, 0xBB       
//#define `$INSTANCE_NAME`_FrameHeaderSize `=$FrameHeaderSize`       // Frame header size       
//#define `$INSTANCE_NAME`_ArgsList        `=$Args`                  // arguments list (debug..)
//#define `$INSTANCE_NAME`_ValsList        `=$Vals`                  // values list (debug..)
//#define `$INSTANCE_NAME`_FormatStr       `=$FormatStr`             // ASCII format string (debug..)
  


    
/***************************************
*        global variables
***************************************/  

    


/***************************************
*        read-only variables
***************************************/  
   
 
    
/***************************************
*        Function Prototypes
***************************************/

void  `$INSTANCE_NAME`_Plot(`=$Args`); // universal overload procedure 
 



    
#endif /* `$INSTANCE_NAME`_H */


/* [] END OF FILE */
