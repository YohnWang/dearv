module bus
(
	//instruction bus
	input wire[63:0] iaddr,
	output reg[63:0] idata,
	
	//data and device bus
	input wire[63:0] daddr,
	input wire[63:0] wdata,
	input wire rw,
	input wire[1:0] word,
	output reg[63:0] ddata
	
	//control bus
	
);




endmodule
