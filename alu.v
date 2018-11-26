`include "const.h"

module alu
#(
	parameter XLEN=64
)
(
	input wire signed [XLEN-1:0] x,
	input wire signed [XLEN-1:0] y,
	input wire[3:0] alusel, //ALU selecting
	input wire upper,
	output reg signed [XLEN-1:0] z
);

reg[XLEN-1:0] zx;

always@(*) z=upper?zx:{{32{zx[31]}},zx[31:0]};


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
		`ALU_ADD  : zx=x+y;
		`ALU_SUB  : zx=x-y;
		`ALU_SLL  : zx=x<<y[5:0];
		`ALU_SLT  : zx=x<y?1:0;
		`ALU_SLTU : zx=$unsigned(x)<$unsigned(y)?1:0;
		`ALU_XOR  : zx=x^y;
		`ALU_SRL  : zx=x>>y[5:0];
		`ALU_SRA  : zx=x>>>y[5:0];
		`ALU_OR   : zx=x|y;
		`ALU_AND  : zx=x&y;
		`ALU_X    : zx=x;
        `ALU_Y    : zx=y;
		default: ;
	endcase
end
`endif





endmodule

