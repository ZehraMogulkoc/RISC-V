.eqv read_int 5
.eqv print_int 1
.eqv print_str 4  # some declarations for convenience in using 
.eqv action a7

.data
message: .string "Enter a number: \n"
result: .string "The result is: "
.text
	la a0,message # prepare to print string  
	li action,print_str   # print string  
	ecall
	
	li action,read_int #read int from user
	ecall

jal func #go function with a0 

	li action, print_int
	ecall
	li action, 10
	ecall
	
func:	bne a0, x0, rec #if(n!=0){rec}
	li a0, 5	# base case x=0,f(x)=5
	jalr x0, x1, 0 #return
	
rec:	addi sp, sp, -8 #adjust the stack
	sw x1, 0(sp) 
	sw a0, 4(sp)	
	addi a0, a0, -1	 # n=n-1
	jal func # f(n-1)
	addi a2,zero,2 # set 2 
	mul a0, a0, a2 # 2*f(n-1)
	lw t0, 4(sp) #take n value from top of stack
	add a0,a0,t0 # add n to result
	lw x1, 0(sp)
	addi sp, sp, 8
	jalr zero, x1, 0 #return 