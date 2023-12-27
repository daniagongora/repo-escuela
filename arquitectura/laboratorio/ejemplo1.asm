 .data 
   mensaje:  .asciiz  "hola mundo\n"
   myInt:    .word 123
   myFloat:  .float 3.1416
   myDouble:  .double 3.1416453536
  
  .text
    #imprime un string
    li $v0, 4
    la $a0, mensaje
    syscall
    
    #imrpime un entero
    li $v0, 1
    lw $a0, myInt
    syscall 
    
    #imprime un float
    li $v0, 2
    lwc1 $f12, myFloat
    syscall  
    
    #imprime double
    li $v0, 3
    ldc1 $f12, myDouble
    syscall 