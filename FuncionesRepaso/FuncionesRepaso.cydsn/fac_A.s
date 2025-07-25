/* ========================================
 *
 * Copyright YOUR COMPANY, THE YEAR
 * All Rights Reserved
 * UNPUBLISHED, LICENSED SOFTWARE.
 *
 * CONFIDENTIAL AND PROPRIETARY INFORMATION
 * WHICH IS THE PROPERTY OF your company.
 *
 * ========================================
*/

    .syntax unified
    .text


    .global fac_A
    .func fac_A, fac_A
    .thumb_func
    /*
    Funcion que calcula el factorial de un numero que puede ser desde 1 hasta 15.
    Parametro:
        R0 -> valor cuyo factorial se calcula
    Retorno:
    */
fac_A:
    BX lr
    .endfunc
*/

    .end


/* [] END OF FILE */
