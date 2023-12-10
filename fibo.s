.data
msg1: .asciiz "Enter a number: "
msg2: .asciiz "Result: "

.text
.globl main

main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $a0, $v0           # $a0 - number to calculate Fibonacci
    jal fibo

    move $t0, $v0           # $t0 - result

    li $v0, 4
    la $a0, msg2
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 10
    syscall

fibo:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0           # $s0 - number

    li $t1, 1
    beq $s0, $zero, return0  # If $s0 == 0, return 0
    beq $s0, $t1, return1   # If $s0 == 1, return 1

    addi $a0, $s0, -1
    jal fibo
    move $s1, $v0           # Save fibo($s0 - 1) to $s1

    addi $a0, $s0, -2
    jal fibo
    add $v0, $v0, $s1       # Calculate fibo($s0 - 1) + fibo($s0 - 2)

exitfib:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

return1:
    li $v0, 1
    j exitfib

return0:
    li $v0, 0
    j exitfib

.end main
