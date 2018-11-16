`include "const.h"

module test;


reg clk;
always #1 clk=~clk;
reg reset;

soc soc_inst
(
	.clk(clk),
	.rst(reset)
);

initial
begin 
	$dumpfile("dump.vcd");
	$dumpvars();
	
	clk=0;
	reset=1;
	#10;
	reset=0;
	
	#1000;
	$finish;
	
end 




endmodule
