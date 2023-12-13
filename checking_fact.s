.data

num: .word 3
msg1: .asciiz "Result: "

.text
.globl main
main:
    li $v0, 4
    la $a0, msg1
    syscall

    lw $a0, num
    jal fact
    move $a0, $v0

    li $v0, 1
    syscall

    li $v0, 10
    syscall

.end main 

fact:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    li $t0, 1
    beq $t0, $a0, return1

    addi $a0, $a0, -1
    jal fact

    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    mul $v0, $v0, $a0
    jr $ra

return1:
    li $v0, 1
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

