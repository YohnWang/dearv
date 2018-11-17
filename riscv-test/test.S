.option norvc
.section .text
//.align 4
_start:
	lui x1,%hi(0x1234)
	addi x1,x1,%lo(0x1234)
	sw x1,0(x0)
1:
	beq x0,x0,1b
