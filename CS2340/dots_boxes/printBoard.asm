.data
    newline: '\n'
    dot:    .asciiz "*"
    rline:    .asciiz "-"
    cline:    .asciiz "|"
    space:    .asciiz " "
    user_score: .asciiz "Player score: "
    comp_score: .asciiz "Computer score: "
    player_won: .asciiz "You won! Congratulations!"
    comp_won: .asciiz "You lost! Better luck next time!"
    no_winners: .asciiz "Tie game! Nice effort!"
    farewell: .asciiz "Thank you for playing Dots and Boxes!"
    cols: .asciiz "	0   1   2   3   4   5   6   7   8\n"
    rows: .asciiz "0"
        		.asciiz "1"
        	 .asciiz "2"
        	 .asciiz "3"
        	 .asciiz "4"
        	 .asciiz "5"
        	 .asciiz "6"
 		 .asciiz " "
    
    isUserInput: .word 0 # 0 if user, 1 if computer
    
    .align 2
    bool_rlline_1: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_2: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_3: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_4: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_5: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_6: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_rlline_7: .word 0, 0, 0, 0, 0, 0, 0, 0
    
    .align 2
    bool_clline_1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    bool_clline_2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    bool_clline_3: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    bool_clline_4: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    bool_clline_5: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    bool_clline_6: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
    
    .align 2 # Is box filled?
    bool_box_r1: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_box_r2: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_box_r3: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_box_r4: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_box_r5: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_box_r6: .word 0, 0, 0, 0, 0, 0, 0, 0
    
    .align 2 # Maintains box state
    bool_score_r1: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_score_r2: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_score_r3: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_score_r4: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_score_r5: .word 0, 0, 0, 0, 0, 0, 0, 0
    bool_score_r6: .word 0, 0, 0, 0, 0, 0, 0, 0
    
