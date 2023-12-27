    .data
    
    .text
    	li $s0, 10
    	jal incrementa
    	
    	#imprimir el valor
    	li $v0, 1
    	move $a0, $s0
    	syscall
    	
    	#terminar programa
    	li $v0, 10
    	syscall
    	
    	incrementa:
    		sub $sp, $sp, 4 #agregar memoria al stack con sp (stack pointer) restandole 4
    		sw $s0, 0($sp) #guarda 10 en sp
    		add $s0, $s0, 20
    		
    		
    		#imprimir valor
    		li $v0, 1
    		move $a0, $s0
    		syscall 
    		
    		#no queremso que el valor de s0 cambie fuera del programa
    		#restaurar los valores (subiendo stack pointer a su estado original)
    		lw $s0, 0($sp)
    		add $sp, $sp, 4 #descaragar la memoria del stack
    		sw $s0, 0($sp)
    		
    		jr $ra