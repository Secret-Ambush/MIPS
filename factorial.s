.data
msg1: .asciiz "Enter a number: "
msg2: .asciiz "\n"
msg3: .asciiz "Factorial: "
.text
.globl main

main:   li $v0, 4
        la $a0, msg1
        syscall

        li $v0, 5
        syscall
        move $t0, $v0

        li $t1, 1

loop:   beq $t0, $0, exit
        beq $t0, 1, exit
        mul $t1, $t1, $t0
        addi $t0, $t0, -1
        j loop

exit:   li $v0, 4
        la $a0, msg3
        syscall

        li $v0, 1
        move $a0, $t1
        syscall


        li $v0, 10
        syscall

.end main