.option norvc
.section .text
//.align 4
_start:
	addi x1,x0,-10
	//beq x0,x0,1f
	add x1,x0,x0
	sub x1,x0,x0
	and x1,x0,x0
	li x1,'a'
1:
	
	sb x1,0(x0)
	addi x1,x1,1
	li x2,'z'+1
	bne x2,x1,1b
	li x1,'\n'
	sb x1,0(x0)
1:
	beq x0,x0,1b
	
	.section .rodata
str:
	.string "fuck you\n"
