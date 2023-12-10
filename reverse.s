.data
str1: .asciiz "Hello there"
msg: .asciiz "Reverse: "
revstr: .asciiz ""

.text
.globl main

main:	la $t0, str1		
		la $t1, revstr
		li $t2, 0	#length

loop: 	lbu $t3, 0($t0)
		beq $t3, $0, rev1
		addi $t2, $t2, 1
		addi $t0, $t0, 1
		j loop

		li $v0, 1
		move $a0, $t2
		syscall

rev1:	addi $t2, $t2, -1
		la $t0, str1
		add $t0, $t0, $t2

loop1: lbu $t3, 0($t0)
		sb $t3, 0($t1)
		addi $t1, $t1, 1
		addi $t0, $t0, -1
		addi $t2, $t2, -1
		beq $t2, $0, exit
		j loop1

exit:	li $v0, 4
		la $a0, msg
		syscall
		
		li $v0, 4
		la $a0, revstr
		syscall
		
		li $v0, 10
		syscall

.end main