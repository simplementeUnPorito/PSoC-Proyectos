#include "project.h"
#include "stdio.h"
#include "servov2.h"


// Función para ajustar valores del potenciómetro en el rango de 0 a 4095
uint16_t ajustarPot(uint16_t valor,uint16_t valorAnterior,uint16_t  min, uint16_t max) {
    //if (valor < FILTRO_MIN || valor > FILTRO_MAX) return 0;  // Filtrado de ruido
    if (valor <= min) return 0;
    if (valor >= max) return 4095;
    uint16_t aux = ((valor - min) * 4095) / (max - min);  // Escala el valor a 12 bits
    if(ABS(valorAnterior - valor)> POT_DELTA_MIN)
        return aux;
    return valorAnterior;
}

// Función para calcular el valor PWM basado en el valor del potenciómetro
uint16_t calcularPWM(uint16_t valor,uint16_t min, uint16_t max) {
    if (valor <= POT_MIN) {
        return min; // Ángulo 0 grados
    } else if (valor >= POT_MAX) {
        return max; // Ángulo 180 grados
    } else {
        return min + ((valor - POT_MIN) * (max - min)) / (POT_MAX - POT_MIN);
    }
}

uint16_t ABS(int16_t a){
    return a<0?-1*a:a;
}

void ajustarServo(struct Potenciometros pot, uint8_t filtrar) {
    // Definir el struct de cola dentro de la función
    struct Cola {
        uint16_t buffer[QUEUE_SIZE_3];  // Tamaño máximo para simplificar
        uint8_t size;
        uint32_t sum;
    };

    // Definir colas estáticas para cada potenciómetro
    static struct Cola cola_base = { .size = 0, .sum = 0 };
    static struct Cola cola_codo = { .size = 0, .sum = 0 };
    static struct Cola cola_munneca = { .size = 0, .sum = 0 };
    static struct Cola cola_pinza = { .size = 0, .sum = 0 };
    
    static uint8_t index = 0;  // Índice compartido para todas las colas

    // Definir arreglos de PWM y colas para facilitar el bucle
    uint16_t pwms[] = {
        calcularPWM(pot.base, PWM_MIN, PWM_MAX),
        calcularPWM(pot.codo, PWM_MIN, PWM_MAX),
        calcularPWM(pot.munneca, PWM_MIN, PWM_MAX),
        calcularPWM(pot.pinza, PWM_MIN, PWM_MAX - 100)
    };
    struct Cola* colas[] = { &cola_base, &cola_codo, &cola_munneca, &cola_pinza };

    if(filtrar == TRUE){
        uint8_t queue_size;

        // Selección del tamaño de la cola basado en el valor de 'd'
        switch (d) {
            case 1:
                queue_size = 5;
                break;
            case 2:
                queue_size = 10;
                break;
            case 3:
                queue_size = 15;
                break;
            default:
                queue_size = 0;  // Sin media móvil si 'd' es 0
                break;
        }

        // Aplicamos la media móvil si 'd' es 1, 2, o 3
        if (queue_size > 0) {
            for (int i = 0; i < 4; i++) {
                colas[i]->sum -= colas[i]->buffer[index];
                colas[i]->buffer[index] = pwms[i];
                colas[i]->sum += pwms[i];
                colas[i]->size = (colas[i]->size < queue_size) ? colas[i]->size + 1 : queue_size;
                pwms[i] = (uint16_t)(colas[i]->sum / colas[i]->size);
            }
            // Incrementamos el índice compartido y lo mantenemos en el rango de la cola
            index = (index + 1) % queue_size;
        }
    }
    // Actualizamos los PWM directamente
    PWM1_WriteCompare1(pwms[0]);
    PWM1_WriteCompare2(pwms[1]);
    PWM2_WriteCompare2(pwms[2]);
    PWM2_WriteCompare1(pwms[3]);
}

