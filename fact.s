.data 

num: .word 10
msg1: .asciiz "Factorial: "

.text
.globl main
main:

    lw $a0, num
    jal fact

    move $t0, $v0

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10
    syscall

.end main


fact:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    li $t0, 1
    beq $a0, $t0, return1

    addi $a0, $a0, -1
    jal fact

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    mul $v0, $v0, $a0
    addi $sp, $sp, 8
    jr $ra

return1:
    li $v0, 1
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8
    jr $ra
