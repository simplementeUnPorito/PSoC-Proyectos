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
