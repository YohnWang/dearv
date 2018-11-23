module pc
#(
	parameter XLEN=64
)
(
	input wire[XLEN-1:0] x,
	output reg[XLEN-1:0] y,
	input wire clk,
	input wire reset
);

always@(posedge clk) y=reset?32'h80000000:x;

endmodule
