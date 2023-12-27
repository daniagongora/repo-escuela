#programa para arreglos
     .data
	muNum:       .word
	miArreglo:   .space 12

     .text
     	li $s0, 4 #cargar cuatro números al azar
     	li $s1, 10
     	li $s2, 12
     	li $t0, $zero
     	#sw $s0, miArreglo(0]
     	#sw $s1, miArreglo(4) #ya que los enteros ocupan 4 bytes
     	sw $s0, miArreglo($t0)
     	add $t0, $t0, 4 #t0+=4
     	sw $s1, miArreglo($t0)
     	lw $s4, miArreglo($zero)