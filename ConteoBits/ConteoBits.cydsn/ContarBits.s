

    .syntax unified
    .text
    .global contarBits
    .func contarBits, contarBits
    .thumb_func
    
/*
    uint8_t contarBits(uint32_t N)
    {
        
        uint8_t cont = 0;
        for(uint8_t i = 0; i<31;i++)
        {
            if(N&0x01 != 0)
                cont++;
            N=N>>1;
        }
        
        return cont;
    }
    
    Parametros:
        R0->N
    Variables:
        R1->i
        R2->cont
*/
contarBits:
    mov R2, #0 //uint8_t cont = 0;
    mov R1, #0 //uint8_t i = 0
    
    contarBits_for:
        cmp R1, #32                     // i-32
        beq contarBits_finfor          //i<31-->i>=31, pero con llegar al = ya es suficiente
        tst R0, #01                    //if(N&0x01 != 0) -->N&0x01 == 0
        beq contarBits_nocontar
        add R2, #1                     //cont++;
        contarBits_nocontar:
        lsr R0, #1
        add R1, #1 // i++
        b contarBits_for
    contarBits_finfor:
    
    mov R0, R2
    BX lr
    
    
    
    .endfunc


    .end

