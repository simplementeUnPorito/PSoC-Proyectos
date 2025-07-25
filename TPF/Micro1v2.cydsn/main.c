#include "project.h"
#include "keyboard.h"
//#include "servo.h"
#include "rgb_lcd.h"
//#include "generic.h"

//Definiciones Logicas
#define TRUE  1
#define FALSE 0

#define POT_MAX 1

#define MAX_BUFFER 100
char buffer[MAX_BUFFER];

#if defined (__GNUC__)
    asm(".global _printf_float");
#endif

uint16_t button = 0;

#define SERVO_SENSIBILITY 5e-6
#define SERVO_FRCUENCY 50
#define ANGLE_MIN 0u
#define ANGLE_MAX 180u


#define MAX_PERIOD SERVO_SENSIBILITY*SERVO_FRECUENCY
#define CLOCK_PWM MAX_PERIOD/SERVO_FRECUENCY



// Usamos floats para mejorar la precisión
#define SLOPE_ANGLE_TO_PULSE ((double)(PULSE_MAX - PULSE_MIN) / (ANGLE_MAX - ANGLE_MIN))
#define OFFSET_ANGLE_TO_PULSE ((double)PULSE_MIN - SLOPE_ANGLE_TO_PULSE * ANGLE_MIN)


#define PULSE_MIN 99u
#define PULSE_MAX 499u
#define BITS_MIN (uint16_t)819
#define BITS_MAX (uint16_t)3276
// Asegúrate de que la división ocurra como doble precisión
#define SLOPE_BITS_TO_PULSE ((double)(PULSE_MAX - PULSE_MIN) / (double)(BITS_MAX - BITS_MIN))
// Corregir paréntesis de cierre y usar la constante correcta
#define OFFSET_BITS_TO_PULSE ((double)(PULSE_MIN - SLOPE_BITS_TO_PULSE * BITS_MIN))


uint8_t conversionIsStarted = FALSE;
uint8_t conversionIsEnded = FALSE;

uint16_t angleToPulse(uint8_t angle);
uint16 potBitsToPulse(uint16 bits);


uint8_t askUpdateServo;
uint8_t askGetNumber;
char8 bufferTX[MAX_BUFFER];
uint16_t potBitsToPulse(uint16_t bits){
    if(BITS_MIN > bits)
        return PULSE_MIN;
    if(bits > BITS_MAX)
        return PULSE_MAX;
    return (uint16_t)(SLOPE_BITS_TO_PULSE * bits + OFFSET_BITS_TO_PULSE);
}
//
//uint16_t bits_pot_value;
//uint8_t testPot()
//{
//    uint8_t result = FALSE;
//    if(!conversionIsStarted)
//    {
//       conversionIsStarted = TRUE;
//       POT_StartConvert();
//    }else if(POT_IsEndConversion(POT_RETURN_STATUS))
//    {
//        
////        for(uint8_t i = 0;i<POT_MAX;i++)
////            potBits[i] = POT_GetResult16(i);
//        //PC_PutString("Leyendo potenciometro...\n\r");
//        bits_pot_value = POT_GetResult16();
//        //snprintf(buffer, MAX_BUFFER, "Valor bruto: %d\n\r", raw_value);
//        //PC_PutString(buffer);
//        //snprintf(buffer,MAX_BUFFER,"Valor = %i\n\r",potBits[0]);
//        //PC_PutString(buffer);
//        result = TRUE;
//        conversionIsStarted = FALSE;
//        
//    }
//    return result;
//}
uint8_t smiley[8] = {
    0b00000,  // Línea 1
    0b01010,  // Línea 2
    0b01010,  // Línea 3
    0b00000,  // Línea 4
    0b10001,  // Línea 5
    0b01110,  // Línea 6
    0b00000,  // Línea 7
    0b00000   // Línea 8
};


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
    
    conversionIsStarted = FALSE;
    button = 0;
}



void demostracionLCD()
{
    // 1. Desactivar autoscroll antes de escribir
    LCD_noAutoscroll();

    // 2. Mostrar un mensaje en la primera línea
    LCD_setCursor(0, 0);  // Asegurarse de que el cursor esté al principio
    char msg[100] = "Hola PSoC!";
    LCD_print(msg, strlen(msg));

    // 3. Mostrar el carácter personalizado en la segunda línea
    LCD_setCursor(0, 1);
    strncpy(msg,"Carita Feliz: ",100);
    LCD_print(msg,strlen(msg));
    LCD_write(0);  // Mostrar la carita sonriente

    // 4. Esperar un poco antes de activar el autoscroll
    CyDelay(2000);  // Esperar 2 segundos

    // 5. Activar el autoscroll y mostrar un mensaje largo
    //char scrollMsg[] = "Scroll --> WiiIIiIiHiiH.";
    
    LCD_autoscroll();
    
    // 6. Simular el autoscroll desplazando el mensaje largo
    for(uint8_t i = 0; i < 10; i++) {
        LCD_scrollDisplayLeft();  // Desplazar a la izquierda
        CyDelay(100);  // Esperar entre cada desplazamiento
    }
    for(uint8_t i = 0; i < 10; i++) {
        LCD_scrollDisplayRight();  // Desplazar a la izquierda
        CyDelay(100);  // Esperar entre cada desplazamiento
    }

    
     // 7. Activar y desactivar el parpadeo del cursor
    LCD_cursor();  // Mostrar el cursor
    CyDelay(1000);  // Esperar 1 segundo
    LCD_noCursor();  // Ocultar el cursor
    CyDelay(1000);  // Esperar 1 segundo

    // 8. Activar y desactivar el parpadeo del cursor
    LCD_blink();  // Activar el parpadeo del cursor
    CyDelay(1000);  // Esperar 1 segundo
    LCD_noBlink();  // Desactivar el parpadeo del cursor
    CyDelay(1000);  // Esperar 1 segundo

    // 8. Activar y desactivar el parpadeo del LED de la retroiluminación
    LCD_blinkLED();  // Activar el parpadeo del LED
    CyDelay(1000);  // Esperar 1 segundo
    LCD_noBlinkLED();  // Desactivar el parpadeo del LED
    CyDelay(1000);  // Esperar 1 segundo
    
    // 10. Desactivar el autoscroll y limpiar la pantalla para evitar sobreescribir
    LCD_noAutoscroll();
    LCD_clear();

    // 8. Cambiar el color del backlight en un ciclo
    LCD_setRGB(255, 0, 0);  // Cambiar el color a rojo
    CyDelay(100);          // Esperar 1 segundo

    LCD_setRGB(0, 255, 0);  // Cambiar el color a verde
    CyDelay(100);          // Esperar 1 segundo

    LCD_setRGB(0, 0, 255);  // Cambiar el color a azul
    CyDelay(100);          // Esperar 1 segundo

    LCD_setRGB(255, 255, 255);  // Cambiar el color a blanco
    CyDelay(100);              // Esperar 1 segundo
}




int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */
    myStart();
    demostracionLCD();
    
    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    for(;;)
    {
        PC_PutStringConst("Inicio\n\r");
        demostracionLCD();
        
        
    }
}