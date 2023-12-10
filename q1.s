.data
mystr1: .space 10
msg1: .asciiz "Enter a string: "
msg2: .asciiz "Reverse: "
msg3: .asciiz "Entered string is a palindrome"
msg4: .asciiz "Entered string is not a palindrome"
msg5: .asciiz "\n"
msg6: .asciiz "Length: "
mystr2: .asciiz ""

.text
.globl main
main:   li $v0, 4
        la $a0, msg1
        syscall

        li $v0, 8
        la $a0, mystr1
        li $a1, 10
        syscall

        li $t0, -1       #length
        la $t2, mystr1  #string1

#Finding length of string

loop:   lbu $t3, 0($t2)
        beq $t3, $0, exit1
        addi $t0, $t0, 1
        addi $t2, $t2, 1
        j loop

exit1:  li $v0, 4
        la $a0, msg6
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, msg5
        syscall

        la $t2, mystr1  #string1
        la $t3, mystr2  #string2

        move $t5, $t0   #length in $t5
        addi $t0, $t0, -1
        add $t2, $t2, $t0

#Finding reverse of string

loop2:  blt $t0, $0, exit2
        lbu $t4, 0($t2)
        sb $t4, 0($t3)
        addi $t0, $t0, -1
        addi $t2, $t2, -1
        addi $t3, $t3, 1
        j loop2

exit2:  li $v0, 4
        la $a0, msg2
        syscall

        li $v0, 4
        la $a0, mystr2
        syscall

        li $v0, 4
        la $a0, msg5
        syscall

        la $t2, mystr1  #string1
        la $t3, mystr2  #string2

#Checking if palindrome

loop3:  beq $t5, $0, pali
        lbu $t4, 0($t2)
        lbu $t6, 0($t3)
        bne $t4, $t6, notpali
        addi $t2, $t2, 1
        addi $t3, $t3, 1
        addi $t5, $t5, -1
        j loop3

notpali:li $v0, 4
        la $a0, msg4
        syscall

        j exit

pali:   li $v0, 4
        la $a0, msg3
        syscall

exit:   li $v0, 10
        syscall

.end main
