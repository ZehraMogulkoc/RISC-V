.data
prompt1: .string "Enter the size of the array: "
prompt2: .string "Enter the values for the array:\n"
array: 	.word	0 : 100  # allocate space for 100 ints
space: .string "  "
.text
.globl main
main:
	la a0, prompt1
	li a7, 4
	ecall

    # Read the size of the array
	li a7, 5
	ecall
	add t1 ,t1, a0  
	
	la t0, array     # Load address of array into t0
	li t2, 0   
	li t3,0 
	li t5,0
	li t6,0
	     # Initialize loop variables to 0
	la a0, prompt2
	li a7, 4
	addi x22,zero,0 #counter of outer loop =i
	addi x23,zero,0#counter of inner loop =k
	addi x4,zero,4
	ecall
create: #creating array from user input
	beq t2,t1,out
	li a7, 5
	ecall
	sw	a0, 0(t0)	
	addi	t2, t2, 1	
	addi	t0, t0, 4 #nexrt item of array
	addi t5,t5,4		#calculating for size*4
	jal	create
	
	out: #set the beginning of array and start sorting
	sub t0, t0, t5  
	jal	outer_loop
	out_2: #after sorting done, print the array
	jal	print_array
	
outer_loop: 	# I used bubble sort algorithm, 
		#this is first loop from o to array size
beq x22,t1,out_2
inner_loop: 
sub x24,t1,x22
addi x24,x24,-1
beq x23,x24,end_2 #second loop is from 0 to arraySize-x22-1

lw x9,0(t0)#arr[n]
lw x12,4(t0)#arr[n+1]

bge x12,x9,no_if #if arr[n]>arr[n+1] is not true, dont swap
sw x12,0(t0) # if this is the case make swaping
sw x9,4(t0)
no_if:
addi x23,x23,1 #increase k++
addi t0,t0,4 #go next item in array
addi t6,t6,4 #count how many times switching made 
j inner_loop 
end_2: 
sub t0, t0, t6 #go back to start index of array
addi t6,zero,0 #set t6 to zero again to use it 
addi,x22,x22,1 #increase i++
addi x23,zero,0 #set counter of inner loop to zero again. k=0 
j outer_loop #last element is largest, continue until first element
 

print_array:
	beq t1, t3, done # Stop loop if all array elements have been printed
	li a7, 1         # Load system call number for print_int 
	lw a0, 0(t0)     # Load array[i] 
	ecall            # Print array[i]
	la a0,space # prepare to print string  
	li a7,4   # print string  
	ecall
 	addi t3, t3, 1   # Increment loop counter by 1
	addi t0, t0, 4   # Increment array pointer by 4
	j print_array  
done:
