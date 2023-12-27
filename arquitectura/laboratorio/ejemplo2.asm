  .data
    a:  .word 4
    b:  .word 7
    c:  .word 2
    d:   .word 13
    
  .text
    
    #sumar
    lw $t1, a
    lw $t2, b
    lw $t3, c
    lw $t4, d
   
    add $s1, $t1, $t2 #s1=t1+t2
    
    #restar
    sub $s2, $t4, 5  #s2=t1-t2
    
    #multiplicar
    mul $s3, $t3, 2  #s3=t3*2
    
    #dividir
    div $s4, $t4, $t2  #s4=t4/t2
    
    #para obtener residuo
    div $t4, $t2
    
    #move el residuo (hi)
    mfhi $s6