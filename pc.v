module pc
#(
	parameter XLEN=64
)
(
	input wire[XLEN-1:0] x,
	output reg[XLEN-1:0] y,
	input wire clk
);

always@(posedge clk) y=x;

endmodule
