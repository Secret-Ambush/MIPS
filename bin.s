.data
arr1: .word 1, 2, 3, 4, 5, 6
key: .word 7
len: .word 6
msg1: .asciiz "Found at "
msg2: .asciiz "Not found"

.text
.globl main
main:
    la $a0, arr1
    lw $a1, key
    li $a2, 0
    lw $a3, len
    addi $a3, $a3, -1

    jal binary_search
    move $t0, $v0
    li $t1, -1
    beq $t1, $t0, ntfound

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    j exit

ntfound:
    li $v0, 4
    la $a0, msg2
    syscall

exit:
    li $v0, 10
    syscall

.end main

binary_search:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    bgt $a2, $a3, not_found

    add $t0, $a2, $a3
    srl $t0, $t0, 1
    sll $t1, $t0, 2
    add $t1, $t1, $a0
    lw $t2, 0($t1)

    beq $t2, $a1, equal
    bgt $a1, $t2, greater

    addi $a3, $t0, -1
    jal binary_search
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

not_found:
    li $v0, -1
    addi $sp, $sp, 4
    jr $ra

equal:
    move $v0, $t0
    addi $sp, $sp, 4
    jr $ra

greater:
    addi $a2, $t0, 1
    jal binary_search
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra




