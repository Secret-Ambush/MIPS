.data
myarr: .word 10, 40, 150, 0, 170
len: .word 5
msg1: .asciiz "Smallest: "
.text
.globl main
main:   la $t0, myarr
        lw $t1, 0($t0)
        lw $t2, len
        li $t3, 1

loop:   lw $t4, 0($t0)
        ble $t1, $t4, L1

        move $t1, $t4

L1:     addi $t0, $t0, 4
        addi $t3, $t3, 1
        bgt $t3, $t2, exit
        j loop

exit:
        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 10
        syscall

.end main



        