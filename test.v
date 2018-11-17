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

reg[4:0] rd,rs1,rs2;
wire[63:0] out1,out2;

register regor
(
	.rd(rd),
	.rs1(rs1),
	.rs2(rs2),
	.out1(out1),
	.out2(out2),
	.rd_in(1),
	.rd_we(1),
	.clk(clk)
);

initial
begin 
	$dumpfile("dump.vcd");
	$dumpvars();
	
	clk=0;
	reset=1;
	#10;
	reset=0;
	
	rd=1;
	rs1=0;
	rs2=0;
	#2
	
	
	#10000;
	$finish;
	
end 




endmodule
