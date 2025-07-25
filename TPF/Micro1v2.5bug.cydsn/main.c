#include "project.h"
#include "keyboard.h"
//#include "servo.h"
#include "rgb_lcd.h"
//#include "generic.h"
//#include "Arduino.h"

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
#define MODO_SEGUIR 3
#define MODO_GUARDAR_SELECCION 4
#define MODO_GUARDAR 5
#define MODO_LEER_SELECCION 6
#define MODO_LEER 7
#define ERROR 8
uint8_t ventana = 0;

#define BIEN 0b01
#define MAL 0b10
#define NADA 0b11
volatile struct{
    uint8_t reset:1;   
    uint8_t keyError:2;
}flag;




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
                default:
                    return MAL;
            }
        case MODO_GUARDAR:
            if(key == ENTER_KEY)
            {
                //hacer lo que haya que hacer para guardar
                return BIEN;
            }else
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

#define MAX_CONTADOR 2
CY_ISR(leerTeclado){
    static uint8_t contador = 0;
    char buffer[30];
    if(flag.keyError == NADA){
        uint16_t key = debouncer(keyboard_out_Write,keyboard_in_Read);
        if(key){
            flag.keyError = interpretarKey(key);
            echoButton(key,buffer,30,PC_PutString);
            if(flag.keyError == BIEN)
                flag.reset = TRUE;
        }
    }
    else{
        if(contador<MAX_CONTADOR)
        {
            if(contador++%2 == 0){
                if(flag.keyError == MAL)
                    LCD_setRGB(255, 0, 0);
                else
                    LCD_setRGB(0, 0, 255);
            }
            else
                LCD_setRGB(255, 255, 255);
        }
        else
        {
            contador = 0;
            flag.keyError = NADA;
        }
    }
        
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
    PWM1_Start();
    PWM2_Start();
    I2C_LCD_Start();

    // Inicializar el LCD (16 columnas, 2 filas)
    LCD_begin(16, 2, LCD_5x8DOTS);

    // Limpiar la pantalla LCD antes de imprimir
    LCD_clear();

    // Crear el carácter personalizado en la ubicación 0 de CGRAM
    LCD_createChar(0, smiley);
    button = 0;
    
    Arduino_Start();
    TimerSerial_Init();
    
//    arduino_message_Start();
//    arduino_message_StartEx(responderArduino);
//    arduino_message_Enable();
//    
//    timerCompleted_Start();
//    timerCompleted_StartEx(reenviarArduino);
//    timerCompleted_Enable();
    
    timerTeclado_Start();
    timerTeclado_StartEx(leerTeclado);
    timerTeclado_Enable();
    flag.reset = TRUE;
    flag.keyError = NADA;
}


int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    myStart();
    //demostracionLCD();
    
    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    for(;;)
    {
        
        switch(ventana){
            case START:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Presione Enter","para iniciar");
                    LCD_write(0);
                    //changeAnimation(START);
                    LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
                }
                break;
            case BIENVENIDA:
                if(flag.reset == TRUE){
                    printLCD("Bienvenido!","Aqui Vamos!");
                    //changeAnimation(BIENVENIDA);
                    efectoArcoiris();
                    ventana = MENU;
                }
                break;
            case MENU:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("1Seguir 2Guardar","3Leer   ESCStart");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MENU);
                }
                break;
            case MODO_SEGUIR:
                 if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Siguiendo...","Activado");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MODO_SEGUIR);
                }
                break;
            case MODO_GUARDAR_SELECCION:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Seleccione donde","guardar: 1 o 2");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MODO_GUARDAR_SELECCION);
                }
                break;
            case MODO_GUARDAR:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Guarde con ENT","ESC para salir");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MODO_GUARDAR);
                }
                break;
            case MODO_LEER_SELECCION:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Seleccione cual","leer: 1 o 2");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MODO_LEER_SELECCION);
                }
                break;
            case MODO_LEER:
                if(flag.reset == TRUE){
                    flag.reset = FALSE;
                    printLCD("Leyendo...","ESC para salir");
                    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
                    //changeAnimation(MODO_LEER);
                }
                break;
            default:
                ventana = START;
        }
        
        
    }
}