.text
.globl printBoard
.globl endGame

      printBoard:
      li $t9, 1
      # li $t1, 0
	 
      # UPDATE w/ PLAYER MOVE-------------------------------------------
		 li $t0, 0  			  # Ensure user state is player
   	   sw $t0, isUserInput
      beq $s2, 1, updateHor
  	 
        # (s0, s1, s2) = (row, col, vert or horiz)
   	 
   	   # ADDING COLS    
   	   beq $s0, 0, vertcase1  
     	   vertswitch2:
     	   beq $s0, 1, vertcase2
     	   vertswitch3:
     	   beq $s0, 2, vertcase3
     	   vertswitch4:
     	   beq $s0, 3, vertcase4
     	   vertswitch5:
     	   beq $s0, 4, vertcase5
     	   vertswitch6:
     	   beq $s0, 5, vertcase6
     	   vert_switch_exit:
   		   #t7 has correct array address
   		   li $t2, 0
   		   li $t6, 0    
   		   vert_loop:
   		   bge $t6, 9, exitUpdater
   			   #lw $t2, 0($t7)
   			   addi $t7 $t7, 4
     		   #add $t2, $t6, $t6 			   #t7 (array address) is incremented
     		   #add $t2, $t2, $t2
     		   #add $t7, $t7, $t2
     		 
     		   beq $t6, $s1, modify_col
     			   addi $t6, $t6, 1
     			   j vert_loop
     		   modify_col:
     			   sw $t9, -4($t7)  				   # Change col value
     			   j exitUpdater
   		 
   	   # FOR ADDING DASHES
   	   updateHor:
     	   beq $s0, 0, horcase1  
     	   horswitch2:
     	   beq $s0, 1, horcase2
     	   horswitch3:
     	   beq $s0, 2, horcase3
     	   horswitch4:
     	   beq $s0, 3, horcase4
     	   horswitch5:
     	   beq $s0, 4, horcase5
     	   horswitch6:
     	   beq $s0, 5, horcase6
     	   horswitch7:
     	   beq $s0, 6, horcase7
     	   hor_switch_exit:
   		   #t7 has correct array address
   		 
   		   li $t6, 0    
   		   li $t2, 0
   		   hor_loop:
     	   bge $t6, 8, exitUpdater 			 
   			   #lw $t2, 0($t7)
   			   addi $t7 $t7, 4
     		   #add $t2, $t6, $t6 			   #t7 (array address) is incremented
     		   #add $t2, $t2, $t2
     		   #add $t7, $t7, $t2
     		 
     		   beq $t6, $s1, modify_hor
     		   addi $t6, $t6, 1
     			 
  			  j hor_loop  
				   modify_hor:
     			   sw $t9, -4($t7)  				   # Change col value
      			  j exitUpdater
	 
   	   exitUpdater:
   		   j startCheckAllBoxes
   	 
    # COMPUTER MOVE ------------------------------------------------------------------------
       computerMove:
  	  li $t0, 1
  	  sw $t0, isUserInput 						   # Change user state to computer
    
  	  startTakeSafeThree:


  	  li $a2, 0
  	  li $t2, 1 		  # Load constant
  	  li $t4, 0 		  # Outer index for moving through each box array
  	  li $t5, 0 		  # Inner index for marching in the chunk arrays
  	  takeSafeThree:      # Check if boxes filled for a given box row array ($a2 = box row number)
  			  li $a0, 0 		  # BOOLEAN: 0 = no valid threebox move found; 1 = takeSafeThree made at least one move
  		  bge $t4, 8, exitTakeSafeThree  			  # Load correct array addresses based off box
  			  beq $a2, 0	, box1_comp  
  			  boxswitch2_comp:
  			  beq $a2, 1, box2_comp  
  			  boxswitch3_comp:
  			  beq $a2, 2, box3_comp  
  			  boxswitch4_comp:
  			  beq $a2, 3, box4_comp
  			  boxswitch5_comp:
  			  beq $a2, 4, box5_comp
  			  boxswitch6_comp:
  			  beq $a2, 5, box6_comp
  			  box_switch_comp_exit:
  			  # t6-9 have been locked and loaded baby
     	 
  			  checkSafeChunk:
  				  bge $t5, 8, exitCheckSafeChunk 	   # $t5 = index for box
      				  lw $s3, ($t3)  	  # Load box state (filled; taken by user or comp)
      				  lw $s4, ($t7)  	  # Load top row line
      				  lw $s5, ($t8)  	  # Load bottom row line
      				  lw $s6, ($t9)  	  # Load left column
      				  lw $s7, 4($t9) 	  # Load right column (next element in curr col array)
     			 
      				  li $a3, 0  		  # Local count variable
      				  sw $zero, ($t6)  	  # Reset to zero
     			 
      				  # Count number of lines for current box
      				  beq $s4, 1, increment_1_safe
          				  incrSwitch2_safe:
      				  beq $s5, 1, increment_2_safe
          				  incrSwitch3_safe:
      				  beq $s6, 1, increment_3_safe
          				  incrSwitch4_safe:
      				  beq $s7, 1, increment_4_safe
          				  incrSwitchSafeExit:
         			 
      				  sw $a3, ($t6)  	  # Save increment
      				  beq $a3, 3, findUnfilled
     				 		  j unfilledExit 			# If this isn't a three-box, just move on
                           			 
 						   findUnfilled:     
     					   # Top row is unfilled----------------------------------
     						   beq $s4, 1, checkBottomRow    
     									   sw $t2, ($t7) 	   # Load 1 into current top row line
     									   addi $a3, $a3, 1
     									   sw $a3, ($t6) 	  # Mark value box array as 4
     									   addi $a3, $a3, -2    # Make $a3 = 2
     									   sw $a3, ($t3) 	   # Mark as taken by computer
     									   li $a0, 1
     									   j takeSafeThree
     					 
     						   checkBottomRow:
     						   # Bottom row is unfilled-------------------------
     						   beq $s5, 1, checkLeftCol 	 
     						 
     								   sw $t2, ($t8) 	   # Load 1 into current top row line
     								   addi $a3, $a3, 1
     								   sw $a3, ($t6) 	  # Mark value box array as 4
     								   addi $a3, $a3, -2    # Make $a3 = 2
     								   sw $a3, ($t3) 	   # Mark as taken by computer
     								   li $a0, 1
     								   j takeSafeThree 							 
     					 
     					   checkLeftCol:
     					   # Left column is unfilled-------------------------
     					   beq $s6, 1, checkRightCol 	 
     						 
     								   sw $t2, ($t9) 	   # Take left col
     								   addi $a3, $a3, 1
     								   sw $a3, ($t6) 	  # Mark value box array as 4
     								   addi $a3, $a3, -2    # Make $a3 = 2
     								   sw $a3, ($t3) 	   # Mark as taken by computer
     								   li $a0, 1
     								   j takeSafeThree 	   # Make another move. 					 
     					 

     					   checkRightCol:
     					   # Right column is unfilled-------------------------
     					   beq $s7, 1, unfilledExit 	   # Right column unfilled
     						 
     							   rightColTake:
     								   sw $t2, 4($t9) 	   # Take left col
     								   addi $a3, $a3, 1
     								   sw $a3, ($t6) 	  # Mark value box array as 4
     								   addi $a3, $a3, -2    # Make $a3 = 2
     								   sw $a3, ($t3) 	   # Mark as taken by computer
     								   li $a0, 1
     								   j takeSafeThree 	   # Make another move.
     					 
      			  unfilledExit:			 
     			 
      			  # march to next box + box-related info

      			  addi $t3 $t3, 4
      			  addi $t6 $t6, 4  			  # March to next "box" in the current box row array
      			  addi $t7 $t7, 4  			  # March to next "box" in the current box row array
      			  addi $t8 $t8, 4  			  # March to next "box" in the current box row array
      			  addi $t9 $t9, 4  			  # March to next "box" in the current box row array
     			 
      			  addi $t5, $t5, 1
      			  j checkSafeChunk
 			 
  			  exitCheckSafeChunk:

			  addi $t4, $t4, 1
			  addi $a2, $a2, 1
			  j takeSafeThree
   		 
  	  exitTakeSafeThree:
     	   beq $a0, 0, makeLegalMove  		  # this is bad because if a move was made and takethree is relooped, a1
     		   li $t7, 0
     		   sw $t7, isUserInput 		   # Change user state to user
     		   j goToPrint 				   # Box wasn't filled during comp turn --> print and switch to user turn

      
     	   # dummy move function
  	  makeLegalMove:
      
     	   # MAKE A LEGAL MOVE ----------------------------------------------
        	#li $a1, 6  #Here you set $a1 to the max bound.
       	# li $v0, 42  #generates the random number.
   	   	#syscall
   	   	#move $t0, $v0
   	  	# li $v0, 1   #1 print integer
   	  	# move $a0, $t0
   	  	# syscall
        	li $t9, 1
        	li $t0, 0
        	#move $t0, $v0
        	legalLoop1:
     	   	bge $t0 6 exitLegalLoop1 		   # Loop through each row
     	   	# ROWS
     	   	li $t1 0
     	   	legalLoop2:
     			   bge $t1 8 exitLegalLoop2 	   # For current row, loop through column spaces
     		 
 				   # switch-case to load proper ROW array address (based on outer loop)
     			   addi $sp, $sp, -4      # Decrement the stack pointer to allocate space for $ra
     			   sw $ra, 0($sp)   	  # Save the return address on the stack
     			   beq $t0, 0, legalhorcase1  
 				   legalhorswitch2:
     				   beq $t0, 1, legalhorcase2
     			   legalhorswitch3:
     				   beq $t0, 2, legalhorcase3
 				   legalhorswitch4:
     				   beq $t0, 3, legalhorcase4
     			   legalhorswitch5:
     				   beq $t0, 4, legalhorcase5
 				   legalhorswitch6:
     				   beq $t0, 5, legalhorcase6
     		 
     			   legalhor_switch_exit:
     			   # $t7 now contains base address for current row array
     		 
 				   li $t6, 0 			   # Define index for array
     			   legal_row_bool_loop:
     				   bge $t6, 7, exit_legal_row_bool_loop
    
     				   add $t2, $t1, $t1 			   #t7 (array address) is incremented
     				   add $t2, $t2, $t2
     				   add $t7, $t7, $t2
					   lw $t8, ($t7) 				   # Load value of index into $t3
     	 
     				   beq $t8, 1, rowSkip 			   # If t8 = 1, march to next cell
     					   sw $t9, ($t7)
     					   j exitLegalLoop4
     				 
 					   rowSkip:
     					   addi $t6, $t6, 1
     					   j legal_row_bool_loop
     		 
     				   exit_legal_row_bool_loop: 	   # Move on to next row array
     					   add $t1 $t1 1
     					   j legalLoop2
     		   exitLegalLoop2:    
     		   # COLUMNS
     	   	li $t1 0
     	   	legalLoop3: bge $t1 9 exitLegalLoop3 		   #
     		 
     			   # switch-case to load proper ROW array address (based on outer loop)
     			   addi $sp, $sp, -4   	   # Decrement the stack pointer to allocate space for $ra
     			   sw $ra, 0($sp)  		   # Save the return address on the stack
     			   beq $t0, 0, legalvertcase1  
     			   legalvertswitch2:
     				   beq $t0, 1, legalvertcase2
 				   legalvertswitch3:
     				   beq $t0, 2, legalvertcase3
     			   legalvertswitch4:
     				   beq $t0, 3, legalvertcase4
     		   	legalvertswitch5:
     				   beq $t0, 4, legalvertcase5
 				   legalvertswitch6:
     				   beq $t0, 5, legalvertcase6
     		 
 				   legalvert_switch_exit:
     			   # $t7 now contains base address for row array
     		 
 				   li $t6, 0 			   # Define index for array
     			   legal_col_bool_loop:
     				   bge $t6, 9, exit_legal_col_bool_loop 			 
     				   add $t2, $t1, $t1 			   #t7 (array address) is incremented
     				   add $t2, $t2, $t2
 					   add $t7, $t7, $t2 		   # March to next array cell
     					   lw $t8, ($t7) 			   # Load value of index into $t3 		 

     					   beq $t8, 1, colSkip 		   # If t8 = 1, skip to something else
     						   sw $t9, ($t7)
     					   	j exitLegalLoop4
     				   	colSkip:
     						   addi $t6, $t6, 1
     						   j legal_col_bool_loop
     				 
     				   exit_legal_col_bool_loop:
     				   add $t1 $t1 1
     				   j legalLoop3

 			   exitLegalLoop3:
      
     	   exitLegalLoop1:
     	   # add $t2 $t0 $t0 DO WE NEED THIS no apparently
     		   li $t1 0
     	   	legalLoop4:
     			  bge $t1 8 exitLegalLoop4    # Check last row
     		   	la $t7, bool_rlline_7
     		   	li $t6, 0 						   # Define index for array
     		   	legal_last_row_loop:
     				   bge $t6, 9, exit_legal_last_row_loop
     			   	add $t2, $t1, $t1 			   #t7 (array address) is incremented
     			   	add $t2, $t2, $t2
     			   	add $t7, $t7, $t2
     			   	lw $t8, ($t7) 				   # Load value of index into $t3    
					 
     			   	# Print according to array's curr value
     			   	beq $t8, 1, lastLegalSkip 	   # Jump to print a line instead
     				   	sw $t9, ($t7)
     				   	j exitLegalLoop4 	 
     			 
     			   	lastLegalSkip:
     				   	addi $t6, $t6, 1
     				   	j legal_last_row_loop
     				 
     		   	exit_legal_last_row_loop: 	 
     			   	add $t1 $t1 1
     				   j legalLoop4
     	 
     	   	exitLegalLoop4:
     	   	li $t4, 1
     	   	sw $t4, isUserInput 			   # State is computer    
     	 
    li $t4, 0  		   # Outer index for moving through each box array
    li $t5, 0 		   # Inner index for marching in the chunk arrays
    # CHECK BOARD -----------------    --------------------------- 	 
    startCheckAllBoxes: 	   # Check if boxes filled for a given box row array ($a2 = box row number)
        li $a1, 0  		   # Boolean for scoring --> 0 = no boxes filled; 1 = at least one box was filled
        li $a2, 0 		   # dummy argument
        checkAllBoxes:
        bge $t4, 8, exitCheckAllBoxes 			   # Load correct array addresses based off box
     	   beq $a2, 0, box1  
     	   boxswitch2:
     	   beq $a2, 1, box2
     	   boxswitch3:
     	   beq $a2, 2, box3
     	   boxswitch4:
     	   beq $a2, 3, box4
     	   boxswitch5:
     	   beq $a2, 4, box5
     	   boxswitch6:
     	   beq $a2, 5, box6
     	   box_switch_exit:
     	   # t6-9 have been locked and loaded baby
     	 
     	   checkChunk:
     		   bge $t5, 8, exitCheckChunk
     			   lw $s3, ($t3) 	   # Load box state (filled; taken by user or comp)
     			   lw $s4, ($t7) 	   # Load top row line
     			   lw $s5, ($t8) 	   # Load bottom row line
     			   lw $s6, ($t9) 	   # Load left column
     			   lw $s7, 4($t9) 	   # Load right column (next element in curr col array)
     			 
     			   li $a3, 0 		   # Local count variable
     			   sw $zero, ($t6) 	   # Reset to zero
     			 
     			   beq $s4, 1, increment_1
     				   incrSwitch2:
     			   beq $s5, 1, increment_2
     				   incrSwitch3:
     			   beq $s6, 1, increment_3
     				   incrSwitch4:
     			   beq $s7, 1, increment_4
     				   incrSwitchExit:
     				 
     			   sw $a3, ($t6) 	   # Save increment
     			   beq $a3, 4, raiseFlag 		   # Is it a newly-filled box?
     				   j march
     			   raiseFlag:
     				   beq $s3, 0, changeState 	   # Is it also an unclaimed box?
     					   j march 					 
     				   changeState:
     					   li $a1, 1 			   # Record that someone score.
     					   lw $t2, isUserInput
     					   beq $t2, 0, assignUser    # Check who filled it and assigned accordingly
     						   li $t0, 2
     						   sw $t0, ($t3) 	   # Mark as 2 for computer-filled
     						   j march
     					   assignUser:
     						   li $t1, 1
     						   sw $t1, ($t3) 	   # Mark as 1 for user-filled into score array(for later iteration) 					 
     			 
     			   # assign to computer? 				 
     			 
     			 
     			   # march to next box + box-related info
     			   march:
     			   addi $t3 $t3, 4
     			   addi $t6 $t6, 4 			   # March to next "box" in the current box row array
     			   addi $t7 $t7, 4 			   # March to next "box" in the current box row array
     			   addi $t8 $t8, 4 			   # March to next "box" in the current box row array
     			   addi $t9 $t9, 4 			   # March to next "box" in the current box row array
     			 
     			   addi $t5, $t5, 1
     			   j checkChunk
     		   exitCheckChunk:
   			 
   		   addi $t4, $t4, 1
   		   addi $a2, $a2, 1
   		   j checkAllBoxes
   		 
        exitCheckAllBoxes:
     	   # Logic for additional turn (player or computer)
     	   li $t4, 0 						   # Reset
     	   li $t5, 0 						   # Reset
     	   li $t7, 0
     	   li $t8, 1 						   # Load a constant
     	   lw $t9, isUserInput 				   # Load user state
     	   beq $a1, 1, giveAnotherTurn 		   # A box was filled, so need more turns

     		   beq $t9, 0, computerMove 	   # Box wasn't filled during user's turn, so go to computer move
     			   sw $t7, isUserInput 		   # Change user state to user
     			   j goToPrint 				   # Box wasn't filled during comp turn --> print and switch to user turn
     	 
     	   giveAnotherTurn:
     		   beq $t9, 1, computerMove 	   # Computer just filled up a box --> additional computer move
     			   j goToPrint 				   # Print without changing state (user gets to make another move!)
     		  # goToComputerMove:
     		  # 	sw $t8, isUserInput 			   # Change user state to computer
     		  # 	j computerMove
     	 
     			 
        goToPrint:
        # do some resetting and move on 			 
        li $v0 4
        la $a0 cols
        syscall    
        li $t0 0
     						 
        # PRINT BOARD ----------------------------------------------
        Loop1: bge $t0 6 exitLoop1 		   # Loop through each row
     	   add $t2 $t0 $t0
     	   la $a0 rows($t2) 			   # Print the beginning of each row (number followed by spaces)
     	   syscall
     	   la $a0 space
     	   syscall
     	   syscall
     	   syscall
     	 
     	   # ROWS
     	   li $t1 0
     	   Loop2:
     		   bge $t1 8 exitLoop2 	   # For current row, loop through column spaces
     		   la $a0 dot
     		   syscall
     		   la $a0 space
     		   syscall
     		 
     		   # switch-case to load proper ROW array address (based on outer loop)
     		   addi $sp, $sp, -4      # Decrement the stack pointer to allocate space for $ra
     		   sw $ra, 0($sp)   	  # Save the return address on the stack
     		   beq $t0, 0, rowcase1  
     		   rowswitch2:
     			   beq $t0, 1, rowcase2
     		   rowswitch3:
     			   beq $t0, 2, rowcase3
     		   rowswitch4:
     			   beq $t0, 3, rowcase4
     		   rowswitch5:
     			   beq $t0, 4, rowcase5
     		   rowswitch6:
     			   beq $t0, 5, rowcase6
     		 
     		   row_switch_exit:
     		   # $t7 now contains base address for current row array
     		 
     		   li $t6, 0 			   # Define index for array
     		   row_bool_loop:
     			   bge $t6, 7, exit_row_bool_loop

     			   add $t2, $t1, $t1 			   #t7 (array address) is incremented
     			   add $t2, $t2, $t2
     			   add $t7, $t7, $t2
					   lw $t8, ($t7) 			   # Load value of index into $t3
     	 
     			   beq $t8, 1, rowprintLine 	   # If t8 = 1, print a line instead
     				   la $a0, space 				   # Print a space
     				   syscall
     			   j exit_row_bool_loop
     		 
     			   rowprintLine:
     				   la $a0, rline  	  # Print a dash
     				   li $v0, 4
     				   syscall
     		 
     			   exit_row_bool_loop:
     				   # jal test_rline 			   # Start looping through bools ?
     				   # addi $s1, $s1, 1
     				   la $a0 space
     				   syscall
     				   add $t1 $t1 1
     				   j Loop2
     	   exitLoop2:
     		   la $a0 dot
     		   syscall
     		   la $a0 newline
     		   syscall
     		   la $a0 space
     		   syscall
     		   syscall
     		   syscall
     		   syscall
     		 
     	   # COLUMNS
     	   li $t1 0
     	   Loop3: bge $t1 9 exitLoop3 		   # Loop for printing column lines between
     		 
     		   # switch-case to load proper ROW array address (based on outer loop)
     		   addi $sp, $sp, -4   	   # Decrement the stack pointer to allocate space for $ra
     		   sw $ra, 0($sp)  		   # Save the return address on the stack
     		   beq $t0, 0, colcase1  
     		   colswitch2:
     			   beq $t0, 1, colcase2
     		   colswitch3:
     			   beq $t0, 2, colcase3
     		   colswitch4:
     			   beq $t0, 3, colcase4
     		   colswitch5:
     			   beq $t0, 4, colcase5
     		   colswitch6:
     			   beq $t0, 5, colcase6
     		 
     		   col_switch_exit:
     		   # $t7 now contains base address for row array
     		 
     		   li $t6, 0 			   # Define index for array
     		   col_bool_loop:
     			   bge $t6, 9, exit_col_bool_loop
     							 
     			   add $t2, $t1, $t1 			   #t7 (array address) is incremented
     			   add $t2, $t2, $t2
     			   add $t7, $t7, $t2
     			   lw $t8, ($t7) 			   # Load value of index into $t3 		 

     			   beq $t8, 1, colprintLine 	   # If t8 = 1, print a line instead
     			   la $a0, space 				   # Print a space
     			   syscall
     			   j exit_col_bool_loop
     		 
     			   colprintLine:
     				   la $a0 cline 		   # Print actual column
     				   syscall
     		 
     		   exit_col_bool_loop:
     			   add $t1 $t1 1
     			   #j Loop2    
     			   la $a0 space
     			   syscall
     			   syscall
     			   syscall    
     			   j Loop3

     	   exitLoop3:
     	   la $a0 newline
     	   syscall    
     	   add $t0 $t0 1
     	   j Loop1
      
        exitLoop1:
        add $t2 $t0 $t0
     	   la $a0 rows($t2)
     	   syscall
     	   la $a0 space
     	   syscall
     	   syscall
     	   syscall
     	   li $t1 0
     	   Loop4: bge $t1 8 exitLoop4
     		   la $a0 dot
     		   syscall
     		   la $a0 space
     		   syscall
     		   #-------------
     		   # $t7 now contains base address for row array
     		   la $t7, bool_rlline_7
     		   li $t6, 0 			   # Define index for array
     		   last_row_loop:
     			   bge $t6, 9, last_row_loop
     			   add $t2, $t1, $t1 			   #t7 (array address) is incremented
     			   add $t2, $t2, $t2
     			   add $t7, $t7, $t2
     			   lw $t8, ($t7) 			   # Load value of index into $t3    
					 
     			   # TODO: change value of array
     			   # (s0, s1, s2) = (row, col, vert or horiz)
     	 
     			   # Print according to array's curr value
     			   beq $t8, 1, lastPrintLine 	   # Jump to print a line instead
     			   la $a0, space 			   # Print a space
     			   syscall
     			   j exit_last_row_loop
     		 
     			   lastPrintLine:
     				   la $a0 rline 		   # Print actual column
     				   syscall
     		 
     		   exit_last_row_loop: 	 
     		   #------------
     		   la $a0 space
     		   syscall
     		   add $t1 $t1 1
     		   j Loop4
     	   exitLoop4:
     	   la $a0 dot
     	   syscall
     	   la $a0 newline
     	   syscall

        # SCORE DISPLAY------------------------------------------------------------------------
        # ($t1 = user score, $t2 = computer score, $t3 = # of unfilled boxes)
     				   # test print array
        li $t1, 0
        li $t2, 0
        li $t3, 0
        li $t9, 0
      
  	  score_loop:
     	   # FIRST ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r1
     	   _1array_inner_loop:
     		   bge $t6, 8, _1final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _1addToUser
				   beq $t9, 2, _1addToComp
				   addi $t3, $t3, 1
				   j _1finish_calcs
				   _1addToUser:
					   addi $t1, $t1, 1
					   j _1finish_calcs
				   _1addToComp:
					   addi $t2, $t2, 1
				   _1finish_calcs:
     			   addi $t6, $t6, 1
     			   j _1array_inner_loop
     	   _1final_exit:
     	 
     	   # SECOND ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r2
     	   _2array_inner_loop:
     		   bge $t6, 8, _2final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _2addToUser
				   beq $t9, 2, _2addToComp
				   addi $t3, $t3, 1
				   j _2finish_calcs
				   _2addToUser:
					   addi $t1, $t1, 1
					   j _2finish_calcs
				   _2addToComp:
					   addi $t2, $t2, 1
				   _2finish_calcs:
     			   addi $t6, $t6, 1
     			   j _2array_inner_loop
     	   _2final_exit:
     	 
     	   # THIRD ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r3
     	   _3array_inner_loop:
     		   bge $t6, 8, _3final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _3addToUser
				   beq $t9, 2, _3addToComp
				   addi $t3, $t3, 1
				   j _3finish_calcs
				   _3addToUser:
					   addi $t1, $t1, 1
					   j _3finish_calcs
				   _3addToComp:
					   addi $t2, $t2, 1
				   _3finish_calcs:
     			   addi $t6, $t6, 1
     			   j _3array_inner_loop
     	   _3final_exit:
     	 
     	   # FOURTH ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r4
     	   _4array_inner_loop:
     		   bge $t6, 8, _4final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _4addToUser
				   beq $t9, 2, _4addToComp
				   addi $t3, $t3, 1
				   j _4finish_calcs
				   _4addToUser:
					   addi $t1, $t1, 1
					   j _4finish_calcs
				   _4addToComp:
					   addi $t2, $t2, 1
				   _4finish_calcs:
     			   addi $t6, $t6, 1
     			   j _4array_inner_loop
     	   _4final_exit:
     	 
     	   # FIFTH ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r5
     	   _5array_inner_loop:
     		   bge $t6, 8, _5final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _5addToUser
				   beq $t9, 2, _5addToComp
				   addi $t3, $t3, 1
				   j _5finish_calcs
				   _5addToUser:
					   addi $t1, $t1, 1
					   j _5finish_calcs
				   _5addToComp:
					   addi $t2, $t2, 1
				   _5finish_calcs:
     			   addi $t6, $t6, 1
     			   j _5array_inner_loop
     	   _5final_exit:
     	 
     	   # SIXTH ROW---------------
     	   li $t6, 0
			   la $t7, bool_score_r6
     	   _6array_inner_loop:
     		   bge $t6, 8, _6final_exit
     		   lw $t9, 0($t7) 				   # Load current array value
     		   addi $t7, $t7, 4 			   # March array address to next value
				   beq $t9, 1, _6addToUser
				   beq $t9, 2, _6addToComp
				   addi $t3, $t3, 1 			   # If cell is 0, add to # of unfilled
				   j _6finish_calcs
				   _6addToUser:
					   addi $t1, $t1, 1
					   j _6finish_calcs
				   _6addToComp:
					   addi $t2, $t2, 1
				   _6finish_calcs:
     			   addi $t6, $t6, 1
     			   j _6array_inner_loop
     	   _6final_exit:
     	 
     	   # Check if someone won
     	   beq $t3, 0, endGame
     	 
     	   # PRINT SCORES
     	   la $a0 newline
     	   syscall
     	   li $v0, 4
     	   la $a0, user_score
     	   syscall
     	 
     	   li $v0, 1
     	   move $a0, $t1
     	   syscall
     	 
     	   li $v0 4
     	   la $a0 newline
     	   syscall
     	 
     	   li $v0, 4
     	   la $a0, comp_score
     	   syscall
     	 
     	   li $v0, 1
     	   move $a0, $t2
     	   syscall
     	 
     	   li $v0, 4
     	   la $a0 newline
     	   syscall
     	   syscall

     	   #add $t0 $t0 1
     	 
        # test print array
     	 
     		   li $v0, 4
    la $a0, newline
    syscall
    
     	   jr $ra
     	 
    endGame:
        blt $t2, $t1, userHasWon
        beq $t2, $t1, gameTied
      
        li $v0, 4
        la $a0, comp_won
        syscall
      
        j sayGoodbye
      
        userHasWon:
     	   li $v0, 4
     	   la $a0, player_won
     	   syscall
    
        gameTied:    
     	   li $v0, 4
     	   la $a0, no_winners
     	   syscall

        sayGoodbye:
        li $v0, 4
        la $a0, farewell
        syscall
      
        li $v0, 10
        syscall 		 
     	 
