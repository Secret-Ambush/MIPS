#int power (int a, int n)
#{ 
#    if (n == 1) return a;
#    return a * power(n - 1);
#}
#main() 
#{  
#  pow = power(a, n);
#}

.data
a: .word 2
n: .word 10
msg1: .asciiz "Result: "
.text
.globl main
main:
    lw $a0, a       #a0 - a number
    lw $a1, n       #a1 - n power
    jal power
    move $t0, $v0

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 10
    syscall

.end main

power:
    addi $sp, $sp, -8
    sw $ra, 0 ($sp)
    sw $a1, 4 ($sp)

    li $t0, 1
    beq $a1, $t0, returna
    addi $a1, $a1, -1
    jal power

    mul $v0, $v0, $a0
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

returna:
    move $v0, $a0
    addi $sp, $sp, 8
    jr $ra









