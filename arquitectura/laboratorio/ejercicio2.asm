#Programa que calcula el mcd de dos números  
    .data 

	v1:	.space 4 #bytes
    
    .text
	
	#introducimos a
  	li $v0, 5
  	syscall
  	move $s0 $v0 #movemos a un registro el valor a dado en consola
  	
  	
  	#introducimos b
  	li $v0, 5
  	syscall
  	move $s1 $v0 #movemos a un registro el valor b dado en consola
	
    calculo:	
	beqz $s1 termino #Si se da la condición de terminación
	div $s0 $s1			
	move $s0 $s1
	mfhi $s1 #accedemos y movemos de HI
	b  calculo #regresamos al inicio de la función en caso de no ser el fin
    
    termino:  
	sw $s0 v1 
	move $v0 $s0 #el resultado queda en el registro v0