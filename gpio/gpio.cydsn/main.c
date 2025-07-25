#include "project.h"
#include <stdio.h>

#define MAX_BF 100
char bfRX[MAX_BF];
int main(void)
{
    CyGlobalIntEnable; 
    uint32_t cont = 0;
    
    uint8_t est =0;
    
    for(;;)
    {
        //salida_Write(~entrada_Read());
        /*
        Esta funcion es similar a lo que hacemos con los pines neganndo con una puerta
        logica, pero hacer por sofware es mucho más lento, por lo que no suele ser lo conveniente
        si existe alguna solucion de hardware conveniente 
        */
        
        PC_Start();
        switch(est)
        {
            case 0: //la llave está sin presionar
                if(entrada_Read()==0) //la llave fue pulsada
                {
                    est = 1;
                    cont++;
                    snprintf(bfRX,MAX_BF,"%lu\r\n",cont);
                }
                break;
            case 1:
                if(entrada_Read()==1) //la llave sigue pulsada, no se solto el boton, pero ya no nos interesa eso
                {
                    est = 0;
                }
                break;
        }
        
        
    }
}

