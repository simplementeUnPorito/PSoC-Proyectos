#include "project.h"
#include "keyboard.h"
//#include "servo.h"
#include "rgb_lcd.h"
//#include "generic.h"
#include "arduinov2.h"
#include "servov2.h"
#include "crc.h"
#include "eeprom_v.h"

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
#define REINICIAR 12

#define ERROR 7 

#define MODO_SEGUIR 8
#define MODO_GUARDAR 9

#define ANGLE_PERILLA 8

#define PERCENTAGE_PERILLA 10

#ifdef _3D
#define ANGLE_3D 9
#define PERCENTAGE_3D 11
#endif

#define ANGLE 0
#define PERCENTAGE 1

uint8_t ventana = 0;


#define BIEN 0b01
#define MAL 0b10
#define NADA 0b11
volatile struct{
    uint8_t reset:1;   
    uint8_t key:2;
    union{
        uint8_t all:5;
        struct{
            uint8_t pot:1;
            uint8_t mode:1;
            uint8_t vector:1;
            uint8_t vectoresGuardado:2;
            uint8_t desensibilizacion:2;
            //uint8_t velocidadLenta:1;
        }bit;
    }config;
    union{
        uint8_t all:3;
        struct{
            uint8_t pot:1;
            uint8_t mode:1;
            uint8_t desensibilizacion:1;
            //uint8_t velocidadLenta:1;

        }bit;
    }cambio;
    
    uint8_t reportarError:1;
}flag;
ListaMovimiento guardado[2];

uint8_t guardarPosicionActual() {
    
    
    // Verificar si el índice actual está dentro del rango del vector
    if (guardado[flag.config.bit.vector].lenLista < MAX_LEN_LISTA) {
        // Guardar la posición actual de los potenciómetros
        guardado[flag.config.bit.vector].lista[guardado[flag.config.bit.vector].lenLista] = pot;

        // Incrementar el índice de la lista de guardado
        guardado[flag.config.bit.vector].lenLista++;
        return TRUE;
    } else {
        // Manejar el caso en que el vector esté lleno (opcional)
        // Puedes mostrar un mensaje en el LCD o activar un LED como notificación
        return FALSE;
    }
}

uint8_t recuperarEEPROM(){
    uint16_t crcAlmacenado,crcCalculado;
    ListaMovimiento guardadoAux[2];
    leerEEPROM((uint8_t*)guardadoAux,sizeof(guardadoAux),&crcAlmacenado);
    crcCalculado = crc16((uint8_t*)guardadoAux,sizeof(guardadoAux));
    if(crcCalculado == crcAlmacenado){
        memcpy(guardado, guardadoAux, sizeof(guardado));
        if(guardado[0].lenLista>0)
            flag.config.bit.vectoresGuardado |=0b01;
        if(guardado[1].lenLista>0)
            flag.config.bit.vectoresGuardado |=0b10;
        
        
        return TRUE;
    }
    
    return FALSE;   
}
uint8_t guardarEEPROM(){
    uint16_t crcValue = crc16((uint8_t*)guardado,sizeof(guardado));
    int status = escribirEEPROM((uint8_t*)guardado, sizeof(guardado), crcValue);

    return (status == CYRET_SUCCESS)?TRUE:FALSE;   
}

