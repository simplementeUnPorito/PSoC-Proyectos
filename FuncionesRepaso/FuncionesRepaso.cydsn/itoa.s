.syntax unified
.text

/*
uint8_t my_itoa(int r0,char* r1, uint8_t r2){
    int r3,r4,r5,r6,r12;
    char* r11;
    if(r0 == 0){
        *r1++ = '0';
        *r1   = '\0';
        r0 = 1;
        return r0;
    }
    if(r2>32){
        r0 = 0;
        return r0;
    }
    if(r0<0){
        r4 = 1;
        r0 = -1*r0;
    }
    else
        r4 = 0;
    
    r6 = 0;
    r11 = r1;
    while(r0!=0){
        r3 = r0;
        r0 = r0/r2;
        r12 = r3-r0*r2;
        if(r12>9){
            r5 = r12 - 10;
            r5 = 'A' + r5;
        }
        else
            r5 = '0'+r12;
            
        *r1++ = r5;
    }
    if(r4 == 1){
        *r1++ = '-';
    }
    *r1-- = '\0';
    
    while (r11 < r1) {     
        r4 = *r11;
        r5 = *r1;
        *r11 = r5;        
        *r1 = r4;         
        r11++;             
        r1--;       
    }
    r0 = 1;
    return r0;
    
   
}
*/

.global itoa
.func itoa, itoa
.thumb_func

itoa:
    PUSH {R4-R6, R11}

    /*
    if(r0 == 0){
        *r1++ = '0';
        *r1   = '\0';
        r0 = 1;
        return r0;
    }
    */
    CMP R0, #0
    BNE num_no_nulo
    MOV R5, #'0'
    STRB R5, [R1], #1
    MOV R5, #0
    STRB R5, [R1]
    MOV R0, #1
    POP {R4-R6, R11}
    BX LR

num_no_nulo:
    /*
    if(r2 > 32){
        r0 = 0;
        return r0;
    }
    */
    CMP R2, #32
    ITTT HI
    MOVHI R0, #0
    POPHI {R4-R6, R11}
    BXHI LR

    /*
    if(r0 < 0){
        r4 = 1;
        r0 = -1 * r0;
    } else {
        r4 = 0;
    }
    */
    CMP R0, #0
    ITTE MI
    MOVMI R4, #1
    RSBMI R0, R0, #0
    MOVPL R4, #0

    /*
    r6 = 0;
    r11 = r1;
    */
    MOV R6, #0
    MOV R11, R1

loop_cmp:
    CBZ R0,end_loop

    /*
    r3 = r0;
    r0 = r0 / r2;
    r12 = r3 - r0 * r2;
    */
    MOV R3, R0
    SDIV R0, R0, R2
    MLS R12, R0, R2, R3

    /*
    if(r12 > 9){
        r5 = r12 - 10;
        r5 = 'A' + r5;
    } else {
        r5 = '0' + r12;
    }
    */
    CMP R12, #9
    ITTE HI
    SUBHI R5, R12, #10
    ADDHI R5, #'A'
    ADDLS R5, R12, #'0'

    STRB R5, [R1], #1
    B loop_cmp

end_loop:
    /*
    if(r4 == 1){
        *r1++ = '-';
    }
    *r1-- = '\0';
    */
    CMP R4, #1
    BNE no_negativo
    MOV R5, #'-'
    STRB R5, [R1], #1

no_negativo:
    MOV R5, #0
    STRB R5, [R1],#-1

loop_cmp_2:
    CMP R11, R1
    BHS end_loop_2

    /*
    r4 = *r11;
    r5 = *r1;
    *r11 = r5;
    *r1 = r4;
    r11++;
    r1--;
    */
    LDRB R4, [R11]
    LDRB R5, [R1]
    STRB R5, [R11],#1
    STRB R4, [R1],#-1
    @ ADD R11, R11, #1
    @ SUB R1, R1, #1
    B loop_cmp_2

end_loop_2:
    MOV R0, #1
    POP {R4-R6, R11}
    BX LR

.endfunc
