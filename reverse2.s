.data
inp_str: .asciiz "Computer Architecture"
msg1: .asciiz "\n"
msg2: .asciiz "Reverse: "
rev_str: .space 80

.text
.globl main
main:
    la $t0, inp_str
    la $t1, rev_str
    li $t2, 0       #length

    li $v0, 4
    la $a0, inp_str
    syscall

    li $v0, 4
    la $a0, msg1
    syscall


loop:
    lbu $t3, 0($t0)
    beq $t3, $0, out
    addi $t2, $t2, 1
    addi $t0, $t0, 1
    j loop

out:
    la $t0, inp_str
    addi $t2, $t2, -1
    add $t0, $t0, $t2

loop2:
    lbu $t3, 0($t0)
    sb $t3, 0($t1)

    addi $t1, $t1, 1
    addi $t0, $t0, -1
    addi $t2, $t2, -1
    blt $t2, $0, exit
    j loop2

exit:
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 4
    la $a0, rev_str
    syscall

    li $v0, 10
    syscall

.end main
