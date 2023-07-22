.data
	round_prompt: .asciiz "How many round pizzas did you sell today? : "
	square_prompt: .asciiz "How many square pizzas did you sell today? : "
	estimate_prompt: .asciiz "Estimate how many total square footage of pizza sold today: "
	result_general: .asciiz "The total square footage of pizza sold is: "
	result_round: .asciiz "The total square footage of round pizza sold is: "
	result_square: .asciiz "The total square footage of square pizza sold is: "
	woosh: .asciiz "Woosh!"
	bummer: .asciiz "Bummer!"
	newline: .asciiz "\n"
	
	pi: .float 3.14159
	radius: .float 5.00000
	inch_feet_conversion: .float 144.00
	
.text
main:
    # Get user input
    # $t0, $t1 = num of round pizza sold, num of square pizza sold
    # $f0 = estimate of total sales
    li $v0, 4				# Prepare to print text
    la $a0, round_prompt	# Load prompt into argument register
    syscall
    
    li $v0, 5				# Read integer 
    syscall         
    move $t0, $v0			# Store number into $t0
    
    li $v0, 4				# Prepare to print text
    la $a0, square_prompt   # Load prompt into argument register
    syscall
    
    li $v0, 5				# Read integer 
    syscall         
    move $t1, $v0			# Store number into $t1
    
    li $v0, 4				# Prepare to print text
    la $a0, estimate_prompt # Load prompt into argument register
    syscall
    
    li $v0, 6				# Read float     
    syscall  
	#mtc1 $v0, $f0       
	#cvt.s.w $f0, $f0  		# Store estimate in $f0
   
  	# Calculate circular footage (store in $f5)
  	mtc1 $t0, $f6			# Move $t0 to coprocessor 1
  	cvt.s.w $f6, $f6		# Convert amount of round pizzas to floating point
  	l.s $f1, radius			# $f1 = radius of circular pizza
  	l.s $f2, pi				# $f2 = pi
  	l.s $f7, inch_feet_conversion
  	mul.s $f5, $f1, $f1		# $f1 = rad^2
  	mul.s $f5, $f5, $f2		# $f1 = rad^2 * pi
  	mul.s $f5, $f5, $f6		# $f1 = rad^2 * pi * number of round pizzas
  	div.s $f5, $f5, $f7		# Convert to square feet
  	
  	# Calculate square footage (store in $t2)
	mul $t2, $t1, 144		# $t2 = amt square pizzas * 144 square inches
	div $t2, $t2, 144		# Convert square inch to square feet	

  	# Calculate total footage (store in $f3)
  	mtc1 $t2, $f4
  	cvt.s.w $f4, $f4		# Convert integer square footage to floating-point
  	add.s $f3, $f4, $f5		# Calculate total footage (circular + square)
  	
  	# Print results
	li $v0, 4
	la $a0, newline			# Print a newline
	syscall
	
	# Print total footage
    li $v0, 4				# Prepare to print text
    la $a0, result_general  # Load prompt into argument register
    syscall
    
    mov.s $f12, $f3
    li $v0, 2				
    syscall
    
    li $v0, 4
	la $a0, newline			# Print a newline
	syscall
  	
  	# Print circular footage
	li $v0, 4				# Prepare to print text
    la $a0, result_round    # Load prompt into argument register
    syscall
    
    mov.s $f12, $f5
    li $v0, 2				
    syscall
    
    li $v0, 4
	la $a0, newline			# Print a newline
	syscall
    
  	# Print square footage
	li $v0, 4				# Prepare to print text
    la $a0, result_square   # Load prompt into argument register
    syscall
    
    move $a0, $t2
    li $v0, 1				
    syscall
    
	li $v0, 4
	la $a0, newline		# Print a newline
	syscall
    
    # Print footage comparison
	c.lt.s $f0, $f3
	bc1t Woosh
	
Bummer:
	li $v0, 4
	la $a0, bummer
	syscall
	
	j End

Woosh:
	li $v0, 4
	la $a0, woosh
	syscall 

  	End:
  		li $v0, 10      # Call program termination
  		syscall
