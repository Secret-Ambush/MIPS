.data
unit_prompt: .asciiz "Enter the number of units: "
bill_msg: .asciiz "Total Electricity Bill: Rs. "
newline: .asciiz "\n"

.text
main:
    # Print the prompt for user input
    li $v0, 4
    la $a0, unit_prompt
    syscall

    # Read the input units
    li $v0, 5
    syscall
    move $s0, $v0   # Store input units in $s0

    # Calculate the bill
    li $t0, 50
    li.s $f0, 0.50    # Rate for first 50 units
    li.s $f1, 0.75    # Rate for next 100 units
    li.s $f2, 1.20    # Rate for next 100 units
    li.s $f3, 1.50    # Rate for units above 250

    # Check conditions and calculate the amount
    ble $s0, $t0, less_than_50
    bgt $s0, 250, above_250

    sub $t1, $s0, $t0   # $t1 = unit - 50

    ble $s0, 150, less_than_150
    # Between 50 and 150 units
    li $t2, 25
    mul.s $f4, $f1, $t1
    j calculate_amt

less_than_150:
    # Between 150 and 250 units
    li $t2, 100
    mul.s $f4, $f2, $t1
    j calculate_amt

above_250:
    # Units above 250
    li $t2, 220
    sub $t1, $s0, 250   # $t1 = unit - 250
    mul.s $f4, $f3, $t1

calculate_amt:
    # Calculate the amount
    add $t2, $t2, $t3   # $t2 = base amount
    mtc1 $t2, $f5   # Move base amount to $f5
    add.s $f4, $f4, $f5   # $f4 = total amount

    # Calculate surcharge
    li.s $f6, 0.20   # Surcharge rate
    mul.s $f7, $f4, $f6   # $f7 = sur_charge

    # Calculate total amount after adding surcharge
    add.s $f4, $f4, $f7   # $f4 = total_amt

    # Print total electricity bill
    li $v0, 4
    la $a0, bill_msg
    syscall

    li $v0, 2
    mov.s $f12, $f4
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall

less_than_50:
    # For units less than or equal to 50
    mul.s $f4, $f0, $s0
    j calculate_amt
