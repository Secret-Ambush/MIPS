.data
msg1: .asciiz "Enter a number: "
msg2: .asciiz "Sum: "
.text
.globl main
main:   li $v0, 4
        la $a0, msg1
        syscall
        
        li $v0, 5
        syscall
        move $t0, $v0

        li $t1, 0   #sum
        li $t2, 1   #counter

loop:   bgt $t2, $t0, exit
        add $t1, $t1, $t2
        addi $t2, $t2, 1
        j loop

exit:   li $v0, 4
        la $a0, msg2
        syscall
        
        li $v0, 1
        move $a0, $t1
        syscall

        li $v0, 10
        syscall
        
.end main


