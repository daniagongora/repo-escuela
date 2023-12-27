/*Dania Paula Góngora Ramírez
* Número de cuenta: 318128274
* Para compilar el archivo debe hacerse:
* gcc Practica2.c -lm -o practica2
* y para ejecutarlo:
* ./practica2 <la bandera con la media que se quiere usar> <los datos separados por un espacio>
* ejemplo: ./practica2 A 4 8 7 6 9 
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
*Función que calcula la media geométrica
* para datos el arreglo de datos dados con los cuales calcular la media
* para n la cantidad de datos con los cuales calcular la media.
*/
float mediaGeometrica(float datos[], int n){
	
	float resultado; 
	float producto=1;
	int i;
	
	for (i = 0; i < n; i++){
    	producto = (double) producto *datos[i];
    }
    
 	float raiz = (float) 1/n;
  	resultado = (float) pow (producto, raiz);

  	return resultado;

}

/*
*Función que calcula la media aritmética
* para datos el arreglo de datos dados con los cuales calcular la media
* para n la cantidad de datos con los cuales calcular la media.
*/
float mediaAritmetica(float datos[], int n){
	
	float c = 0;
	float resultado;
    int i;
    
    for(i = 0; i < n; i++){
        c =c+datos[i];
	}
    
    resultado=c/n;
	
	return resultado;
}

/*
*Función que calcula la media armónica
* para datos el arreglo de datos dados con los cuales calcular la media
* para n la cantidad de datos con los cuales calcular la media.
*/
float mediaArmonica(float datos[], int n){
	
	float resultado;
	float coeficiente=0.0;
	int i;
	
	for (i = 0; i < n; i++) {
      coeficiente = coeficiente + 1 / datos[i];
    }

  	resultado = (n / coeficiente);
	
	return resultado;
}

/*
*Main, este recibe al menos 4 parametros, argv contiene
* el nombre del archivo, una bandera A, G, o H, un entero
* y los datos de tipo númeor flotante para calcular las medias.
*/
int main(int argc, char *argv[]){
	
	if (argc < 3){
        printf("Hacen falta argumentos\n");
        return -1;
    }
    
    char *bandera = argv[1];

    float datos[argc-2];
    
    int n = argc-2;

    for(int i = 0; i < argc-2 ; i++){
        
        datos[i] = atof(argv[i+2]);
        
    }

    if(*bandera == 'A' || *bandera == 'H' || *bandera == 'G' ){
    
    	if (*bandera == 'A'){
    		float mediaA = mediaAritmetica(datos, n);
    		printf("La media aritmética es: %f\n", mediaA);
    	}
    
    	if(*bandera == 'H'){
    		float mediaAr = mediaArmonica(datos, n);
    		printf("La media armónica es: %f\n", mediaAr);
    	}
    
    	if(*bandera == 'G'){
    		float mediaGe = mediaGeometrica(datos, n);
    		printf("La media geometrica es: %f\n", mediaGe);
    	}
	
	}else{
		printf("No diste los argumentos correctamente\n");
	}
	
	return 0;
}
