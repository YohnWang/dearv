.option norvc
.section .text
//.align 4
_start:
	li x1,0xa
	sw x1,0(x0)
1:
	beq x0,x0,1b
