.data

array: .word 10, 30, 40, 50
key: .word 50
len: .word 5
msg1: .asciiz "Found @ "
msg2: .asciiz "Not Found"

.text
.globl main
main:
    la $a0, array
    lw $a1, key
    li $a2, 0
    lw $a3, len
    addi $a3, $a3, -1

    jal bin_s
    li $t0, -1
    move $t1, $v0

    beq $t0, $t1, notfoun_mess

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    j exit

notfoun_mess:
    li $v0, 4
    la $a0, msg2
    syscall

exit:
    li $v0, 10
    syscall

.end main


bin_s:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    bgt $a2, $a3, notfound

    add $t0, $a2, $a3
    srl $t0, $t0, 1
    mul $t1, $t0, 4
    add $t1, $t1, $a0
    lw $t2, 0($t1)

    beq $t2, $a1, foundb
    bgt $a1, $t2, greaterb

    add $a3, $t0, -1
    jal bins_s
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

greaterb: 
    add $a2, $t0, 1
    jal bin_s
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

foundb:
    move $v0, $t0
    addi $sp, $sp, 4
    jr $ra

notfound:
    li $v0, -1
    addi $sp, $sp, 4
    jr $ra

