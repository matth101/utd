.data
	prompt: .asciiz "Give me a number between 1 and 10 (0 to stop): "
	countdown: .asciiz "The count down of integers from "
	is: .asciiz " is: \n"
	space: .asciiz " "
	newline: .asciiz "\n"
    itr: .asciiz "ITERATIVE: "
    recur: .asciiz "RECURSIVE: "

.text
main:
	# Get user input
    li $v0, 4			# Prepare to print text
    la $a0, prompt      # Load prompt into argument register
    syscall
    
    li $v0, 5			# Read integer 
    syscall         	
    move $t0, $v0		# Store integer in $t0
    
    # Check if 0 was inputted
    beq $t0, $zero End
	
	li $v0, 4
	la $a0, countdown	# Print beginning of output
	syscall
	
	move $a0, $t0
	li $v0, 1			# Print inputted value
	syscall	
	
	li $v0, 4
	la $a0, is			# Print "is"
	syscall
	
	li $v0, 4
	la $a0, newline		# Print a newline
	syscall
	
	move $a0, $t0
	jal itr_countdown	# Call iterative routine
	
	li $v0, 4
	la $a0, newline		# Print a newline
	syscall
	
	li $v0, 4		
	la $a0, recur		# Print beginning of recursive statement
	syscall
	
	move $a0, $t0
	jal rec_countdown	# Call recursive routine
	
	li $v0, 4
	la $a0, newline		# Print a newline
	syscall
	
	j main
	
itr_countdown:
		move $t1, $a0
		
		li $v0, 4		
		la $a0, itr		# Print beginning of iterative statement
		syscall
		
		Loop: 
			blt $t1, 0, Exit	# Exit loop if 0 is reached
			move $a0, $t1
			li $v0, 1			# Print current value
			syscall
							
			li $v0, 4
			la $a0, space		# Print space to delimit
			syscall												
		
			addi $t1, $t1, -1	# Reduce current value by 1
			j Loop
	
		Exit:
			li $v0, 4	
			la $a0, newline
			syscall
			
			jr $ra				# Go back to where we left off
	
rec_countdown:
		move $t1, $a0
		
		beq $t1, -1, rec_exit	# Exit function if base case = true
		move $a0, $t1
		li $v0, 1				# Print current value
		syscall
		
		li $v0, 4
		la $a0, space			# Print space to delimit
		syscall	
		
		addi $sp, $sp, -4		# Move down on stack
		sw $ra, ($sp)			# Store current return address into address of $sp		
		
		addi $t1, $t1, -1		# Reload argument
		move $a0, $t1
		jal rec_countdown		# Call function again
		
		lw $ra, ($sp)			# Load return address from "top" of stack
		addi $sp, $sp, 4		# Move pointer back up
	
	rec_exit:
		jr $ra					# Return to original point in main:
	
End:
	li $v0, 10
	syscall
	