rowcase1:
    la $t7, bool_rlline_1
    j rowswitch2
rowcase2:
    la $t7, bool_rlline_2
    j rowswitch3
rowcase3:
    la $t7, bool_rlline_3
    j rowswitch4
rowcase4:
    la $t7, bool_rlline_4
    j rowswitch5
rowcase5:
    la $t7, bool_rlline_5
    j rowswitch6
rowcase6:
    la $t7, bool_rlline_6
    j row_switch_exit

# ALTERNATE CASES FOR USER MODDING------------------------------------------
horcase1:
    la $t7, bool_rlline_1
    j horswitch2
horcase2:
    la $t7, bool_rlline_2
    j horswitch3
horcase3:
    la $t7, bool_rlline_3
    j horswitch4
horcase4:
    la $t7, bool_rlline_4
    j horswitch5
horcase5:
    la $t7, bool_rlline_5
    j horswitch6
horcase6:
    la $t7, bool_rlline_6
    j horswitch7
horcase7:
    la $t7, bool_rlline_7
    j hor_switch_exit
    
# CASES FOR MAKING LEGAL MOVE------------------------------------------
legalhorcase1:
    la $t7, bool_rlline_1
    j legalhorswitch2
legalhorcase2:
    la $t7, bool_rlline_2
    j legalhorswitch3
