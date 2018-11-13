`include "const.h"
module immgen
#(
	parameter XLEN=64
)
(
	input wire[31:0] inst,
	input wire[2:0]  immsel,
	output reg signed [XLEN-1:0] imm  
);

always@(*)
begin 
	case(immsel)
		`IMM_I : imm=inst[31:20];
		`IMM_S : imm={inst[31:25],inst[11:7]};
		`IMM_B : imm={inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
		`IMM_U : imm={inst[31:12],12'b0};
		`IMM_J : imm={inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
		default:;
	endcase
end

endmodule