uint8_t interpretarKey(uint16_t key){
    switch(ventana)
    {
        case START:
            if(key == ENTER_KEY){
                ventana = BIENVENIDA;
                
                return BIEN;
            }else if(key == STAR_KEY){
                ventana = REINICIAR;
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
                case HASH_KEY:
                    ventana =MODO_GUARDAR_EEPROM;
                    return BIEN;
                /*case KEY_0:
                    flag.config.bit.velocidadLenta = TRUE;
                    flag.cambio.bit.velocidadLenta = TRUE;
                    return BIEN;*/
                case UP_ARROW:
                    if(flag.config.bit.desensibilizacion!=0b11){
                        flag.config.bit.desensibilizacion++;
                        flag.cambio.bit.desensibilizacion = TRUE;
                        return BIEN;
                    }
                    return MAL; 
                case STAR_KEY:
                    ventana = REINICIAR;
                    return BIEN;
                    
                case DOWN_ARROW:
                    if(0!=flag.config.bit.desensibilizacion){
                        flag.config.bit.desensibilizacion--;
                        flag.cambio.bit.desensibilizacion = TRUE;
                        return BIEN;
                    }
                    return MAL;
                case F1_KEY:
                    flag.config.bit.pot = PERILLA;
                    flag.config.bit.pot = TRUE;
                    return BIEN;
                #ifdef _3D
                case F2_KEY:
                    flag.pot = _3D;
                    flag.cambioPot = TRUE;
                    return BIEN;
                #endif
                case LEFT_ARROW:
                    flag.config.bit.mode = ANGLE;
                    flag.cambio.bit.mode = TRUE;
                    return BIEN;
                case RIGHT_ARROW:
                    flag.config.bit.mode = PERCENTAGE;
                    flag.cambio.bit.mode =TRUE;
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
                    flag.config.bit.vector = 0;
                    guardado[0].indiceActual = 0;
                    guardado[0].lenLista = 0;
                    //flag.cambio.bit.vector = TRUE;
                    return BIEN;
                case KEY_2:
                    ventana = MODO_GUARDAR;
                    flag.config.bit.vector = 1;
                    guardado[1].indiceActual = 0;
                    guardado[1].lenLista = 0;
                    //flag.cambio.bit.vector = TRUE;
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
                guardarPosicionActual();
                
                return BIEN;
            }else if(key == ESC_KEY)
            {
                ventana = MENU;
                if(flag.config.bit.vector == 0 && guardado[0].lenLista>0)
                    flag.config.bit.vectoresGuardado |=0b01;
                else if(flag.config.bit.vector == 1 && guardado[1].lenLista>0)
                    flag.config.bit.vectoresGuardado |=0b10;
                return BIEN;
            }
                return MAL;
        case MODO_LEER_SELECCION:
            switch(key){
                case KEY_1:
                    if((flag.config.bit.vectoresGuardado&0b01) != FALSE){
                        ventana = MODO_LEER;
                        flag.config.bit.vector = 0;
                        guardado[0].indiceActual = 0;
                        //flag.cambio.bit.vector = TRUE;
                        return BIEN;
                    }
                    return MAL;
                case KEY_2:
                    if((flag.config.bit.vectoresGuardado&0b10) != FALSE){
                        ventana = MODO_LEER;
                        flag.config.bit.vector = 1;
                        guardado[1].indiceActual = 0;
                        //flag.cambio.bit.vector = TRUE;
                        return BIEN;
                    }
                    return MAL;
                case ESC_KEY:
                    ventana = MENU;
                    return BIEN;
                default:
                    return MAL;
            }
        case MODO_LEER:
            if(key == ESC_KEY)
            {
                ventana = MENU;
                guardado[flag.config.bit.vector].indiceActual = 0;
                return BIEN;
            }
            return MAL;
        case MODO_GUARDAR_EEPROM:
            if(key == KEY_1&& recuperarEEPROM())
                return BIEN;
            else if(key == KEY_2&&flag.config.bit.vectoresGuardado!=0 && guardarEEPROM() == TRUE)
                return BIEN;
                
            else if(key == ESC_KEY)
            {
                ventana = MENU;
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
    if(key == KEY_0){
        Reset_Write(0b10);
        CyDelay(500);
        Reset_Write(0b00);
        CyDelay(1000);   
    }
    //echoButton(key,buffer,30,PC_PutString);
        if(key){
            uint8_t ventanaAnterior = ventana;
            flag.key = interpretarKey(key);
            if(flag.key == BIEN || flag.key == MAL)
            {
                resetRGB_Write(TRUE);
                if(flag.key == BIEN&& ventanaAnterior!=ventana) flag.reset = TRUE;
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
    
    
    
    
    start_servo();
    start_LCD();
    start_arduino();
    
    
    //Teclado
    Timer20ms_Start();
    timerTeclado_Start();
    timerTeclado_StartEx(leerTeclado);
    timerTeclado_Enable();
    button = 0;
    
    EEPROM_Start();
    //Globales
    flag.reset = TRUE;
    flag.key = NADA;
    flag.reportarError = FALSE;
    flag.config.all = 0;
    flag.cambio.all = 0;
    LCD_setRGB(255,255,255);
    PC_PutStringConst("Inicio Finalizado\n\r");
    updateModeServo(PERILLA);
    CyDelay(100);
}
void elegirBarras()
{
    if(flag.config.bit.mode == PERCENTAGE && flag.config.bit.pot == PERILLA)
        changeAnimation(PERCENTAGE_PERILLA);
    else if(flag.config.bit.mode  == ANGLE && flag.config.bit.pot == PERILLA)
        changeAnimation(ANGLE_PERILLA);
    #ifdef _3D
    else if(flag.mode == PERCENTAGE && flag.pot == _3D)
        changeAnimation(PERCENTAGE_3D);
    else if(flag.mode  == ANGLE && flag.pot == _3D)
        changeAnimation(ANGLE_3D);
    #endif
}
void updateDisplay(){
    char bufferGuardar[16];
    switch(ventana){
        case START:
            flag.reset = FALSE;
            CyDelay(100);
            printLCD("Presione Enter  ","para iniciar   ");
            LCD_write(0);
            changeAnimation(START);
            break;
        case BIENVENIDA:
            changeAnimation(BIENVENIDA);
            printLCD("Bienvenido!     ","Aqui Vamos!     ");
            efectoArcoiris();
            ventana = MENU;
            flag.reset = TRUE;
            flag.key = NADA;
            break;
        case MENU:
            flag.reset = FALSE;
            printLCD("1Seguir 2Guardar","3Leer   #EEPROM ");
            LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MENU);
            //CyDelay(200);
            break; 
        case MODO_SEGUIR:
            printLCD("Siguiendo...    ","Activado        ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            elegirBarras();
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
            LCD_setCursor(14,0);
            LCD_print("   ",3);
            snprintf(bufferGuardar,16,"Guardar:ENT  %i",guardado[flag.config.bit.vector].lenLista);
            //PC_PutString(bufferGuardar);
            flag.reset = FALSE;
            printLCD(bufferGuardar,"ESC para salir  ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            elegirBarras();
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
            /*
            LCD_setCursor(13,0);
            LCD_print("   ",3);
            snprintf(bufferGuardar,16,"Leyendo...   ",guardado[flag.config.bit.vector].indiceActual);
            */
            printLCD("Leyendo...      ","ESC para salir  ");
            //LCD_setRGB(255, 255, 255);  // Cambiar el color a azul
            changeAnimation(MODO_LEER);
                
            //}
            break;
        case REINICIAR:
            flag.reset = FALSE;
            changeAnimation(MENU);
            LCD_setRGB(255, 0, 255);
            printLCD("Reiniciando...    ","Espere por favor");
            Reset_Write(0b10);
            CyDelay(500);
            Reset_Write(0b00);
            CyDelay(1000);
            break;
        case MODO_GUARDAR_EEPROM:
            flag.reset = FALSE;
            printLCD("Elija que hacer:","1Cargar  2Salvar");
            changeAnimation(MODO_GUARDAR_EEPROM);
            break;
        default:
            ventana = START;
    }
    CyDelay(50);
    
    
}

void changeRGB(){
    static uint8_t contador = 0;
    resetRGB_Write(TRUE);
    if(contador++%2==0){
        switch(flag.key){
            case BIEN:
                if(flag.cambio.bit.desensibilizacion== TRUE){
                    switch(flag.config.bit.desensibilizacion){
                        case 0:
                            LCD_setRGB(0, 0, 50);  // Color azul oscuro
                            break;
                        case 1:
                            LCD_setRGB(0, 0, 255);  // Azul oscuro más brillante
                            break;
                        case 2:
                            LCD_setRGB(50, 150, 255);  // Celeste intermedio
                            break;
                        case 3:
                            LCD_setRGB(100, 200, 255);  // Celeste brillante
                            break;
                        default:
                            LCD_setRGB(150, 220, 255);  // Celeste claro aún más brillante
                            break;

                    }
                }
                else if(flag.cambio.bit.mode == TRUE)
                    switch(flag.config.bit.mode)
                    {
                        case ANGLE:
                            LCD_setRGB(255, 255, 0);  // Color azul oscuro
                            break;
                        case PERCENTAGE:
                            LCD_setRGB(0, 255, 255);  // Color azul oscuro
                            break;
                    }
                else if(flag.cambio.bit.pot == TRUE)
                {
                    switch(flag.config.bit.pot)
                    {
                        case PERILLA:
                            LCD_setRGB(255, 100, 255);  // Color azul oscuro
                            break;
                        #ifdef _3D
                        case _3D:
                            LCD_setRGB(255, 200, 255);  // Color azul oscuro
                            break;
                        #endif
                    }
                }/*
                else if(flag.cambio.bit.vector == TRUE){
                    switch(flag.config.bit.vector)
                    {
                        case 0:
                            LCD_setRGB(150, 0, 0);  // Color azul oscuro
                            break;
                        case 1:
                            LCD_setRGB(50, 0, 0);  // Color azul oscuro
                            break;
                    }
                }*/
                else
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
        flag.cambio.all = FALSE;
        contador = 0;
    }else{
        timerRGB_Enable();
        resetRGB_Write(FALSE);
        if(ventana == REINICIAR){
            Reset_Write(0b00);
        }
    }
}




void doStuff(){
    char bufferAux[3];
    switch(ventana){
        case MODO_SEGUIR:
        case MODO_GUARDAR:
            seguirPot(flag.config.bit.desensibilizacion);
            break;
        
        case MODO_LEER:
            //moverLento(TRUE);
            if(seguirLista(&guardado[flag.config.bit.vector])){
                LCD_setCursor(13,0);
                LCD_print("    ",3);
                LCD_setCursor(13,0);
                snprintf(bufferAux,3,"%i",guardado[flag.config.bit.vector].indiceActual);
                LCD_print(bufferAux,3);
                CyDelay(100);
                
            }
                
            break;
        case START:
        case MENU:
            PWM1_WriteCompare1(PWM_MAX); //MUNNECA
            PWM2_WriteCompare1(PWM_MIN); //PINZA
            PWM1_WriteCompare2(PWM_MAX); //CODO
            PWM2_WriteCompare2(PWM_MAX); //BASE
            break;
    }
}


int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    myStart();
    //demostracionLCD();
    Reset_Write(0b11);
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
        doStuff();
        //CyDelay(50);
    }
}
