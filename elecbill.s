.data
msg1: .asciiz "Enter number of units: "
msg2: .asciiz "Total bill: "

.text
.globl main

main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6
    syscall                 #f0 - number

    li.s $f1, 50.0
    c.le.s $f0, $f1
    bc1f under150

    li.s $f2, 0.5
    mul.s $f2, $f2, $f0     #f2 - answer
    j exit

under150:
    li.s $f1, 150.0
    c.le.s $f0, $f1
    bc1f under250

    li.s $f1, 50.0
    sub.s $f2, $f0, $f1
    li.s $f1, 0.75
    mul.s $f2, $f2, $f1
    li.s $f1, 25.0
    add.s $f2, $f2, $f1
    j exit

under250:
    li.s $f1, 250.0
    c.le.s $f0, $f1
    bc1f above250

    li.s $f1, 150.0
    sub.s $f2, $f0, $f1
    li.s $f1, 1.20
    mul.s $f2, $f2, $f1
    li.s $f1, 100.0
    add.s $f2, $f2, $f1
    j exit

above250:
    li.s $f1, 250.0
    sub.s $f2, $f0, $f1
    li.s $f1, 1.50
    mul.s $f2, $f2, $f1
    li.s $f1, 220.0
    add.s $f2, $f2, $f1
    j exit

exit:
    li.s $f1, 0.20
    mul.s $f3, $f2, $f1
    add.s $f2, $f2, $f3

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 2
    mov.s $f12, $f2
    syscall

    li $v0, 10
    syscall

.end main

