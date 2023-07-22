.data
	welcome_prompt: .asciiz "Welcome to Dots and Boxes! You will be competing against the computer.\n"
	format_exp: .asciiz "Borders are selected in double-digit format. Examples: vertical, 00 = leftmost, topmost vertical border; horizontal, 07 = rightmost, topmost horizontal border.\n"
	turn_prompt: .asciiz "Select an unclaimed border you'd like to fill according to the format and board displayed above.\n"
	line_type: .asciiz "Are you selecting a horizontal or vertical box border? Type \"1\" for horizontal, \"2\" for vertical, or \"3\" to exit the game: "
	row_prompt: .asciiz "Select the row (from 0 to 6): "
	column_prompt: .asciiz "Select the column: (0 to 8): "
	 invalid_type: .asciiz "Please enter only 1 or 2 or 3. \n"
	 invalid_dimension: .asciiz "Please enter within the bounds \n"
	 bye: .asciiz "Restart the program to play again"
	farewell: .asciiz "Thank you for playing Dots and Boxes!"
	store: .byte ' '
	
.text
.globl welcome
.globl user_input
	# Display preliminary prompts
	# input_loop:
	welcome:
		li $v0, 4
		la $a0, welcome_prompt			# Display welcome message
		syscall
	
		li $v0, 4
		la $a0, format_exp				# Display formatting explanation
		syscall
	
	user_input:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
	
		li $v0, 4
		la $a0, turn_prompt				# Display prompt for player's turn
		syscall
	
		li $v0, 4
		la $a0, line_type				# Ask for type of line being selected
		syscall
	
		li $v0, 5 						# Read in number
		syscall
		
		beq $v0, 3, exit_game
		blt $v0, $zero, badtype
		li $t5,3
		bgt $v0, $t5, badtype
		move $s2, $v0 					# Store line type in $s2
	
		beq $v0, 1, horizontal_prompt
		beq $v0, 2, vertical_prompt
		
		
		horizontal_prompt:
			# line type = $
			# (row, col) = ($s0, $s1) ALWAYS
			li $v0, 4
			la $a0, row_prompt
			syscall
		
			li $v0, 5
			syscall
			move $s0, $v0				# Store row into $s0
			
			blt $v0, $zero, invalidinput
			li $t1, 6
			bgt $v0, $t1, invalidinput
			li $v0, 4
			la $a0, column_prompt
			syscall
				
			li $v0, 5
			syscall
			move $s1, $v0				# Store col into $s1
			blt $v0, $zero, invalidinput
			li $t1, 6
			bgt $v0, $t1, invalidinput
			j next
		
		vertical_prompt:
			# (col, row) = ($s0, $s1)
			li $v0, 4
			la $a0, column_prompt 
			syscall
		
			li $v0, 5
			syscall
			move $s1, $v0				# Store column into $s1
			blt $v0, $zero, invalidinput
			li $t1, 8
			bgt $v0, $t1, invalidinput
			li $v0, 4
			la $a0, row_prompt
			syscall
			blt $v0, $zero, invalidinput
			li $t1, 6
			bgt $v0, $t1, invalidinput
			li $v0, 5
			syscall
			move $s0, $v0				# Store row into $s0
	
			next:
				lw $ra, 0($sp)
				addi $sp, $sp, 4
				jr $ra
	invalidinput:
	li $v0, 4
	la $a0, invalid_dimension
	syscall
	li $v0, 4
	la $a0, bye
	syscall
	li $v0, 10
	syscall
	badtype:
	li $v0, 4
	la $a0, invalid_type
	syscall
	li $v0, 4
	la $a0, bye
	syscall
	li $v0, 10
	syscall
	exit_game:
		li $v0, 4
		la $a0, farewell
		syscall
			
		li $v0, 10
		syscall