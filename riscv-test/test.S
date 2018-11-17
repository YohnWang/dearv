.option norvc
.section .text
.equ TIME,100000
//.align 4
_start:
	lui t0,%hi(TIME)
	addi t0,t0,%lo(TIME)
	addi t2,x0,10
	
	mv a1,x0
	li s0,1
	li s1,3
	li s2,5
	li s3,7
1:	
	sw a1,0(x0)
	mv a0,t0
	jal delay
	mv a0,s0
	jal update
	
	beq x0,x0,1b
	

delay:
	addi a0,a0,-1
	bne a0,x0,delay
	ret

update:
	addi s0,s0,1
	blt s0,t2,END
	
	mv s0,x0
	addi s1,s1,1
	blt s1,t2,END
	
	mv s1,x0
	addi s2,s2,1
	blt s2,t2,END
	
	mv s2,x0
	addi s3,s3,1
	blt s3,t2,END
	
	mv s3,x0
	addi s4,s4,1
	blt s4,t2,END
	
	mv s4,x0
	
END:
	mv a1,x0
	slli s1,s1,4
	slli s2,s2,8
	slli s3,s3,12
	or a1,a1,s0
	or a1,a1,s1
	or a1,a1,s2
	or a1,a1,s3
	srli s1,s1,4
	srli s2,s2,8
	srli s3,s3,12
	ret
