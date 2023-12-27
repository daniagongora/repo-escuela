# Ejercicio 4. Emplear el coprocesador y las instrucciones de punto flotante de precision sencilla
    .data
	n0: 		.float 0.0      #n inicializado en 0
	n1: 		.float 1.0      #valor 1
	v2: 		.float 2.0      #valor 2 flotante
	n2: 		.word 2         #valor 2 entero
	n4:		.float 4.0 	# constante 4 flotante
	m: 		.word 1		# m tambien como n, m = n
	m1: 		.float -1.0     #valor para -1
	
	
	
    .text
	lwc1 $f2, v2 		# $f2 para 2 flotante
	lwc1 $f3, n1		# $f3 para 1 flotante
	lw   $t0, m		# $t0 sera el valor m temporal
	lwc1 $f1, m1	        # $f1 para (-1)^n 
	lw   $t2, n2 		# $t2 para 2 entero
	lwc1 $f0, n0		# $f0 se almacenara el resultado en este registro
	lwc1 $f8, n4		# $f1 = 4.0
	
	
    calculo:
	mtc1 $t0, $f12		# $f12 para m flotante
	cvt.s.w $f12, $f12	# $f12 para pasar de entero a flotante
	
	    # Parte1 = (-1)^n
	    #necesitamos saber si n es par o no para determinar el valor
	    paridad:
		div 	$t0, $t2	# dividimos m entre 2, (m/2)
		mfhi 	$t1		# movemos el residuo a $t1
		bnez    $t1, impar
		b par 		# en otro caso el  numero es par

	    impar:
		lwc1 $f1, m1
		b multiplicacion
	
	    
	    par:
		lwc1 $f1, n1		
			
	    #2n + 1
	    multiplicacion:
		mul.s $f4, $f12, $f2	# multiplicamos 2n 
		add.s $f4, $f4, $f3	# guardamos en f4 = 2n + 1
	
	    # (-1)^n /  2n + 1
	    division:
		div.s $f4, $f1, $f4	# dividimos $f1 / $f4 = (-1)^n /  2n + 1
	
	    # suma el resultado m veces
	    ciclo:
		add.s $f0, $f0, $f4	# $f0 = $f0 + $f4, agregamos el resultado de la iteracion al resultado final
		sub   $t0, $t0, 1	# le restamos a n uno= n-1
		blt   $t0, $zero, fin	# si n es menor a 0 terminamos
		b calculo	       # de lo contrario seguimos iterando
	
	    # Multiplicamos por 4 la suma completa
	    fin: 
		mul.s 	$f0, $f8, $f0	# la suma total *4
