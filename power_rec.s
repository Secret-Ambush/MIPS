.data
num: .word 2
pow: .word 5
.text
.globl main
main:
    lw $a0, num
    lw $a1, pow

    jal prec
    move $a0, $v0

    li $v0, 1
    syscall

    li $v0, 10
    syscall

.end main


prec:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t0, 1
    bgt $a1, $t1, L1

    move $v0, $a0
    addi $sp, $sp, 4
    jr $ra

L1: addi $a1, $a1, -1
    jal prec

    mul $v0, $v0, $a0
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


