#include "arduino.h"
#include "project.h"

uint8_t animacion;
uint8_t mensajeRecibido;
CY_ISR(responderArduino) {
    arduino_message_ClearPending();
    if(Arduino_GetChar() == animacion)
        mensajeRecibido = TRUE;
    
}

CY_ISR(reenviarArduino) {
    if(mensajeRecibido == FALSE)
        Arduino_PutChar(animacion);  // Reenviar solicitud de cambio
}

void changeAnimation(uint8_t new_animation) {
    animacion = new_animation;  // Asignar nueva animación
    Arduino_PutChar(animacion);  // Iniciar solicitud de cambio
    mensajeRecibido = FALSE;
    TimerSerial_Enable();  // Habilitar temporizador de reenvío en caso de fallo
}

void start_arduino()
{
    //Arduino
    Arduino_Start();
    TimerSerial_Init();
    
    arduino_message_Start();
    arduino_message_StartEx(responderArduino);
    arduino_message_Enable();
    
    timerCompleted_Start();
    timerCompleted_StartEx(reenviarArduino);
    timerCompleted_Enable();   
}
