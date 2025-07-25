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

#include <`$INSTANCE_NAME`.h> // must specify API prefix in Symbol->Properties->Doc.APIPrefix
#include <stdio.h>      // sformat (ASCII mode only)



//====================================
//        private definitions
//====================================
#define `$INSTANCE_NAME`_DataPacketSize   `=$data_packet_size`  // size of sinle data packet (slice)  

#define _SimpleBinary  (0x00u)
#define _ASCII         (0x01u)
#define _CustomFrame   (0x02u)
    

//====================================
//        private variables
//====================================

  
//====================================
//        private functions
//====================================





#if ((`$INSTANCE_NAME`_DataFormat==_SimpleBinary) & (`$INSTANCE_NAME`_DataPacketSize==1) )
//==============================================================================
// Unique function to send data in Simple Binary format, int8 (uint8), N=1       
// this is simplest and fastest format, which does not need
// neither header nor checksum to transmit the data
//==============================================================================
void `$INSTANCE_NAME`_Plot(`=$Args`)
{
    // Format:      Simple Binary
    // Channels:    1
    // Number Type: `=$data_t`
    // Endianness:  Little Endian

    `=$UART`_PutChar(V1);    // unique 8-bit case
}
#endif





#if ((`$INSTANCE_NAME`_DataFormat==_SimpleBinary) & (`$INSTANCE_NAME`_DataPacketSize!=1) )
//==============================================================================
// Universal parametrized function to send data in Single Binary Frame format
// excluding unique combination of data packet size=1: int8 (uint8), N=1
//    
// This mode of operation does not guarantee coerrect data transmission
// all received data may be corrupted due to a loss of a single byte    
//    
// works for NumChan = 1 to 8
// Args - arguments list: "int8 V1, int8 V2,.." 
// Vals - values list   : "V1, V2,.."
//==============================================================================
void `$INSTANCE_NAME`_Plot(`=$Args`) 
{   
    // Format:      Simple Binary
    // Channels:    `=$NumChannels`
    // Number Type: `=$data_t`
    // Endianness:  Little Endian

    `=$data_t` val[`=$NumChannels`] = {`=$Vals`};  
 
    `=$UART`_PutArray((uint8 *) &val, sizeof(val)); // send data as array of char
}
#endif




#if ((`$INSTANCE_NAME`_DataFormat==_CustomFrame) & (!`$INSTANCE_NAME`_Checksum))
//==============================================================================
// Universal parametrized function to send data in Custom Frame format
// works for NumChan = 1 to 8
// Args - arguments list: "int8 V1, int8 V2,.." 
// Vals - values list   : "V1, V2,.."
//==============================================================================
void `$INSTANCE_NAME`_Plot(`=$Args`) 
{
    // todo: use customizer to extract number of bytes in the header?
    
    // Format:      Custom Frame
    // Frame Start: `=$FrameHeader`
    // Channels:    `=$NumChannels`
    // Frame Size:  Fixed, Size=`=$FrameFixedSize`
    // Number Type: `=$data_t`
    // Endianness:  Little Endian
    // Checksum:    `=$Checksum`

    struct {
        uint8    head[`=$FrameHeaderSize`];
        `=$data_t`  val[`=$NumChannels`];
    } __attribute__ ((packed)) Frame  = { {`=$FrameHeader`}, {`=$Vals`} };  

    
    `=$UART`_PutArray((uint8 *) &Frame, sizeof(Frame)); // send data Frame as array of char
}





#elif ((`$INSTANCE_NAME`_DataFormat==_CustomFrame) & (`$INSTANCE_NAME`_Checksum))
//==============================================================================
// Universal parametrized function to send data in Custom Frame format w/Checksum
// works for NumChan = 1 to 8
// Args - arguments list: "int8 V1, int8 V2,.." 
// Vals - values list   : "V1, V2,.."
//==============================================================================
void `$INSTANCE_NAME`_Plot(`=$Args`) 
{ 
    // Format:      Custom Frame
    // Frame Start: `=$FrameHeader`
    // Channels:    `=$NumChannels`
    // Frame Size:  Fixed, Size=`=$FrameFixedSize` 
    // Number Type: `=$data_t`
    // Endianness:  Little Endian
    // Checksum:    `=$Checksum`

    struct {
        uint8    head[`=$FrameHeaderSize`];     
        `=$data_t`  val[`=$NumChannels`];       
        uint8   CS; // checksum
    } __attribute__ ((packed)) Frame  = { {`=$FrameHeader`}, {`=$Vals`}, 0};  

    
    // get sum of all bytes in val[] array
    uint8 * pVal = (uint8 *) &Frame.val[0];             // pointer to val[] start
    uint8 * pCS  = (uint8 *) &Frame.CS;                 // pointer to val[] stop
    while (pVal < pCS) { * pCS += * pVal++; }           // add val[] bytes to checksum
    
    
    `=$UART`_PutArray((uint8 *) &Frame, sizeof(Frame)); // send data Frame as array of char
}





#elif   (`$INSTANCE_NAME`_DataFormat==_ASCII)
//==============================================================================
// Universal parametrized function to send data in ASCII format, N = 1..8 
// (floats need newlib nano + heapsize 0x200)
//
// Format:      ASCII
// Channels:    1-8
// ChDelimiter: "," 
//    
// Args      - arguments list: "int8 V1, int8 V2" 
// FormatStr - format string : "%d,%d\r\n" 
// Vals      - values list   : "V1, V2"

//==============================================================================
void `$INSTANCE_NAME`_Plot(`=$Args`) 
{  
    // Format:      ASCII
    // Channels:    `=$NumChannels`
    // Delimiter:   comma

    char abuff[`=$bufflen`];    // output UART buffer // todo: static? 

    sprintf(abuff, `=$FormatStr`, `=$Vals`);   
    `=$UART`_PutString(abuff);          
}
#endif



/* [] END OF FILE */



