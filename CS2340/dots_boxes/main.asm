.data

	
.text
.globl main
	main:
		jal welcome
		
		gameloop:					# Endless loop (program will end in userInput)
			jal user_input
			jal printBoard
			j gameloop
			
		exit_game:
			
			li $v0, 10
			syscall
	
