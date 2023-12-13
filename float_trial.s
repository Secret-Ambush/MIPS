.data

array: .float 10.0, 20.0, 40.0

.text
.globl main
main:
    la $t0, array
    lwc1 $f0, 0($t0)
    li $v0, 2
    mov.s $f12, $f0
    syscall

    li $v0, 10
    syscall

.end main