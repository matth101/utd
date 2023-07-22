.data
	prompt: .asciiz "Please enter an integer in the range of 0 to 100, inclusive (Enter a 0 to stop the program): "
    result_begin: .asciiz "The double sum of integers from 0 to "
    result_end: .asciiz " is "
    error_message: .asciiz "Error: Invalid input. Integer must be between 0 and 100.\n" # any number out of bounds is invalid

    array: .word 101 # Allocate 101 four-byte words for the output (0 to 100)
    # X: .word 0       # Store sum 
.text
    # Get user input
    li $v0, 4			# Prepare to print text
    la $a0, prompt      # Load prompt into argument register
    syscall
    
    li $v0, 5			# Read integer 
    syscall         
    move $t0, $v0		# Store number into $t0
    
    # Check for invalid input or 0
    beq $t0, 0, End
    blt $t0, 0, Esc
    bgt $t0, 100, Esc
    j NoEsc           	# Bypass program exit            
    
    Esc:
        li $v0, 4
        la $a0, error_message # display error message
        syscall
        
        j End

    NoEsc:
        li $t1, 0       # Keep track of index (i.e. the current integer)
        la $t2, array   # Store address of array for future reference
        li $t3, 2       # Store size of increment
        li $t4, 0       # Track current to-be-stored value

    # Initialize array
    Loop1:    
    	bgt $t1, $t0, Exit1 # Exit loop if index passes inputted integer
        sw $t4, ($t2)       	  # Store current value in the array
        addi $t1, $t1, 1  		  # Increment index
        addi $t2, $t2, 4  		  # Move to next array cell
        add $t4, $t4, $t3  		  # Increase current value by two (2)
          
        j Loop1
    
    Exit1:
    
    li $t5, 0       # $t5 = total sum
    li $t1, 0       # Reset current index
    la $t2, array   # Reset array address pointer    
    j Loop2

	
	 # Traverse array to find sum
    Loop2:    bgt $t1, $t0, Display # Exit loop if index passes inputted integer
        lw $t3, 0($t2)       		# Load current value from array
        add $t5, $t5, $t3  			# Add loaded value to total sum
        addi $t1, $t1, 1    		# Increment index
        addi $t2, $t2, 4       		# Move to next word in array
        j Loop2
   
   # Display result
   Display:    
    li $v0, 4       	 # Prepare to print argument
    la $a0, result_begin # Print string
    syscall
    
    move $a0, $t0
    li $v0, 1
    syscall

    li $v0, 4       	# Prepare to print argument
    la $a0, result_end  # Print string
    syscall
    
    move $a0, $t5
    li $v0, 1       	# Prepare to print word
    syscall    
    
    End:
        li $v0, 10      # Call system call code to exit program
        syscall
