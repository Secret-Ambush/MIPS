.data

num1: .word 8
msg1: .asciiz "Result: "

.text
.globl main
main:

    li $v0, 4
    la $a0, msg1
    syscall

    lw $a0, num1
    jal fibo

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.end main

fibo:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0

    beq $a0, $0, return0
    li $t0, 1
    beq $a0, $t0, return1

    addi $a0, $s0, -1
    jal fibo 

    move $s1, $v0

    addi $a0, $s0, -2
    jal fibo 

    add $v0, $v0, $s1
exit:   
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

return0:
    li $v0, 0
    j exit

return1:
    li $v0, 1
    j exit
