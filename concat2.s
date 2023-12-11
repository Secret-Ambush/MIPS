.data
str1: .asciiz "Hello"
str2: .asciiz "There"
msg: .asciiz "Concatenated string: "


.text
.globl main
main:
    la $t0, str1
    li $t5, 0

l1: lbu $t1, 0($t0)
    beq $t1, $0, exit
    addi $t5, $t5, 1
    addi $t0, $t0, 1
    j l1

exit:
    la $t1, str2

l2: lbu $t2, 0($t1)
    sb $t2, 0($t0)
    addi $t0, $t0, 1
    beq $t5, $0, exit2
    addi $t1, $t1, 1
    addi $t5, $t5, -1
    j l2

exit2:
    li $v0, 4
    la $a0, msg  # Load address of the message "Concatenated string: "
    syscall

    li $v0, 4
    la $a0, str1  # Load address of the concatenated string (str1 now contains both strings)
    syscall

    li $v0, 10
    syscall

.end main


