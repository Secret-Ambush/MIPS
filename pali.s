.data
str1: .asciiz "Hello there"
msg1: .asciiz "Is a palindrome"
msg2: .asciiz "Is not a palindrome"

.text
.globl main
main:
    la $t0, str1
	li $t1, 11
    add $t2, $t1, $t0


loop:	lbu $t3, 0($t0)		
	    lbu $t4, 0($t2)
        beq $t3, $0, pali
        bne $t3, $t4, notpali
        addi $t0, $t0, 1
        addi $t1, $t1, -1
        j loop

notpali:li $v0, 4
		la $a0, msg2
		syscall
        j exit

pali:   li $v0, 4
		la $a0, msg1
		syscall

exit:	li $v0, 10
		syscall

.end main	