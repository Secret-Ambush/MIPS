.data
arr1: .word 10, 20, 30, 40, 90, 100
len: .word 6
.text
.globl main

main:   la $t0, arr1
        lw $t1, len
        li $t2, 0   #counter
        li $t3, 0   #sum

loop:   lw $t4, 0($t0)
        add $t3, $t3, $t4
        addi $t2, $t2, 1
        addi $t0, $t0, 4
        beq $t2, $t1, exit
        j loop

exit:   li $v0, 1
        move $a0, $t3
        syscall

        li $v0, 10
        syscall

.end main