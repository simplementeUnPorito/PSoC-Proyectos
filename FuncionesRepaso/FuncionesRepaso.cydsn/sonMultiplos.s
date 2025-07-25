.syntax unified
.text

.global sonMultiplos
.func sonMultiplos, sonMultiplos
.thumb_func

/*
    Parámetros:
        R0 = n0 (primer número)
        R1 = n1 (segundo número)
    Retorno:
        R0 = 1 si n1 es múltiplo de n0
             0 si no es múltiplo
*/

sonMultiplos:
    CMP R0, R1               @ Comparar n0 (R0) con n1 (R1)
    ITTT HI                   @ If-Then-Then-Then: Ejecutar si n0 > n1
    MOVHI R2, R0             @ Guardar n0 en R2 si n0 > n1
    MOVHI R0, R1             @ Copiar n1 a n0 si n0 > n1
    MOVHI R1, R2             @ Restaurar n0 en n1 (intercambio)

    UDIV R2, R1, R0          @ R2 = n1 / n0 (división entera)
    MUL R3, R2, R0           @ R3 = (n1 / n0) * n0 (producto del cociente por el divisor)

    CMP R3, R1               @ Comparar (n1 / n0) * n0 con n1
    ITE EQ
    MOVEQ R0, #1             @ Si son iguales, retornar 1 (son múltiplos)
    MOVNE R0, #0             @ Si no son iguales, retornar 0 (no son múltiplos)
    BX LR                    @ Regresar de la función

.endfunc