legalhorcase3:
    la $t7, bool_rlline_3
    j legalhorswitch4
legalhorcase4:
    la $t7, bool_rlline_4
    j legalhorswitch5
legalhorcase5:
    la $t7, bool_rlline_5
    j legalhorswitch6
legalhorcase6:
    la $t7, bool_rlline_6
    j legalhor_switch_exit
      
# FOR GENERAL PRINTING
colcase1:
    la $t7, bool_clline_1
    j colswitch2
colcase2:
    la $t7, bool_clline_2
    j colswitch3
colcase3:
    la $t7, bool_clline_3
    j colswitch4
colcase4:
    la $t7, bool_clline_4
    j colswitch5
colcase5:
    la $t7, bool_clline_5
    j colswitch6
colcase6:
    la $t7, bool_clline_6
    j col_switch_exit
    
# ALTERNATE CASES FOR USER MODDING------------------------------------------
vertcase1:
    la $t7, bool_clline_1
    j vertswitch2
vertcase2:
    la $t7, bool_clline_2
    j vertswitch3
vertcase3:
    la $t7, bool_clline_3
    j vertswitch4
vertcase4:
    la $t7, bool_clline_4
    j vertswitch5
vertcase5:
    la $t7, bool_clline_5
    j vertswitch6
vertcase6:
    la $t7, bool_clline_6
    j vert_switch_exit
    
