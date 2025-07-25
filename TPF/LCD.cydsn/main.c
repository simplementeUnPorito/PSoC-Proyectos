#include "project.h"
#include <stdio.h>
#include <string.h>  // Para usar strlen
#include "rgb_lcd.h"

// Definición del carácter personalizado (carita sonriente)
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

int main(void) {
    CyGlobalIntEnable;  // Habilitar interrupciones globales

    // Inicializar el componente I2C
    I2C_LCD_Start();

    // Inicializar el LCD (16 columnas, 2 filas)
    LCD_begin(16, 2, LCD_5x8DOTS);

    // Limpiar la pantalla LCD antes de imprimir
    LCD_clear();

    // Crear el carácter personalizado en la ubicación 0 de CGRAM
    LCD_createChar(0, smiley);
    for(;;)
        LCD_setRGB(255, 255, 255);

    
}
