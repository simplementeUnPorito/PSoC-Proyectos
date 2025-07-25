#include "project.h"
#include <stdio.h>
#include "funciones.h"

void triangulitoLindo(uint8_t N,char* buff, uint8_t len,void (*print)(const char*))
{
    char aux[5];
    for(int i = 1; i<=N;i++)
    {
        snprintf(buff,len,"1");
        for(int j = 2;j<=i;j++)
        {
            snprintf(aux,5," %u",j);
            strncat(buff,aux,len);
        }
        strncat(buff,"\r\n",len);
        print(buff);
        
    }
}

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

int16_t getInt(char *buf,uint16_t max_buf,char *msg,void (*print)(const char*),uint8_t (*getcharl)(), void (*putcharl)(uint8_t) )
{
    u_int8_t salir = 0;
    int16_t result = 0;
    do
    {
        print(msg);
        getLine(buf,max_buf,getcharl,putcharl);
        //u_int16_t aux = strtoul(buf,NULL,10);
        (salir = sscanf(buf,"%hd",&result))?:print("Error, valor ingresado no entero\r\n");
    }while(salir != 1);
    buf[0] = '\0';
    return result;
}
