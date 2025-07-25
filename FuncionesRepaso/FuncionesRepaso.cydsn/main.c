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
#include "project.h"
#include <stdio.h>


void getLine (char *buf, int tamBuf, uint8_t (*getcharl)(), void (*putcharl)(uint8_t)) {
    int i;
    uint8 c;
   
    for (i = 0; i < tamBuf -1; ) {
        if ((c = getcharl()) != 0){
            putcharl(c);
            if (c == '\r') break;   // salimos si recibimos un enter
            buf[i++] = c;
        }
    }
    buf[i] = '\0';
    putcharl('\n');
}


extern u_int32_t fibonacciN_A(u_int16_t );



u_int32_t fibonacciN(u_int16_t N)
{
  if(N == 1 || N == 2)
    return 1;
    
  u_int32_t n1 = 1,n2 = 1,aux;
  for(u_int16_t i = 3; i<=N;i++)
  {
      aux = n1;
      n1 = n2;
      n2 = n2+aux;
  }
  return n2;
}

u_int16_t contVocal_A(char*);

u_int16_t contVocal(char *v)
{
    u_int16_t N = 0;
    char letter=*v++;
    while(letter!='\0')
    {
        switch(letter)
        {
            case 'a':case 'A':
            case 'e':case 'E':
            case 'i':case 'I':
            case 'o':case 'O':
            case 'u':case 'U':
                N++;
            default:
                break;
            
        }
        letter=*v++;
    }
    return N;
}

u_int32_t prime_A(u_int16_t N);

u_int32_t prime(u_int16_t N)
{
    if(N<=1) //verificamos caso trivial 1,0 y numeros negativos
        return 0;
    if(N == 2) //verificamos caso trivial 2
        return 1;
    else if(N%2 == 0) //verificamos si es impar, ya que 2 es el unico numero par primo
        return 0;
    u_int16_t limit = N>>1; //Un numero no puede ser multiplo de otro que sea mayor a su mitad
    for(u_int16_t i = 3;i<=limit;i+=2) //si no es multiplo de 2 no es de ningun numero par
        if(N%i == 0)
            return 0;
    return 1;
}




int16_t getInt(char *buf,u_int max_buf,char *msg)
{
    u_int8_t salir = 0;
    int16_t result = 0;
    do
    {
        PC_PutString(msg);
        getLine(buf,max_buf,PC_GetChar,PC_PutChar);
        //u_int16_t aux = strtoul(buf,NULL,10);
        (salir = sscanf(buf,"%hd",&result))?:PC_PutString("Error, valor ingresado no entero\r\n");
    }while(salir != 1);
    buf[0] = '\0';
    return result;
}
#define MAX 100
char buffer[MAX];


u_int8_t sonMultiplos(uint32_t n0, uint32_t n1);


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
#define MAX 100
u_int8_t itoa(int r0,char* r1, uint8_t r2);

int main(void)
{
    CyGlobalIntEnable; /* Enable global interrupts. */

    /* Place your initialization/startup code here (e.g. MyInst_Start()) */
    uint8_t n = 0,rc,ra;
 
    PC_Start();
    for(;;)
    {
        /*
        n = (uint8_t)getInt(buffer,MAX,"Ingrese el termino n de fibonacci que desea ver: ");
        
        rc =fibonacciN(n);
        ra = fibonacciN_A(n);
        snprintf(buffer,MAX,"Resultados:\n\r\ttC: %i\n\r\tA: %i\n\r",rc,ra);
        PC_PutString(buffer);
      
        
        n = (uint8_t)getInt(buffer,MAX,"Ingrese numero a verificar si es primo: ");
        rc =prime(n);
        ra = prime_A(n);
        snprintf(buffer,MAX,"Resultados:\n\r\ttC: %s\n\r\tA: %s\n\r",rc==1?"True":"False",ra==1?"True":"False");
        PC_PutString(buffer);
        
        
        
        PC_PutString("Ingrese cadena a contar las vocales: ");
        getLine(buffer,MAX,PC_GetChar,PC_PutChar);
        rc =contVocal(buffer);
        ra =contVocal_A(buffer);
        snprintf(buffer,MAX,"Resultados:\n\r\ttC: %i\n\r\tA: %i\n\r",rc,ra);
        PC_PutString(buffer);
        */
        /*
        uint32_t n0 = getInt(buffer, MAX, "Ingrese el primer numero (n0): ");
        uint32_t n1 = getInt(buffer, MAX, "Ingrese el segundo numero (n1): ");

        // Verificar si son múltiplos usando las dos implementaciones
        //rc = sonMultiplos(n0, n1);      // Implementación en C
        ra = sonMultiplos(n0, n1);    // Implementación en ensamblador

        // Mostrar los resultados
        snprintf(buffer, MAX, "Resultados:\n\r\tASM: %s\n\r",
        ra == 1 ? "Si" : "No");
        PC_PutString(buffer);
        */
        PC_PutString("\nIngrese un numero a convertir: ");
        int numero = getInt(buffer, MAX, "Numero: ");
        
        PC_PutString("Ingrese la base (2-32): ");
        int base = getInt(buffer, MAX, "Base: ");
        
        char stringC[MAX];
        char stringASM[MAX];

        // Usar itoa en C
        rc = my_itoa(numero, stringC, base);

        // Usar itoa en ensamblador
        ra = itoa(numero, stringASM, base);

        // Mostrar resultados
        snprintf(buffer, MAX, "Resultados:\n\r\tC: %s\n\r\tASM: %s\n\r", stringC, stringASM);
        PC_PutString(buffer);

    }
}

/* [] END OF FILE */
