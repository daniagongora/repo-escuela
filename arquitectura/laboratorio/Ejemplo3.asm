#implementación de la formula general
.text
  #introducimos a
  li $v0, 5
  syscall
  move $s0 $v0
  
  #introducimos b
  li $v0, 5
  syscall
  move $s1 $v0
  
  #introducimos c
  li $v0, 5
  syscall
  move $s2 $v0