

all:
	find *.v > vlist.txt
	iverilog -c vlist.txt -o a.out 
	
sim:
	make all
	vvp a.out -lxt2

clean :
	rm vlist.txt
	rm a.out 
	rm *.vcd
