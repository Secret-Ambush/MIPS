.data
myarr: .word 10, 40, 150, 0, 170
len: .word 5
msg1: .asciiz "Smallest: "
.text
.globl main
main:   la $t0, myarr
        lw $t1, 0($t0)
        li $t2, 1
        lw $t3, len

loop:   lw $t4, 0($t0)
        bgt $t4, $t1, larger
        move $t1, $t4
larger:addi $t0, $t0, 4
        addi $t2, $t2, 1
        bgt $t2, $t3, exit
        j loop

exit:   li $v0, 4
        la $a0, msg1
        syscall
        
        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 10
        syscall
        
.end main


