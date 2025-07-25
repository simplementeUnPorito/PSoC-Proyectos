#ifndef ARDUINO_H
#define ARDUINO_H
    #include "project.h"
    
    #define CHANGE_ANIMATION 5
    #ifndef FALSE
        #define FALSE 0
    #endif
    #ifndef TRUE
        #define TRUE 1
    #endif
    #define START_LISTEN 0
    
    /*Define your macro callbacks here */
    /*For more information, refer to the Writing Code topic in the PSoC Creator Help.*/
    CY_ISR_PROTO(responderArduino);
    CY_ISR_PROTO(reenviarArduino);
    void changeAnimation(uint8_t new_animation);
    void start_arduino();
    
#endif /* CYAPICALLBACKS_H */   