module bus
(
	//instruction bus
	input wire[63:0] iaddr,
	output wire[63:0] idata,
	
	//data and device bus
	input wire[63:0] daddr,
	input wire[63:0] wdata,
	input wire rw,
	input wire[1:0] word,
	output wire[63:0] ddata,
	
	//control bus
	
	
	//basic signal
	input clk,
	input rst
);

wire cs_dmem = (daddr>=64'h80000000 && daddr<=64'h80000fff)?1:0;

dmem dmem_instx
(
	.addr(daddr[11:0]),
	.dataw(wdata),
	.word(word),
	.rw(rw),
	.clk(clk),
	.datar(ddata),
	.cs(cs_dmem)
);

wire cs_imem = (iaddr>=64'h80000000 && iaddr<=64'h80000fff)?1:0;

imem imem_instx
(
	.addr(iaddr[9:0]),
	.word(2'b10),
	.data(idata),
	.cs(cs_imem)
);

disp disp_inst
(
	.cs(daddr==64'h02001000),
	.c(wdata[7:0]),
	.clk(clk)
);

endmodule
