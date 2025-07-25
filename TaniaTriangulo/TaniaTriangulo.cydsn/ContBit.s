.syntax unified
    .text

/*
parametros:
    R0  ->  El numero a ser evaluado
    R1  ->  El contador
Retorno:
    R0  ->  Guardamos R1 en R0 al final de la lectura
en C la funcion que se usaria seria uint32, representa un num entero sin signo en 32bits, se pueden representar
num desde 0 hasta 4.294.967.295
uint8_t Cont_Bits(uint32_t num_bit) {
    uint32_t cont = 0;
    while (num_bit) { //num_bit!=0
        cont_b += num_bit & 1;  //verifica si el numero menos significativo de num_bit es igual a 1, si es, incrementa cont_b 
        num_bit >>= 1;         //hace un shift right al num_bit
    }
    return cont_b;
}
*/

    .global Cont_Bits
    .func Cont_Bits, Cont_Bits
    .thumb_func
Cont_Bits:
    // R0   ->   num_bit
    //uint32_t cont = 0;
    mov R1, #0      
    
While_cont:
    //while (num_bit) { 
    cmp R0, #0      //num_bit!=0, compare R0(num_bit) con 0
    beq fin_while   //num_bit!=0-->num_bit == 0, si es igual a 0 entonces sale del while
    //cont_b += num_bit & 1;
    and R2, R0, #1  //R2 = R0&1 se guarda el resultado del and logico de R0 con 1 en R2 como un auxiliar
    add R1, R2      //se suma a R1
    //num_bit >>= 1;
    lsr R0,#1       //Desplazamos R0 para analizar el siguiente bit 
    b While_cont    //quedarse en while_cont
    
fin_while:
    mov R0, R1      //guardar R1 en R0 para que retorne el contador
    
    BX lr
    .endfunc


    .end


/* [] END OF FILE */