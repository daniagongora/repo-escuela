    .data
    	mIngresa: .asciiz "ingresa el número para el cual encontrar su factorial"
    	mResultado: .ascii "El resultado es: "
    	argumento:   .word 0
    	resultado:  .word 0
    	
    	
    .text
    	
    	main:
    		#Lee la entrada del usuario
    		li $v0, 4
    		la $a0, mIngresa
    		syscall
    		
    		li $v0, 5
    		syscall
    		sw $v0, argumento
    		
    		#llamamos a la función factorial
    		lw $a0, argumento
    		jal factorial
    		sw $v0, resultado
    		
    		#imprimir el resultado
    		li $v0, 4
    		la $a0, mResultado #imprime el mensaje
    		syscall
    		
    		li $v0, 1
    		lw $a0, resultado #imprime el númeor
    		syscall
    		
    		#terminamos el programa
    		li $v0, 10
    		syscall
    		
    		factorial:
    			#reservar memoria y guardar datos
    			sub $sp, $sp, 8
    			sw $ra, 0($sp)
    			sw $a0, 4($sp)
    			
    			#caso base factrial(0)
    			beq $a0, 0, factorialEnd
    			
    			#Parte de recursión
    			sub $a0, $a0, 1
    			jal factorial
    			
    			lw $a0, 4($sp)
    			mul $v0, $a0, $v0
    			
    		#Caso base
    		factorialEnd:
    		add $sp, $sp,8
    		lw $ra, 0($sp)
    		lw $a0, 4($sp)
    		jr $ra 