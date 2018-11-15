
all: test.o a.out
	riscv64-unknown-elf-objdump -d test.o | ./a.out 
	riscv64-unknown-elf-objdump -d test.o | ./a.out > imem.txt
	echo 'instruction data generate complete'
	
test.o: test.S 
	riscv64-unknown-elf-gcc -c test.S
	
a.out: transfrom.c
	gcc transfrom.c -o a.out
	

clean:
	rm test.o
