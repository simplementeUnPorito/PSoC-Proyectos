#include "project.h"
#include "keyboard.h"
//#include "servo.h"
#include "rgb_lcd.h"
//#include "generic.h"
#include "arduinov2.h"

//Definiciones Logicas
#define TRUE  1
#define FALSE 0

#define MAX_BUFFER 100
char buffer[MAX_BUFFER];

#if defined (__GNUC__)
    asm(".global _printf_float");
#endif

uint16_t button = 0;


#define START 0
#define BIENVENIDA 1
#define MENU 2
#define MODO_LEER 3
#define MODO_GUARDAR_SELECCION 4
#define MODO_GUARDAR_EEPROM 5
#define MODO_LEER_SELECCION 6

#define ERROR 7 

#define MODO_SEGUIR 8
#define MODO_GUARDAR 9

#define ANGLE_PERILLA 8
#define ANGLE_3D 9
#define PERCENTAGE_PERILLA 10
#define PERCENTAGE_3D 11



uint8_t ventana = 0;


#define BIEN 0b01
#define MAL 0b10
#define NADA 0b11
volatile struct{
    uint8_t reset:1;   
    uint8_t key:2;
    uint8_t pot:1;
    uint8_t mode:1;
    uint8_t reportarError:1;
}flag;

#define elegirBarras(pot,mode) pot == 0?(mode == 0? ANGLE_PERILLA:ANGLE_3D):(mode == 0?PERCENTAGE_PERILLA:PERCENTAGE_3D)



uint8_t interpretarKey(uint16_t key){
    switch(ventana)
    {
        case START:
            if(key == ENTER_KEY){
                ventana = BIENVENIDA;
                
                return BIEN;
            }
            return MAL;
            
        case BIENVENIDA:
            return NADA;
        
        case MENU:
            switch(key){
                case KEY_1:
                    ventana = MODO_SEGUIR;
                    return BIEN;
                case KEY_2:
                    ventana = MODO_GUARDAR_SELECCION;
                    return BIEN;
                case KEY_3:
                    ventana = MODO_LEER_SELECCION;
                    return BIEN;
                case ESC_KEY:
                    ventana =START;
                    return BIEN;
                default:
                    return MAL;
            }
        case MODO_SEGUIR:
            if(key == ESC_KEY){
                ventana = MENU;
                return BIEN;
            }
            return MAL;
        case MODO_GUARDAR_SELECCION:
            switch(key){
                case KEY_1:
                    ventana = MODO_GUARDAR;
                    //cambiar vector de guardado
                    return BIEN;
                case KEY_2:
                    ventana = MODO_GUARDAR;
                    //cambiar vector de guardado
                    return BIEN;
                case ESC_KEY:
                    ventana = MENU;
                    return BIEN;
                default:
                    return MAL;
            }
        case MODO_GUARDAR:
            if(key == ENTER_KEY)
            {
                //hacer lo que haya que hacer para guardar
                return BIEN;
            }else if(key == ESC_KEY)
            {
                ventana = MENU;
                return BIEN;
            }
                return MAL;
        case MODO_LEER_SELECCION:
            switch(key){
                case KEY_1:
                    ventana = MODO_GUARDAR;
                    //cambiar vector para leer
                    return BIEN;
                case KEY_2:
                    ventana = MODO_GUARDAR;
                    //cambiar vector para leer
                    return BIEN;
                case ESC_KEY:
                    ventana = MENU;
                    return BIEN;
                default:
                    return MAL;
            }
        case MODO_LEER:
            if(key == ESC_KEY)
            {
                ventana = START;
                return BIEN;
            }
            return MAL;
        default:
            ventana = START;
            return NADA;
    }
    
}

CY_ISR(leerTeclado){
    timerTeclado_ClearPending();
    //static uint8_t contador = 0;
    char buffer[30];
    if(flag.key == NADA){
    uint16_t key = debouncer(keyboard_out_Write,keyboard_in_Read);
    echoButton(key,buffer,30,PC_PutString);
        if(key){
            flag.key = interpretarKey(key);
            if(flag.key == BIEN || flag.key == MAL)
            {
                resetRGB_Write(TRUE);
                if(flag.key == BIEN) flag.reset = TRUE;
                if(!(flag.key == BIEN && ventana== BIENVENIDA)){timerRGB_Enable();resetRGB_Write(FALSE);}
                if(flag.key == MAL) flag.reportarError = TRUE;
            }
            
                //echoButton(key,buffer,30,PC_PutString);
        }
    }
//    }
//    else{
//        if(contador == 0)
//        {
//            if(flag.keyError == BIEN){
//            }
//        }
//        if(contador<MAX_CONTADOR)
//        {
//            if(contador%2 == 0){
//                if(flag.keyError == MAL)
//                    LCD_setRGB(255, 0, 0);
//                else
//                    LCD_setRGB(0, 0, 255);
//            }
//            else
//                LCD_setRGB(255, 255, 255);
//            contador++;
//        }
//        else
//        {
//            contador = 0;
//            flag.keyError = NADA;
//        }
//   }
  
    //uint16_t key = debouncer(keyboard_out_Write,keyboard_in_Read);
    //echoButton(key,buffer,30,PC_PutString);
}

void printLCD(char* msup,char* minf){
    static char msg[16];
    
    strncpy(msg,msup,16);
    LCD_setCursor(0, 0);
    LCD_print(msg, strlen(msg));
    
    strncpy(msg,minf,16);
    LCD_setCursor(0, 1);
    LCD_print(msg, strlen(msg));
    
}

