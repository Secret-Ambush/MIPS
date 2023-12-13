.data 
num: .word 2
.text
.globl main
main:
    lw $a0, num
    jal sumrec

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

.end main


sumrec:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    li $t0, 1
    beq $a0, $t0, return1

    addi $a0, $a0, -1
    jal sumrec

    lw $a0, 4($sp)
    lw $ra, 0($sp)
    add $v0, $v0, $a0
    addi $sp, $sp, 8
    jr $ra


return1:
    li $v0, 1
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
