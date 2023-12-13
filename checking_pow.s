.data

num: .word 10
pow: .word 5

msg1: .asciiz "Result: "

.text
.globl main
main:

    li $v0, 4
    la $a0, msg1
    syscall

    lw $a0, num
    lw $a1, pow
    jal powrec

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.end main



powrec:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $t0, 1
    beq $t0, $a1, return1

    addi $a1, $a1, -1
    jal powrec
    mul $v0, $v0, $a0
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

return1:
    move $v0, $a0
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra