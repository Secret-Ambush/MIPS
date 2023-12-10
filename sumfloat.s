.data
msg1: .asciiz "Enter a number: "
msg2: .asciiz "Result: "
sym1: .asciiz "+"
sym2: .asciiz "i"

.text
.globl main
main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6
    syscall
    mov.s $f1, $f0  # number 1

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6
    syscall
    mov.s $f2, $f0  # number 2

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6
    syscall
    mov.s $f3, $f0  # number 3

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6
    syscall
    mov.s $f4, $f0  # number 4

    add.s $f5, $f1, $f3
    add.s $f6, $f2, $f4

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 2
    mov.s $f12, $f5
    syscall

    li $v0, 4
    la $a0, sym1
    syscall

    li $v0, 4
    la $a0, sym2
    syscall

    li $v0, 2
    mov.s $f12, $f6
    syscall

    li $v0, 10
    syscall
