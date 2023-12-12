#
#
#int bin_search(int A[], int data, int lo, int hi)
#{
#  int mid;
#  if (lo > hi) return -1
#  mid = (lo + high)/2;
#  if ( data == A[mid]) return mid
#  if ( data < A[mid]) return bin_search(A, data, lo, mid-1)
#  return bin_search(A, data, mid, high)
#}


.data
arr: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
len: .word 10
key: .word 0
msg1: .asciiz "Found!"
msg2: .asciiz "Not Found!"

.text
.globl main
main:
    la $a0, arr     # a0 - array
    lw $a1, key     # a1 - key
    li $a2, 0       # a2 - low
    lw $a3, len     # a3 - high
    addi $a3, $a3, -1
    jal binary_sort

    li $v0, 10
    syscall

.end main

binary_sort:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    ble $a2, $a3, L1

    li $v0, 4
    la $a0, msg2
    syscall

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

L1:
    add $t0, $a2, $a3
    srl $t0, $t0, 1     #divide by 2 - $t0: mid
    mul $t1, $t0, 4
    add $t1, $t1, $a0
    lw $t2, 0($t1)
    beq $t2, $a1, found
    bgt $a1, $t2, greater

    move $a3, $t0       # key < current
    addi $a3, $a3, -1
    jal binary_sort
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

greater:                # key > current
    move $a2, $t0
    jal binary_sort
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

found:
    li $v0, 4
    la $a0, msg1
    syscall

    addi $sp, $sp, 4
    jr $ra

