/* 
8. Escriba la función squeeze(s1, s2), que eliminar de la cadena s1 todos los caracteres 
que se encuentran en s2. Por ejemplo, si s1 contiene “Hola que tal” y s2 contiene “hxt”, 
luego de ejecutar la función la cadena s1 debe contener “Hola que al”.
    void borrarChar(char *r0) {
    while (*r0 != '\0') {
        *r0 = *(r0 + 1);
        r0++; 
    }
}

void squeeze(char *r0, char *r1) {
    char* r2 = r0;
    if(r2 == NULL) return;
    r2 = r1;
    if(r2 == NULL) return;
    while (*r0 != '\0') { 
        r2 = r1;
        int r12 = 0;
        
        while (*r2 != '\0') {
            if (*r0 == *r2) {
                borrarChar(r0); 
                r12 = 1;
                break;
            }
            r2++;
        }
        
        if (!r12) {
            r0++; 
        }
    }
}


    .syntax unified
    .text

/*
.syntax unified
.text

.global borrarChar
.func borrarChar, borrarChar
.thumb_func

borrarChar:
    borrar_loop:
        LDRB R1, [R0, #1]    @ Leer el siguiente carácter
        STRB R1, [R0], #1    @ Sobrescribir el actual con el siguiente y avanzar
        CMP R1, #0           @ ¿Es el final de la cadena?
        BNE borrar_loop      @ Si no es el final, continuar
    BX LR                    @ Retornar
.endfunc




 .global squeeze
.func squeeze, squeeze
.thumb_func

squeeze:
    PUSH {R4, R5, LR}        @ Guardar registros en la pila

    cmp_loop:
        LDRB R2, [R0]        @ Leer el carácter actual de s1
        CBZ R2,squeeze_done  @ ¿Es el final de s1?

        MOV R4, R1           @ R4 apunta al inicio de s2
        char_loop:
            LDRB R3, [R4], #1    @ Leer un carácter de s2 y avanzar
            CBZ R3,  next_char   @ ¿Es el final de s2?

            CMP R2, R3           @ Comparar el carácter actual de s1 con s2
            BNE char_loop        @ Si coinciden, eliminar el carácter de s1
        delete_char:
            BL borrarChar        @ Llamar a borrarChar
            B cmp_loop           @ Reiniciar la comparación desde el carácter actual

        next_char:
            ADD R0, #1           @ Avanzar al siguiente carácter de s1
            B cmp_loop           @ Continuar el bucle

squeeze_done:
    POP {R4, R5, LR}    @ Restaurar registros
    BX LR               @ Retornar
.endfunc
