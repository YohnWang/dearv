`include "const.h"

module alu
#(
	parameter XLEN=64
)
(
	input wire signed [XLEN-1:0] x,
	input wire signed [XLEN-1:0] y,
	input wire[3:0] alusel, //ALU selecting
	output reg signed [XLEN-1:0] z
);

always@(*)
begin 
	case(alusel)
		`SEL_ADD  : z=x+y;
		`SEL_SUB  : z=x-y;
		`SEL_SLL  : z=x<<y[5:0];
		`SEL_SLT  : z=x<y?1:0;
		`SEL_SLTU : z=$unsigned(x)<$unsigned(y)?1:0;
		`SEL_XOR  : z=x^y;
		`SEL_SRL  : z=x>>y[5:0];
		`SEL_SRA  : z=x>>>y[5:0];
		`SEL_OR   : z=x|y;
		`SEL_AND  : z=x&y;
		`SEL_X    : z=x;
		`SEL_Y    : z=y;
		default: ;
	endcase
end


endmodule

