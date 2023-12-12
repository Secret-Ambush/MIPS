.data
num1: .word 9
.text
.globl main

main:
    lw $a0, num1 # Load the value of num1 (initial number) into $a0

    jal fibo     # Jump to the fibo function
    move $a0, $v0  # Move the result of fibo function to $a0 (for printing)

    li  $v0, 1   # Set $v0 to 1 (syscall code for printing integer)
    syscall      # Perform syscall to print the result

    li $v0, 10   # Exit syscall code
    syscall      # Exit the program

fibo:
    addi $sp, $sp, -12  # Adjust stack for storing $ra, $s0, $s1
    sw $ra, 0($sp)      # Save $ra on the stack
    sw $s0, 4($sp)      # Save $s0 on the stack
    sw $s1, 8($sp)      # Save $s1 on the stack

    move $s0, $a0       # Save $a0 (n) into $s0

    li $t0, 0           # Base case check: if n == 0, return 0
    beq $s0, $t0, return0

    li $t0, 1           # Second base case check: if n == 1, return 1
    beq $s0, $t0, return1

    addi $a0, $s0, -1   # Calculate fib(n-1)
    jal fibo
    move $s1, $v0       # Save the result of fib(n-1) in $s1

    addi $a0, $s0, -2   # Calculate fib(n-2)
    jal fibo

    add $v0, $v0, $s1   # Add fib(n-1) + fib(n-2) and store in $v0
    j exit              # Jump to exit

return0:
    li $v0, 0           # Set $v0 to 0 (return 0)
    j exit              # Jump to exit

return1:
    li $v0, 1           # Set $v0 to 1 (return 1)
    j exit              # Jump to exit

exit:
    lw $ra, 0($sp)      # Restore $ra from the stack
    lw $s0, 4($sp)      # Restore $s0 from the stack
    lw $s1, 8($sp)      # Restore $s1 from the stack
    addi $sp, $sp, 12   # Restore stack pointer
    jr $ra              # Jump back to the caller

