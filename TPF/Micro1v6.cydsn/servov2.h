#include "project.h"
#include "stdio.h"

#ifndef FALSE
    #define FALSE 0
    #define TRUE 1
#endif

// Definir los modos
#define PERILLA 0
//#define _3D 1  // Descomenta esta línea si quieres habilitar el modo _3D
// Definir los índices de los canales del SAR Seq
#define BASE_PERILLA 0
#define CODO_PERILLA 1
#define MUNNECA_PERILLA 2
#ifndef _3D
    #define PINZA 3
#endif
#ifdef _3D
    #define BASE_3D 3
    #define CODO_3D 4
    #define MUNNECA_3D 5
    #define PINZA 6
#endif



// Rango de valores del potenciómetro y del PWM
#define RANGO_POT 305
#define ANGULO_MIN 63
#define POT_MIN (ANGULO_MIN*4095)/RANGO_POT
#define ANGULO_MAX 242
#define POT_MAX (ANGULO_MAX*4095)/RANGO_POT
#define PWM_MIN 199
#define PWM_MAX 459
#define POT_DELTA_MIN 1

// Valores mínimos y máximos para cada potenciómetro en modo PERILLA
#define BASE_PERILLA_MIN 655
#define BASE_PERILLA_MAX 4095
#define PINZA_PERILLA_MIN 1005
#define PINZA_PERILLA_MAX 4095
#define CODO_PERILLA_MIN 0
#define CODO_PERILLA_MAX 4095
#define MUNNECA_PERILLA_MIN 0
#define MUNNECA_PERILLA_MAX 4095

// Variables para el filtrado
#define FILTRO_MIN 819      // 20% de 4095
#define FILTRO_MAX 3276     // 80% de 4095
#define UMBRAL_CAMBIO_0 0    // Cambios menores a este valor se ignoran para evitar el temblor
#define UMBRAL_CAMBIO_1 10    // Cambios menores a este valor se ignoran para evitar el temblor
#define UMBRAL_CAMBIO_2 20    // Cambios menores a este valor se ignoran para evitar el temblor
#define UMBRAL_CAMBIO_3 30    // Cambios menores a este valor se ignoran para evitar el temblor

// Valores mínimos y máximos para cada potenciómetro en modo 3D (si está definido)
#ifdef _3D
    #define BASE_3D_MIN 700
    #define BASE_3D_MAX 4095
    #define CODO_3D_MIN 100
    #define CODO_3D_MAX 4095
    #define MUNNECA_3D_MIN 200
    #define MUNNECA_3D_MAX 4095
#endif

#define QUEUE_SIZE_1 512
#define QUEUE_SIZE_2 1024
#define QUEUE_SIZE_3 2048


// Estructura para los valores de los potenciómetros
typedef struct Potenciometros {
    uint16_t base;
    uint16_t codo;
    uint16_t munneca;
    uint16_t pinza;
}Potenciometros;  // Crear una instancia de la estructura para los potenciómetros
#define MAX_LEN_LISTA 100
typedef struct ListaMovimiento {
    Potenciometros lista[MAX_LEN_LISTA];
    uint8_t lenLista;       // Número actual de movimientos en la lista
    uint8_t indiceActual;   // Índice del movimiento actual
} ListaMovimiento;
// Estructura de Cola para la media móvil
struct Cola {
    uint16_t buffer[QUEUE_SIZE_3];
    uint8_t size;
    uint32_t sum;
};
uint8_t mode;
// Variables estáticas para almacenar la posición actual de cada servo
//static uint16_t posicion_actual[4] = {0, 0, 0, 0};
Potenciometros pot;
uint8_t d;
//uint8_t lento;  // Variable global para activar movimientos lentos
uint16_t ajustarPot(uint16_t valor,uint16_t valorAnterior, uint16_t min, uint16_t max);
uint16_t calcularPWM(uint16_t valor,uint16_t min, uint16_t max);
uint16_t ABS(int16_t a);
//void ajustarServo(Potenciometros pot,uint8_t filtrar);
CY_ISR_PROTO(guardarPot);
void ejecutarListaPot(ListaMovimiento *movimientos);
void updateModeServo(uint8_t newMode);

void start_servo();
void seguirPot(uint8_t newd);
uint8_t seguirLista();
// Declaración de funciones para ajustar el servo
void ajustarServo(struct Potenciometros pot, uint8_t filtrar);
void calcularMediaMovil(uint16_t *pwms, struct Cola *colas[], uint8_t queue_size);
void actualizarPWM(uint16_t *pwms);
uint16_t calcularPWM(uint16_t valor, uint16_t min, uint16_t max);
