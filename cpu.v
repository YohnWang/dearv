module cpu
(
	input wire[63:0] imem,
	input wire[63:0] dmem,
	output reg[63:0] iaddr,
	output reg[63:0] daddr,
	input wire clk,
	input wire rst
	
	
	
);

wire[63:0] wpc;
//wire[63:0] alusel;
wire wpcsel=1;

pc pc_inst
(
	.x(wpcsel?0:wpc+4),
	.y(wpc),
	.clk(clk),
	.reset(rst)
);



endmodule
