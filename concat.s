.data
str1: .asciiz "Hello "
str2: .asciiz "There!"
len: .word 6

.text
.globl main
main:   la $t0, str1
        la $t1, str2
        lw $t2, len

        add $t0, $t0, $t2

loop:   lbu $t4, 0($t1)
        sb $t4, 0($t0)
        addi $t1, $t1, 1
        addi $t0, $t0, 1
        addi $t2, $t2, -1
        blt $t2, $0, exit
        j loop

exit:   li $v0, 4
        la $a0, str1
        syscall
        
        li $v0, 10
        syscall

.end main


