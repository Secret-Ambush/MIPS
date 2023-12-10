.data
myarr: .space 20

.text
.globl main

main:
    la $t0, myarr     
    li $t3, 5         

loop:
    li $v0, 5      
    syscall
    move $t1, $v0 
    sw $t1, 0($t0)    
    addi $t0, $t0, 4  
    addi $t3, $t3, -1 
    beq $t3, $0, exit2 
    j loop

exit2:
    la $t0, myarr
    li $t3, 5  

loop2:
    lw $a0, 0($t0)
    li $v0, 1
    syscall   
    addi $t0, $t0, 4  
    addi $t3, $t3, -1
    beq $t3, $0, exit
    j loop2

exit:
    li $v0, 10        # Exit the program
    syscall
