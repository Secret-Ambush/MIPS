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
A: 	.word -32, -16, 0, 8, 16, 32, 64
n: 	.word 7
data: 	.word -35
msg1:   .asciiz "Data Found at pos: "
msg2:   .asciiz "Data Not found"

	.text
	.globl main
main:
	
    la      $a0, A          # $a0 = addr A
	lw	$a1, data	# $a1 =  data to be searched
	li	$a2, 0		# $a2 =  lo
	lw	$a3, n		# $a3 =  n
	addi    $a3, $a3, -1    # $a3 =  high = (n-1)
	jal     bin_search      # bin_search(A, data, lo, high)
    
    move    $t0, $v0
    li      $t1, -1
    beq     $t0, $t1, msg_not_found   # if ($v0 == -1)
    li		$v0, 4
	la		$a0, msg1          # isFound == 1 display msg
	syscall
	li 		$v0, 1      		# print int
    move 	$a0, $t0			# $a0 = $t0 (pos of found ele)
    syscall
    j 		exit

msg_not_found :
    li		$v0, 4              # print str
    la		$a0, msg2           # isFound == 0 display msg
	syscall

exit:
	li 		$v0, 10     		# exit
    syscall         			#

#
# int bin_search(A, data, lo, high)
#
bin_search:
	addiu   $sp, $sp, -4    # space for $ra
	sw 		$ra,  0($sp)    # save $ra
	
    ble     $a2, $a3, L1    # if lo <= high then L1 (continue)
    li      $v0, -1         # else return val ($v0) = -1
    addiu   $sp, $sp, 4     # adjust sp (sp=sp+4)
    jr      $ra             # and return

L1:
    add     $t0, $a2, $a3   # $t0 = lo + high
    srl		$t0, $t0, 1     # (mid)$t0 = $t0/2
	sll		$t1, $t0, 2		# $t1 = $t0 * 4 (int is 4 bytes)
	lw      $t2, A($t1)		# $t2 = A[mid]
	beq     $a1, $t2, equals # ($a1)data == ($t2)A[mid] then equals
    blt     $a1, $t2, less_than # ($a1)data < ($t2)A[mid]
                            # ($a1)data > ($t2)A[mid]
    addi    $a2, $t0, 1    # lo = mid + 1
    jal     bin_search      # bin_search(A, data, mid+1, high)
    lw   	$ra, 0($sp)     # retrive return addr from stack 
    addiu   $sp, $sp, 4     # adjust sp (sp=sp+4)   
    jr      $ra             # and return 

equals:
    move    $v0, $t0        # return val ($v0) = mid ($t0)
    addiu   $sp, $sp, 4     # adjust sp (sp=sp+4)
    jr      $ra             # and return 

less_than:                  # ($a1)data < ($t2)A[mid]
    addi    $a3, $t0, -1    # high = mid -1
    jal     bin_search      # bin_search(A, data, lo, mid-1)
    lw   	$ra, 0($sp)     # retrive return addr from stack 
    addiu   $sp, $sp, 4     # adjust sp (sp=sp+4)   
    jr      $ra             # and return 
