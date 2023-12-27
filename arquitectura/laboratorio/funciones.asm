  .data
   mensaje:  .asciiz  "hola mundo\n"
   
  .text
    main:
      li $t1,10
      jal while
      
      li $v0, 10
      syscall
    print:
      li $v0, 4
      move $a0, $a1
      syscall
      jr $ra #sale de la función y salta
      
   while:
     beqz $t1, exit   #si t1==0 entonces brincamos a exit
     sub $t1, $t1, 1  # t1=t1-1
     j while          #volvemos a brincar al inicio del while
     
  exit:
    li $v0, 4
    la $a0, mensaje
    jr $ra