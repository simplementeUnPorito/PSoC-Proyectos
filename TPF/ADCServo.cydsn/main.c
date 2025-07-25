#include "project.h"
#include "stdio.h"


// Definir los índices de los canales del SAR Seq
#define BASE_PERILLA 0
#define CODO_PERILLA 1
#define MUNNECA_PERILLA 2
#define BASE_3D 3
#define CODO_3D 4
#define MUNNECA_3D 5
#define PINZA 3

// Definir los modos
#define PERILLA 0
//#define _3D 1  // Descomenta esta línea si quieres habilitar el modo _3D

// Definir estructuras
volatile struct {
    uint8_t reset : 1;   
    uint8_t key : 2;
    uint8_t pot : 1;  // Define el modo de operación (PERILLA o 3D)
} flag;

// Estructura para los valores de los potenciómetros
typedef struct Potenciometros {
    uint16_t base;
    uint16_t codo;
    uint16_t munneca;
    uint16_t pinza;
}Potenciometros;  // Crear una instancia de la estructura para los potenciómetros
Potenciometros pot;

// Rango de valores del potenciómetro y del PWM
#define RANGO_POT 305
#define ANGULO_MIN 63
#define POT_MIN (ANGULO_MIN*4095)/RANGO_POT
#define ANGULO_MAX 242
#define POT_MAX (ANGULO_MAX*4095)/RANGO_POT
#define PWM_MIN 199
#define PWM_MAX 459

// Valores mínimos y máximos para cada potenciómetro en modo PERILLA
#define BASE_PERILLA_MIN 655
#define BASE_PERILLA_MAX 4095
#define PINZA_PERILLA_MIN 1005
#define PINZA_PERILLA_MAX 4095
#define CODO_PERILLA_MIN 0
#define CODO_PERILLA_MAX 4095
#define MUNNECA_PERILLA_MIN 0
#define MUNNECA_PERILLA_MAX 4095

// Valores mínimos y máximos para cada potenciómetro en modo 3D (si está definido)
#ifdef _3D
    #define BASE_3D_MIN 700
    #define BASE_3D_MAX 4095
    #define CODO_3D_MIN 100
    #define CODO_3D_MAX 4095
    #define MUNNECA_3D_MIN 200
    #define MUNNECA_3D_MAX 4095
#endif

// Variables para el filtrado
#define FILTRO_MIN 819      // 20% de 4095
#define FILTRO_MAX 3276     // 80% de 4095
#define UMBRAL_CAMBIO 20     // Cambios menores a este valor se ignoran para evitar el temblor

// Función para ajustar valores del potenciómetro en el rango de 0 a 4095
uint16_t ajustarPot(uint16_t valor, uint16_t min, uint16_t max) {
    //if (valor < FILTRO_MIN || valor > FILTRO_MAX) return 0;  // Filtrado de ruido
    if (valor <= min) return 0;
    if (valor >= max) return 4095;
    return ((valor - min) * 4095) / (max - min);  // Escala el valor a 12 bits
}

// Función para calcular el valor PWM basado en el valor del potenciómetro
uint16_t calcularPWM(uint16_t valor) {
    if (valor <= POT_MIN) {
        return PWM_MIN; // Ángulo 0 grados
    } else if (valor >= POT_MAX) {
        return PWM_MAX; // Ángulo 180 grados
    } else {
        return PWM_MIN + ((valor - POT_MIN) * (PWM_MAX - PWM_MIN)) / (POT_MAX - POT_MIN);
    }
}

uint16_t ABS(int16_t a){
    return a<0?-1*a:a;
}
// Función para ajustar los servos con suavizado para reducir el temblor
void ajustarServo(struct Potenciometros pot) {
    static uint16_t last_base_pwm = 0;
    static uint16_t last_codo_pwm = 0;
    static uint16_t last_munneca_pwm = 0;
    static uint16_t last_pinza_pwm = 0;
    
    uint16_t pwm_base = calcularPWM(pot.base);
    uint16_t pwm_codo = calcularPWM(pot.codo);
    uint16_t pwm_munneca = calcularPWM(pot.munneca);
    uint16_t pwm_pinza = calcularPWM(pot.pinza);
    
    // Aplicar el umbral de cambio para reducir el temblor
    if (ABS(pwm_base - last_base_pwm) > UMBRAL_CAMBIO) {
        PWM1_WriteCompare1(pwm_base);
        last_base_pwm = pwm_base;
    }
    if (ABS(pwm_codo - last_codo_pwm) > UMBRAL_CAMBIO) {
        PWM1_WriteCompare2(pwm_codo);
        last_codo_pwm = pwm_codo;
    }
    if (ABS(pwm_munneca - last_munneca_pwm) > UMBRAL_CAMBIO) {
        PWM2_WriteCompare1(pwm_munneca);
        last_munneca_pwm = pwm_munneca;
    }
    if (ABS(pwm_pinza - last_pinza_pwm) > UMBRAL_CAMBIO) {
        PWM2_WriteCompare2(pwm_pinza);
        last_pinza_pwm = pwm_pinza;
    }
}

// ISR para manejar la lectura del ADC y el cambio de canal en el MUX
CY_ISR(guardarPot) {
    if (flag.pot == PERILLA) {
        pot.base = ajustarPot(ADC_finalArray[BASE_PERILLA], BASE_PERILLA_MIN, BASE_PERILLA_MAX);
        pot.codo = ajustarPot(ADC_finalArray[CODO_PERILLA], CODO_PERILLA_MIN, CODO_PERILLA_MAX);
        pot.munneca = ajustarPot(ADC_finalArray[MUNNECA_PERILLA], MUNNECA_PERILLA_MIN, MUNNECA_PERILLA_MAX);
    }
    #ifdef _3D
    else {
        pot.base = ajustarPot(ADC_finalArray[BASE_3D], BASE_3D_MIN, BASE_3D_MAX);
        pot.codo = ajustarPot(ADC_finalArray[CODO_3D], CODO_3D_MIN, CODO_3D_MAX);
        pot.munneca = ajustarPot(ADC_finalArray[MUNNECA_3D], MUNNECA_3D_MIN, MUNNECA_3D_MAX);
    }
    #endif

    pot.pinza = ajustarPot(ADC_finalArray[PINZA], PINZA_PERILLA_MIN, PINZA_PERILLA_MAX);
    
    ajustarServo(pot);  // Llamada para ajustar los servos con los valores leídos y escalados
}

int main(void) {
    CyGlobalIntEnable; /* Enable global interrupts. */
    
    // Iniciar los componentes
    ADC_Start();
    ADC_StartConvert();
    eoc_ADC_Start();
    eoc_ADC_StartEx(guardarPot); // Asignar la ISR
    PC_Start();
    PWM1_Start();
    PWM2_Start();
    
    char buffer[100];
    
    for(;;) {
        // Mostrar los valores almacenados en el struct pot
        snprintf(buffer, 100, "Modo: %s\tB: %u\tC: %u\tM: %u\tP: %u\n\r", 
                 flag.pot == PERILLA ? "Perilla" : "3D", pot.base, pot.codo, pot.munneca, pot.pinza);
        PC_PutString(buffer);

        // Cambiar entre modos PERILLA y 3D al recibir un carácter en la terminal
        #ifdef _3D
            if (PC_GetRxBufferSize() > 0) {
                PC_GetChar(); // Limpia el buffer
                flag.pot = ~flag.pot & 0x01;  // Cambia el modo entre PERILLA y 3D
            }
        #endif

        // Limpiar la pantalla de la terminal y esperar un corto intervalo
        CyDelay(255);  
        PC_PutString("\033[2J\033[H");
    }
}
