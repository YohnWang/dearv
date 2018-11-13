`include "const.h"
module cu
(
	input wire[31:0] inst,
	input wire breq,
	input wire brlt,
	output reg pcsel,
	output reg[2:0] immsel,
	output reg regwen,
	output reg brun,
	output reg asel,
	output reg bsel,
	output reg[3:0] alusel,
	output reg memrw,
	output reg[1:0] memword,
	output reg[1:0] wbsel
	
);

always@(*)
begin 
	case(inst[6:2])
		`OP_LUI   : {pcsel,immsel,regwen,brun,asel,bsel,alusel,memrw,memword,wbsel}={`PC_PLUS4,`IMM_U,1'b1,1'bx,1'bx,1'b1,`SEL_Y,1'b0,2'b00,`WB_ALU};
		`OP_AUIPC :;
		`OP_JAL   :;
		`OP_JALR  :;
		`OP_BRAN  :;
		`OP_LOAD  :;
		`OP_STORE :;
		`OP_ARII  :;
		`OP_ARIR  :;
		`OP_FENCE :;
		`OP_PRIV  :;
		default  :/*trap*/;
	endcase
	

end



endmodule



