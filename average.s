.data
arr: .word 1, 2, 3, 4, 7
len: .word 5
.text
.globl main

main:
    lw $t0, len       
    la $t1, arr       
    move $t3, $t0    
    move $t4, $0        # sum = $t4

adding_loop:
    lw $t5, 0($t1)   
    add $t4, $t4, $t5   # adding to sum
    addi $t0, $t0, -1  
    addi $t1, $t1, 4  
    beq $t0, $0, exit
    j adding_loop  

exit:
    mtc1 $t4, $f2     # moving to coproc 1 from gen reg
    mtc1 $t3, $f3    
    cvt.s.w $f0, $f2  
    cvt.s.w $f1, $f3  
    div.s $f2, $f0, $f1  

    li $v0, 2           
    mov.s $f12, $f2    
    syscall

    li $v0, 10         
    syscall
