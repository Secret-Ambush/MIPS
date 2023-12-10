.data
arr: .word 1, 2, 3, 7, 5
len: .word 5
.text
.globl main

main:
    lw $t0, len       
    la $t1, arr       
    move $t3, $t0    
    move $t4, $0        # sum = $t4

adding_loop:
    lw $t5, 0($t1)   
    add $t4, $t4, $t5   # adding to sum
    addi $t0, $t0, -1  
    addi $t1, $t1, 4  
    beq $t0, $0, exit
    j adding_loop  

exit:
    div $t0, $t4, $t3

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10         
    syscall