# CASES FOR MAKING LEGAL MOVE------------------------------------------
legalvertcase1:
    la $t7, bool_clline_1
    j legalvertswitch2
legalvertcase2:
    la $t7, bool_clline_2
    j legalvertswitch3
legalvertcase3:
    la $t7, bool_clline_3
    j legalvertswitch4
legalvertcase4:
    la $t7, bool_clline_4
    j legalvertswitch5
legalvertcase5:
    la $t7, bool_clline_5
    j legalvertswitch6
legalvertcase6:
    la $t7, bool_clline_6
    j legalvert_switch_exit

# BOX LOADING FOR CHECKING BOX STATES------------------------------------------
# t6 = box row array k, t7 = rline k, t8 = rline k+1, t9 = cline k
box1:
    la $t3, bool_score_r1
    la $t6, bool_box_r1
    la $t7, bool_rlline_1
    la $t8, bool_rlline_2
    la $t9, bool_clline_1
    j boxswitch2
    
box2:
    la $t3, bool_score_r2
    la $t6, bool_box_r2
    la $t7, bool_rlline_2
    la $t8, bool_rlline_3
    la $t9, bool_clline_2
    j boxswitch3
    
box3:
    la $t3, bool_score_r3
    la $t6, bool_box_r3
    la $t7, bool_rlline_3
    la $t8, bool_rlline_4
    la $t9, bool_clline_3
    j boxswitch4
    
