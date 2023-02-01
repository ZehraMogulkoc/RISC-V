.global _start
_start:    
        la a0, input         # prepare to print string  
        li a7, 4             # print string  
        ecall  #system call

	li a7,5       #take integer value from user     
        ecall

	addi t1 , a0,0  #save given input in t1
	li t0 , 0  # set t0 to 0 i=0


firstLoop: 
	beq t0,t1, firstExit #for(i<input t1
	addi t0, t0, 1 	 # i++
	li t2 , 0       #set t2 temprory data for int a =0

secondLoop: 
	beq t2 , t0 , secondExit  #for(a<i 
	addi t2,t2, 1        #a++
        la a0, star  #set a0 for star 
        li a7, 4  # print the star i times
        ecall 
	jal secondLoop #go back to looð

secondExit: 
        la a0, newLine #go to new line of triangle
        li a7, 4   #print line
        ecall 
	jal firstLoop

firstExit:
	li a7, 10     #exit from first loop
        ecall

.data #all necessary data declarations
input:
	.ascii"Enter a number: "
	.byte 0
newLine: 
	.ascii "\n"
	.byte 0
star:
	.ascii "*"
	.byte 0
