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
	output reg[63:0] ddata,
	
	//control bus
	
	
	//basic signal
	input clk,
	input rst
);

wire[63:0] cs_dmem;

always@(*) ddata=daddr[31]?cs_dmem:64'bz;

dmem dmem_instx
(
	.addr(daddr[11:0]),
	.dataw(wdata),
	.word(word),
	.rw(rw),
	.clk(clk),
	.datar(cs_dmem)
);

wire[63:0] cs_imem;

always@(*) idata=iaddr[31]?cs_imem:64'bz;

imem imem_instx
(
	.addr(iaddr[9:0]),
	.word(2'b10),
	.data(cs_imem)
);


endmodule
