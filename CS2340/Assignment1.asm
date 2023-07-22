.data
	message_first: .asciiz "Enter a number: "
	message_sec: .asciiz "Enter another number: "
	result_start: .asciiz "The difference of X and Y (X-Y) is "
	result_end: .asciiz "."
	
	# Create three 32-bit units on word boundary
	X: .word 0 
	Y: .word 0
	D: .word 0
	
.text
	main:
		# Get first number
		li $v0, 4 		# Prepare to print text
		la $a0, message_first	# Load prompt into argument register
		syscall
	
		li $v0, 5		# Display prompt for first integer
		syscall
	
		sw $v0, X 		# Store first number into X
		lw $s0, X 		# Load X into register
		
		# Get second number
		li $v0, 4 		# Prepare to print text
		la $a0, message_sec 	# Load prompt into argument register
		syscall
		
		li $v0, 5 		# Display prompt for second integer
		syscall

		sw $v0, Y 		# Store second number
		lw $s1, Y 		# Load Y into register
		
		sub $t0, $s0, $s1 	# Calculate difference and store in temporary register: t0 = s0-s1 
		sw $t0, D 		# Store difference into D
		
		# Print start of result
		li $v0, 4 		# Prepare to print text
		la $a0, result_start 	# Load and print beginning part of output 
		syscall
	
		# Show difference
		li $v0, 1 		# Prepare to print a word
		lw $a0, D 		# Load and print calculated difference
		syscall
		
		# Print end of result
		li $v0, 4 		# Prepare to print text
		la $a0, result_end 	# Load and print ending part of output
		syscall
	
	


