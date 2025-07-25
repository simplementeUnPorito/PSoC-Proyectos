//#include "servo.h"
//
//#define SERVO_SENSIBILITY 5e-6
//#define SERVO_FRCUENCY 50
//#define ANGLE_MIN 0u
//#define ANGLE_MAX 180u
//
//
//#define MAX_PERIOD SERVO_SENSIBILITY*SERVO_FRECUENCY
//#define CLOCK_PWM MAX_PERIOD/SERVO_FRECUENCY
//
//
//
//// Usamos floats para mejorar la precisión
//#define SLOPE_ANGLE_TO_PULSE ((double)(PULSE_MAX - PULSE_MIN) / (ANGLE_MAX - ANGLE_MIN))
//#define OFFSET_ANGLE_TO_PULSE ((double)PULSE_MIN - SLOPE_ANGLE_TO_PULSE * ANGLE_MIN)
//
//
//#define PULSE_MIN 99u
//#define PULSE_MAX 499u
//#define BITS_MIN (uint16_t)819
//#define BITS_MAX (uint16_t)3276
//// Asegúrate de que la división ocurra como doble precisión
//#define SLOPE_BITS_TO_PULSE ((double)(PULSE_MAX - PULSE_MIN) / (double)(BITS_MAX - BITS_MIN))
//// Corregir paréntesis de cierre y usar la constante correcta
//#define OFFSET_BITS_TO_PULSE ((double)(PULSE_MIN - SLOPE_BITS_TO_PULSE * BITS_MIN))
//
//
////uint16 potBits[POT_MAX];
//uint16_t potBitsToPulse(uint16_t bits){
//    if(BITS_MIN > bits)
//        return PULSE_MIN;
//    if(bits > BITS_MAX)
//        return PULSE_MAX;
//    return (uint16_t)(SLOPE_BITS_TO_PULSE * bits + OFFSET_BITS_TO_PULSE);
//}
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
//


