`include "const.h"

module test;

reg[63:0] x,y;
wire[63:0] z;
reg[3:0] F;

alu aluor
(
	.x(x),
	.y(y),
	.z(z),
	.alusel(F)
);


integer i;

initial 
begin
	#10;
	x=-64'b1111_0000;
	y=64'b0000_1111;
	for(i=0;i<10;i=i+1)
	begin
		F=i;
		#1;
		$display("z=%b",z);
	end
	#100
	$finish;

end

reg[9:0] iaddr;
wire[63:0] data;

imem imemor
(
	.addr(iaddr),
	.word(3),
	.data(data)
);

initial
begin 

	#1 iaddr=0;
	#1;
	$display("%h",data);

end


reg clk;
always #1 clk=~clk;

reg[63:0] pcx;
wire[63:0] pcy;
reg reset;

pc pcor
(
	.x(pcx),
	.y(pcy),
	.clk(clk),
	.reset(reset)
);

initial
begin 
	$dumpfile("dump.vcd");
	$dumpvars();
	clk=0;
	reset=1;
	#2;
	reset=0;
	pcx=1;
	forever #2 pcx=!pcx;
	
end 

endmodule
