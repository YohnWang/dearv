.option norvc
.section .text
//.align 4
_start:
	addi x1,x0,-10
	beq x0,x0,1f
	add x1,x0,x0
	sub x1,x0,x0
	and x1,x0,x0
	
1:
	sw x1,0(x0)
	lb x2,0(x0)
	li x1,0x1234
	
1:
	beq x0,x0,1b
