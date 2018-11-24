module disp
(
	input wire cs,
	input wire[7:0] c,
	input wire clk
);

reg[7:0] r;

always@(posedge clk) if(cs) r<=c; else ;
always@(*) $write("%c",r);

endmodule
