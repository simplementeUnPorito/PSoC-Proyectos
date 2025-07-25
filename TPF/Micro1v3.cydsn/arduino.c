#include "arduino.h"
#include "project.h"

uint8_t animacion;
CY_ISR(responderArduino)
{
    static uint8_t confirmacionPendiente = FALSE;
    arduino_message_ClearPending();
    if(confirmacionPendiente == FALSE){
        if(Arduino_GetChar() == START_LISTEN){
            Arduino_WriteTxData(animacion);
            confirmacionPendiente = TRUE;
        }
    }else
    {
        if(Arduino_GetChar() != animacion)
            TimerSerial_Enable();
        confirmacionPendiente = FALSE;
            
    }
    
}
CY_ISR(reenviarArduino)
{
    Arduino_PutChar(CHANGE_ANIMATION);
}

void changeAnimation(uint8_t new_animation)
{
    animacion = new_animation;
    Arduino_PutChar(CHANGE_ANIMATION);
    
}