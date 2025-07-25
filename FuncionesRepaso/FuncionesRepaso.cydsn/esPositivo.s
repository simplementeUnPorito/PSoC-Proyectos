.syntax unified
.text

.global esPositivo
.func esPositivo, esPositivo
.thumb_func

/*
Parámetros:
    R0 = n (número a evaluar)
Retorno:
    R0 = 1 si el número es positivo o 0 si es negativo
*/
esPositivo:
    CMP R0, #0              @ Comparar n con 0
    BPL return_positive     @ Si n >= 0, saltar a return_positive
    MOV R0, #0              @ Retornar 0 si n < 0
    BX LR                   @ Finalizar función

return_positive:
    MOV R0, #1              @ Retornar 1 si n >= 0
    BX LR                   @ Finalizar función
