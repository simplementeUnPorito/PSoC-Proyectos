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
void enviarAnimacion(){
    Arduino_PutChar(animacion);  // Iniciar solicitud de cambio
    mensajeRecibido = animacion !=7?FALSE:TRUE;
}
void changeAnimation(uint8_t new_animation) {
    resetSerial_Write(1);
    TimerSerial_WritePeriod(100);
    animacion = new_animation;  // Asignar nueva animación
    enviarAnimacion();
    resetSerial_Write(0);
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
    
    resetSerial_Write(0);
}
