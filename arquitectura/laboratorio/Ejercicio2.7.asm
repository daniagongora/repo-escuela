#Ejercicio 2 practica 7
#que calcule recursivamente el coeficiente binomial de
#n en k utilizando la identidad de Pascal

    .data
	cadena_n:	.asciiz "Ingrese un número n: "
	cadena_k: 	.asciiz "Ingrese un número k: "


     # Termina la ejecucion del programa

    .macro fin()
		li 	$v0, 10       		 
		syscall				# Llamada al sistema para terminar el programa.
     .end_macro

    # Lee un entero s y lo guarda 
    # en el registro %rd.

    .macro read_int(%rd, %msg)
		move	$t0, $a0		# Movemos el contenido de $a0 a$t0 para preservarlo.
	
		li 	$v0, 4			
		la 	$a0, %msg		# Guarda en $a0 en la cadena 'msg'.
		syscall				
	
		move 	$a0, $t0		# Regresamos el contenido original a $a0.
		li 	$v0, 5			
		syscall				
		move 	%rd, $v0		# Guarda en el registro %rd el valor ingresado.
     .end_macro

    # Imprime en la terminal el entero guardado 
    # en %rs.

    .macro print_int(%rs)
		move 	$a0, %rs		# Guarda el valor %rs en $a0.
		li 	$v0, 1			
		syscall				# imprime el valor entero final
    .end_macro


    # coeficiente binomial de 'n' en 'k'.

    .macro beg_cfbi_0()
		addi 	$sp, $sp, -16		# Guarda espacio en la pila para 4 numeros.
		sw	$a1, 8($sp)		# Guardamos el número k.
		sw 	$a0, 4($sp)		# Guardamos el número n.
		sw 	$ra, 0($sp)		
    .end_macro

    # Pedazo de código para la iteración C(n-1, k-1).

    .macro beg_cfbi_1()
		addi 	$a0, $a0, -1		# n = n - 1.
		addi 	$a1, $a1, -1		# k = k - 1.
    .end_macro

    # Pedazo de código para para invocar C(n-1, k).

    .macro beg_cfbi_2()
		addi 	$a0, $a0, -1		# n = n - 1.
    .end_macro


    # Fin de la rutina para coeficiente binomial
    .macro fin_cfbi_0()
		lw 	$ra, 0($sp)		
		add 	$sp, $sp, 16		# libera la pila
		jr 	$ra			
     .end_macro




     # Termina la llamada a C(n-1, k).

    .macro fin_cfbi_1()
		lw 	$a1, 8($sp)		
		lw 	$a0, 4($sp)		# regresa el valor original a la pila
		sw	$v0, 12($sp)		# Guarda el resultado de C(n-1, k-1) en la pila.
    .end_macro



    # Termina la llamada a C(n-1, k).

    .macro fin_cfbi_2()
		lw 	$t0, 12($sp)		# regresa el valor de C(n-1, k-1) de la pila.
    .end_macro


    # Invocacion a la subrutina cf_binomial.

    .macro call_cfbi()
		jal cf_binomial 		# Simplemente invocamos a la subrutina cf_binomial.	
    .end_macro


    # REvisa el caso en el que n >= 0 y k = 0.

    .macro caso_base_1(%n, %k)
		sge 	$t0, %n, $zero		# Si n >= 0, guarda un 1 en $t0.
					# Si n < 0, guarda un 0 en $t0.
	
		seq 	$t1, %k, $zero		# Si k = 0, guarda un 1 en $t1.
					# Si k != 0, guarda un 0 en $t1.
	
		add 	$t2, $t0, $t1		# Si k = 0 y n >= 0, $t2 = 2.
	
		beq 	$t2, 2, base_1		# Si k = 0 y n >= 0, vamos al caso base.
   .end_macro


    # Revisa el caso en el que n = 0 y k > 0.
    .macro caso_base_2(%n, %k)
		seq 	$t0, %n, $zero		# Si n = 0, guarda un 1 en $t0.
					# Si n != 0, guarda un 0 en $t0.
	
		sgt 	$t1, %k, $zero		# Si k > 0, guarda un 1 en $t1.
					# Si k <= 0, guarda un 0 en $t1.
	
		add 	$t2, $t0, $t1		# Si n = 0 y k > 0, $t2 = 2.
	
		beq 	$t2, 2, base_2		# Si n = 0 y k > 0, vamos al caso base.
    .end_macro


	.text
	.globl main

   # main del programa.

     main:
		read_int($a0, cadena_n)		# Lee un entero 'n' y lo guarda en $a0.
		read_int($a1, cadena_k)		# Lee un entero 'k' y lo guarda en $a1.
	
		call_cfbi()		# Calcula el coefieciente binomial de n en k.
	
		print_int($v0)			# Imprime el coeficiente binomial 
		fin()				# Finaliza la ejecucion del programa.

     return:
		fin_cfbi_0()		# Conclusion del procedimiento.
	

    # Caso base 1.
    # k = 0 y n >= 0
    base_1:	
		li 	$v0, 1			# Regresamos 1.
		j 	return			
	

    # Caso base 1.
    # n = 0 y k > 0
    base_2:	
		li 	$v0, 0			# Regresamos 0.
		j 	return			



    # Calcula el coeficiente binomial de 
    # n en k.
    #El resultado se guarda en el registro $v0.
    cf_binomial:
		beg_cfbi_0()		# Inicializa para para calcular C(n, k).
	
		caso_base_1($a0, $a1)	# Revisa el primer caso base.
		caso_base_2($a0, $a1)	# Revisa el segundo caso base..
					
	
		beg_cfbi_1()		# llama a C(n-1, k-1).
		call_cfbi()		
		fin_cfbi_1()		
	
		move 	$t0, $v0	# Guardamos el contenido de $v0 en un registro temporal $t0.
	
		beg_cfbi_2()		
		call_cfbi()		
		fin_cfbi_2()		# Termina la llamada C(n-1, k).
	
		add 	$v0, $v0, $t0	# Regresamos de la forma C(n, k) = C(n-1, k-1) + C(n-1, k).
		j 	return			



