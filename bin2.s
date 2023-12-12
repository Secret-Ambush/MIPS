.data
A: .word -32, -16, 0, 8, 16, 32, 64
n: .word 7
data: .word -35
msg1: .asciiz "Data Found at pos: "
msg2: .asciiz "Data Not found"

.text
.globl main
main:
    la $a0, A
    lw $a1, data
    li $a2, 0
    lw $a3, n
    addi $a3, $a3, -1
    jal bin_search
    
    move $t0, $v0
    li $t1, -1
    beq $t0, $t1, msg_not_found

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    j exit

msg_not_found:
    li $v0, 4
    la $a0, msg2
    syscall

exit:
    li $v0, 10
    syscall

bin_search:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    ble $a2, $a3, L1
    li $v0, -1
    addi $sp, $sp, 4
    jr $ra

L1:
    add $t0, $a2, $a3
    srl $t0, $t0, 1
    sll $t1, $t0, 2
    lw $t2, A($t1)
    beq $a1, $t2, equals
    blt $a1, $t2, less_than
    
    addi $a2, $t0, 1
    jal bin_search
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

equals:
    move $v0, $t0
    addiu $sp, $sp, 4
    jr $ra

less_than:
    addi $a3, $t0, -1
    jal bin_search
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra
