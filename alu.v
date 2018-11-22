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
`define NEW_ALU
`ifndef NEW_ALU
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
`else
always@(*)
begin 
	case(alusel)
		`ALU_ADD  : z=x+y;
		`ALU_SUB  : z=x-y;
		`ALU_SLL  : z=x<<y[5:0];
		`ALU_SLT  : z=x<y?1:0;
		`ALU_SLTU : z=$unsigned(x)<$unsigned(y)?1:0;
		`ALU_XOR  : z=x^y;
		`ALU_SRL  : z=x>>y[5:0];
		`ALU_SRA  : z=x>>>y[5:0];
		`ALU_OR   : z=x|y;
		`ALU_AND  : z=x&y;
		`ALU_X    : z=x;
        `ALU_Y    : z=y;
		default: ;
	endcase
end
`endif





endmodule