#define DELAY_ARCOIRIS 1
void efectoArcoiris() {

    // Rango de colores del arcoíris
    for (int i = 0; i < 255; i++) {
        LCD_setRGB(255, i, 0);  // Rojo a amarillo
        CyDelay(DELAY_ARCOIRIS);
    }

    for (int i = 255; i >= 0; i--) {
        LCD_setRGB(i, 255, 0);  // Amarillo a verde
        CyDelay(DELAY_ARCOIRIS);
    }

    for (int i = 0; i < 255; i++) {
        LCD_setRGB(0, 255, i);  // Verde a cian
        CyDelay(DELAY_ARCOIRIS);
    }

    for (int i = 255; i >= 0; i--) {
        LCD_setRGB(0, i, 255);  // Cian a azul
        CyDelay(DELAY_ARCOIRIS);
    }

    for (int i = 0; i < 255; i++) {
        LCD_setRGB(i, 0, 255);  // Azul a magenta
        CyDelay(DELAY_ARCOIRIS);
    }

    for (int i = 255; i >= 0; i--) {
        LCD_setRGB(255, 0, i);  // Magenta a rojo
        CyDelay(DELAY_ARCOIRIS);
    }
}

extern uint8_t smiley[8];
void myStart()
{
    PC_Start();
    PC_PutStringConst("Iniciando...\n\r");
    /*
    //Servos
    PWM1_Start();
    PWM2_Start();
    */
    
    //Pantalla LCD
    I2C_LCD_Start();
    LCD_begin(16, 2, LCD_5x8DOTS);
    LCD_clear();
    CyDelay(2000);
    LCD_setRGB(255, 255, 255);
    LCD_createChar(0, smiley);
    timerRGB_Start();
    resetRGB_Write(FALSE);
    
    //Arduino
    Arduino_Start();
    TimerSerial_Init();
    
    arduino_message_Start();
    arduino_message_StartEx(responderArduino);
    arduino_message_Enable();
    
    timerCompleted_Start();
    timerCompleted_StartEx(reenviarArduino);
    timerCompleted_Enable();
    
    
    //Teclado
    Timer20ms_Start();
    timerTeclado_Start();
    timerTeclado_StartEx(leerTeclado);
    timerTeclado_Enable();
    button = 0;
    
    //Globales
    flag.reset = TRUE;
    flag.key = NADA;
    flag.reportarError = FALSE;
    LCD_setRGB(255,255,255);
    PC_PutStringConst("Inicio Finalizado\n\r");
     CyDelay(100);
}

void updateDisplay(){
    switch(ventana){
        case START:
            flag.reset = FALSE;
            CyDelay(100);
            printLCD("Presione Enter  ","para iniciar   ");
            LCD_write(0);
            changeAnimation(START);
            break;
        case BIENVENIDA:
            printLCD("Bienvenido!     ","Aqui Vamos!     ");
            changeAnimation(BIENVENIDA);
            efectoArcoiris();
            ventana = MENU;
            flag.reset = TRUE;
            flag.key = NADA;
            break;
        case MENU:
            flag.reset = FALSE;
            printLCD("1Seguir 2Guardar","3Leer   ESCStart");
            LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MENU);
            //CyDelay(200);
            break; 
        case MODO_SEGUIR:
            printLCD("Siguiendo...    ","Activado        ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(elegirBarras(flag.pot,flag.mode));
            //CyDelay(200);
            break;
        case MODO_GUARDAR_SELECCION:
            flag.reset = FALSE;
            printLCD("Seleccione donde","guardar: 1 o 2  ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MODO_GUARDAR_SELECCION);
            break;
        case MODO_GUARDAR:
            //if(flag.reset == TRUE){
            flag.reset = FALSE;
            printLCD("Guarde con ENT  ","ESC para salir  ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(elegirBarras(flag.pot,flag.mode));
            break;
        case MODO_LEER_SELECCION:
            //if(flag.reset == TRUE){
            flag.reset = FALSE;
            printLCD("Seleccione cual ","leer: 1 o 2     ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MODO_LEER_SELECCION);
            //CyDelay(200);
            //}
            break;
        case MODO_LEER:
            //if(flag.reset == TRUE){
            flag.reset = FALSE;
            printLCD("Leyendo...      ","ESC para salir  ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MODO_LEER);
                
            //}
            break;
        default:
            ventana = START;
    }
    CyDelay(200);
    
}

void changeRGB(){
    static uint8_t contador = 0;
    resetRGB_Write(TRUE);
    if(contador++%2==0){
        switch(flag.key){
            case BIEN:
                LCD_setRGB(0, 255, 0);  // Cambiar el color a verde
                break;
            case MAL:
                LCD_setRGB(255, 0, 0);  // Cambiar el color a rojo
                break;
            default:
                LCD_setRGB(255, 255, 255);  // Cambiar el color a blanco
        }
    }
    else
        LCD_setRGB(255, 255, 255);  // Cambiar el color a blanco
    
    if(contador>=4){
        flag.key = NADA;
        contador = 0;
    }else{
        timerRGB_Enable();
        resetRGB_Write(FALSE);
    }
}

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    myStart();
    //demostracionLCD();
    
    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    changeAnimation(START);
    for(;;)
    {
        if(flag.reset){
            flag.reset = 0;
            updateDisplay();
        }
        if(flag.reportarError == TRUE){
            flag.reportarError = FALSE;
            changeAnimation(ERROR);
        }
        if(flag.key != NADA&& RGB_Read() == 1){
            resetRGB_Write(TRUE);
            changeRGB();
        }
            
    }
}