/*
void ajustarServo(struct Potenciometros pot) {
    // Definir el struct de cola dentro de la función
    struct Cola {
        uint16_t buffer[QUEUE_SIZE_3];  // Tamaño máximo para simplificar
        uint8_t size;
        uint32_t sum;
    };

    // Definir colas estáticas para cada potenciómetro
    static struct Cola cola_base = { .size = 0, .sum = 0 };
    static struct Cola cola_codo = { .size = 0, .sum = 0 };
    static struct Cola cola_munneca = { .size = 0, .sum = 0 };
    static struct Cola cola_pinza = { .size = 0, .sum = 0 };
    
    static uint8_t index = 0;  // Índice compartido para todas las colas

    uint16_t pwm_base = calcularPWM(pot.base, PWM_MIN, PWM_MAX);
    uint16_t pwm_codo = calcularPWM(pot.codo, PWM_MIN, PWM_MAX);
    uint16_t pwm_munneca = calcularPWM(pot.munneca, PWM_MIN, PWM_MAX);
    uint16_t pwm_pinza = calcularPWM(pot.pinza, PWM_MIN, PWM_MAX - 100);

    uint8_t queue_size;

    // Selección del tamaño de la cola basado en el valor de 'd'
    switch (d) {
        case 1:
            queue_size = 5;
            break;
        case 2:
            queue_size = 10;
            break;
        case 3:
            queue_size = 15;
            break;
        default:
            queue_size = 0;  // Sin media móvil si 'd' es 0
            break;
    }

    // Aplicamos la media móvil si 'd' es 1, 2, o 3
    if (queue_size > 0) {
        // Para 'pwm_base'
        cola_base.sum -= cola_base.buffer[index]; //eliminamos termino guardado anteriormente
        cola_base.buffer[index] = pwm_base; //agregamos a la lista
        cola_base.sum += pwm_base; //sumamos el termino a la suma
        cola_base.size = (cola_base.size < queue_size) ? cola_base.size + 1 : queue_size; //aumentamos el tamaño de queue si aun no llega a su maximo
        pwm_base = (uint16_t)(cola_base.sum / cola_base.size);

        // Para 'pwm_codo'
        cola_codo.sum -= cola_codo.buffer[index];
        cola_codo.buffer[index] = pwm_codo;
        cola_codo.sum += pwm_codo;
        cola_codo.size = (cola_codo.size < queue_size) ? cola_codo.size + 1 : queue_size;
        pwm_codo = (uint16_t)(cola_codo.sum / cola_codo.size);

        // Para 'pwm_munneca'
        cola_munneca.sum -= cola_munneca.buffer[index];
        cola_munneca.buffer[index] = pwm_munneca;
        cola_munneca.sum += pwm_munneca;
        cola_munneca.size = (cola_munneca.size < queue_size) ? cola_munneca.size + 1 : queue_size;
        pwm_munneca = (uint16_t)(cola_munneca.sum / cola_munneca.size);

        // Para 'pwm_pinza'
        cola_pinza.sum -= cola_pinza.buffer[index];
        cola_pinza.buffer[index] = pwm_pinza;
        cola_pinza.sum += pwm_pinza;
        cola_pinza.size = (cola_pinza.size < queue_size) ? cola_pinza.size + 1 : queue_size;
        pwm_pinza = (uint16_t)(cola_pinza.sum / cola_pinza.size);

        // Incrementamos el índice compartido y lo mantenemos en el rango de la cola
        index = (index + 1) % queue_size;
    }

    // Actualizamos los PWM directamente
    PWM1_WriteCompare1(pwm_base);
    PWM1_WriteCompare2(pwm_codo);
    PWM2_WriteCompare2(pwm_munneca);
    PWM2_WriteCompare1(pwm_pinza);
}
*/
/*
// Función para ajustar los servos con suavizado para reducir el temblor
void ajustarServo(struct Potenciometros pot,uint8_t filtrar) {
    static uint16_t last_base_pwm = 0;
    static uint16_t last_codo_pwm = 0;
    static uint16_t last_munneca_pwm = 0;
    static uint16_t last_pinza_pwm = 0;
    
    uint16_t pwm_base = calcularPWM(pot.base,PWM_MIN,PWM_MAX);
    uint16_t pwm_codo = calcularPWM(pot.codo,PWM_MIN,PWM_MAX);
    uint16_t pwm_munneca = calcularPWM(pot.munneca,PWM_MIN,PWM_MAX);
    uint16_t pwm_pinza = calcularPWM(pot.pinza,PWM_MIN ,PWM_MAX-100);
    uint16_t umbral;
    switch(d)
    {
        case 1:
            umbral = UMBRAL_CAMBIO_1;
            break;
        
        case 2:
            umbral = UMBRAL_CAMBIO_2;
        break;
        
        case 3:
            umbral = UMBRAL_CAMBIO_3;
            break;
        
        default:
            umbral = UMBRAL_CAMBIO_0;
    }
    // Aplicar el umbral de cambio para reducir el temblor
    if (ABS(pwm_base - last_base_pwm) > umbral || !filtrar) {
        PWM1_WriteCompare1(pwm_base);
        last_base_pwm = pwm_base;
    }
    if (ABS(pwm_codo - last_codo_pwm) > umbral || !filtrar) {
        PWM1_WriteCompare2(pwm_codo); 
        last_codo_pwm = pwm_codo;
    }
    if (ABS(pwm_munneca - last_munneca_pwm) > umbral|| !filtrar) {
        PWM2_WriteCompare2(pwm_munneca);
        last_munneca_pwm = pwm_munneca;
    }
    if (ABS(pwm_pinza - last_pinza_pwm) > umbral|| !filtrar) {
        PWM2_WriteCompare1(pwm_pinza);
        last_pinza_pwm = pwm_pinza;
    }
    
        
}
*/
// ISR para manejar la lectura del ADC y el cambio de canal en el MUX
CY_ISR(guardarPot) {
    if (mode == PERILLA) {
        pot.base = ajustarPot(ADC_finalArray[BASE_PERILLA],pot.base, BASE_PERILLA_MIN, BASE_PERILLA_MAX);
        pot.codo = ajustarPot(ADC_finalArray[CODO_PERILLA],pot.codo, CODO_PERILLA_MIN, CODO_PERILLA_MAX);
        pot.munneca = ajustarPot(ADC_finalArray[MUNNECA_PERILLA],pot.munneca, MUNNECA_PERILLA_MIN, MUNNECA_PERILLA_MAX);
    }
    #ifdef _3D
    else {
        pot.base = ajustarPot(ADC_finalArray[BASE_3D], BASE_3D_MIN, BASE_3D_MAX);
        pot.codo = ajustarPot(ADC_finalArray[CODO_3D], CODO_3D_MIN, CODO_3D_MAX);
        pot.munneca = ajustarPot(ADC_finalArray[MUNNECA_3D], MUNNECA_3D_MIN, MUNNECA_3D_MAX);
    }
    #endif

    pot.pinza = ajustarPot(ADC_finalArray[PINZA],pot.pinza, PINZA_PERILLA_MIN, PINZA_PERILLA_MAX);
    
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

void start_servo(){
    ADC_Start();
    ADC_StartConvert();
    eoc_ADC_Start();
    eoc_ADC_StartEx(guardarPot); // Asignar la ISR
    PC_Start();
    PWM1_Start();
    PWM2_Start();
    TimerServo_Start();
    resetServoTimer_Write(0);
}

void seguirPot(uint8_t newd){
 d = newd;
 ajustarServo(pot,TRUE);   
}

uint16_t calcularNuevoPeriod(Potenciometros a, Potenciometros b){
    Potenciometros delta = 
               {a.base>b.base?a.base-b.base:b.base-a.base,
                a.codo>b.codo?a.codo-b.codo:b.codo-a.codo,
                a.munneca>b.munneca?a.munneca-b.munneca:b.munneca-a.munneca,
                a.pinza>b.pinza?a.pinza-b.pinza:b.pinza-a.pinza};
    uint16_t max = delta.base;
    if(delta.codo>max)max = delta.codo;
    if(delta.munneca>max)max = delta.munneca;
    if(delta.pinza>max)max = delta.pinza;
    uint16_t result = max*4/10 + 100;
    return result;
    
}
uint8_t seguirLista(ListaMovimiento* vector){
    if(ServoDone_Read() == 1){
        resetServoTimer_Write(1);
        TimerServo_WritePeriod(
        calcularNuevoPeriod(
            vector->lista[vector->indiceActual],
            vector->lista[(vector->indiceActual + 1) % vector->lenLista]));
        ejecutarListaPot(vector);
        CyDelay(50);  // Ajusta este valor según el tiempo que requiera el servo
        resetServoTimer_Write(0);
        TimerServo_Enable();
        return TRUE;

    }
    return FALSE;
}