box4:
    la $t3, bool_score_r4
    la $t6, bool_box_r4
    la $t7, bool_rlline_4
    la $t8, bool_rlline_5
    la $t9, bool_clline_4
    j boxswitch5

box5:
    la $t3, bool_score_r5
    la $t6, bool_box_r5
    la $t7, bool_rlline_5
    la $t8, bool_rlline_6
    la $t9, bool_clline_5
    j boxswitch6
    
box6:
    la $t3, bool_score_r6
    la $t6, bool_box_r6
    la $t7, bool_rlline_6
    la $t8, bool_rlline_7
    la $t9, bool_clline_6
    j box_switch_exit

# BOX LOADING FOR TAKE SAFE 3------------------------------------------
# t6 = box row array k, t7 = rline k, t8 = rline k+1, t9 = cline k
box1_comp:
	la $t3, bool_score_r1
	la $t6, bool_box_r1
	la $t7, bool_rlline_1
	la $t8, bool_rlline_2
	la $t9, bool_clline_1
	j boxswitch2_comp
    
box2_comp:
	la $t3, bool_score_r2
	la $t6, bool_box_r2
	la $t7, bool_rlline_2
	la $t8, bool_rlline_3
	la $t9, bool_clline_2
	j boxswitch3_comp
    
box3_comp:
	la $t3, bool_score_r3
	la $t6, bool_box_r3
	la $t7, bool_rlline_3
	la $t8, bool_rlline_4
	la $t9, bool_clline_3
	j boxswitch4_comp
    
