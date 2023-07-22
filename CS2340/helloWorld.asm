.data
myMessage .asciiz "Hello MAtt \n"
.text
li $v0, 4 # 4 for printing
li $a0, myMessage # pass in location of string
syscall