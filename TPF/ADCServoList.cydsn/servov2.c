#include "project.h"
#include "stdio.h"
#include "servov2.h"


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
void ajustarServo(struct Potenciometros pot,uint8_t filtrar) {
    static uint16_t last_base_pwm = 0;
    static uint16_t last_codo_pwm = 0;
    static uint16_t last_munneca_pwm = 0;
    static uint16_t last_pinza_pwm = 0;
    
    uint16_t pwm_base = calcularPWM(pot.base);
    uint16_t pwm_codo = calcularPWM(pot.codo);
    uint16_t pwm_munneca = calcularPWM(pot.munneca);
    uint16_t pwm_pinza = calcularPWM(pot.pinza);
    // Aplicar el umbral de cambio para reducir el temblor
    if (ABS(pwm_base - last_base_pwm) > UMBRAL_CAMBIO || !filtrar) {
        PWM1_WriteCompare1(pwm_base);
        last_base_pwm = pwm_base;
    }
    if (ABS(pwm_codo - last_codo_pwm) > UMBRAL_CAMBIO || !filtrar) {
        PWM1_WriteCompare2(pwm_codo);
        last_codo_pwm = pwm_codo;
    }
    if (ABS(pwm_munneca - last_munneca_pwm) > UMBRAL_CAMBIO|| !filtrar) {
        PWM2_WriteCompare1(pwm_munneca);
        last_munneca_pwm = pwm_munneca;
    }
    if (ABS(pwm_pinza - last_pinza_pwm) > UMBRAL_CAMBIO|| !filtrar) {
        PWM2_WriteCompare2(pwm_pinza);
        last_pinza_pwm = pwm_pinza;
    }
    
        
}

// ISR para manejar la lectura del ADC y el cambio de canal en el MUX
CY_ISR(guardarPot) {
    if (mode == PERILLA) {
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
    
    //ajustarServo(pot);  // Llamada para ajustar los servos con los valores leídos y escalados
}



// Variables globales


// Función para calcular el valor PWM basado en el valor del potenciómetro (tu función `calcularPWM`)


// Función para ejecutar el siguiente movimiento en la lista
void ejecutarListaPot(ListaMovimiento *movimientos) {
    // Asegurarse de que la lista no esté vacía
    if (movimientos->lenLista == 0) return;
    
    // Ajustar los servos al movimiento actual
    ajustarServo(movimientos->lista[movimientos->indiceActual],FALSE);
    
    // Avanzar al siguiente movimiento
    movimientos->indiceActual++;
    
    // Si llegamos al final de la lista, reiniciar el índice
    if (movimientos->indiceActual >= movimientos->lenLista) {
        movimientos->indiceActual = 0;
    }
}

void updateModeServo(uint8_t newMode){
    mode = newMode;
}