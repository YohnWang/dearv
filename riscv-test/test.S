.option norvc
.section .text
//.align 4
_start:
	addi x1,x1,10
	
	add x1,x0,x0
	sub x1,x0,x0
	and x1,x0,x0
	
1:
	beq x0,x0,1b