box4_comp:
	la $t3, bool_score_r4
	la $t6, bool_box_r4
	la $t7, bool_rlline_4
	la $t8, bool_rlline_5
	la $t9, bool_clline_4
	j boxswitch5_comp

box5_comp:
	la $t3, bool_score_r5
	la $t6, bool_box_r5
	la $t7, bool_rlline_5
	la $t8, bool_rlline_6
	la $t9, bool_clline_5
	j boxswitch6_comp
    
box6_comp:
	la $t3, bool_score_r6
	la $t6, bool_box_r6
	la $t7, bool_rlline_6
	la $t8, bool_rlline_7
	la $t9, bool_clline_6
	j box_switch_comp_exit

# BOX INCREMENT CHECKS-----------------------------
increment_1:
    addi $a3, $a3, 1
    j incrSwitch2
increment_2:
    addi $a3, $a3, 1
    j incrSwitch3
increment_3:
    addi $a3, $a3, 1
    j incrSwitch4
increment_4:
    addi $a3, $a3, 1
    j incrSwitchExit
    
increment_1_safe:
    addi $a3, $a3, 1
    j incrSwitch2_safe
increment_2_safe:
    addi $a3, $a3, 1
    j incrSwitch3_safe
increment_3_safe:
    addi $a3, $a3, 1
    j incrSwitch4_safe
increment_4_safe:
    addi $a3, $a3, 1
    j incrSwitchSafeExit
    









