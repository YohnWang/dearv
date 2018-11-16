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
	output reg memsign,
	output reg[1:0] wbsel
);


reg[3:0] alusel_gen;
always@(*)
begin 
	case(inst[14:12])
		`ARI_AS     : alusel_gen=inst[30]?`SEL_SUB:`SEL_ADD; 
		`ARI_SLL    : alusel_gen=`SEL_SLL;
		`ARI_SLT    : alusel_gen=`SEL_SLT;
		`ARI_SLTU   : alusel_gen=`SEL_SLTU;
		`ARI_XOR    : alusel_gen=`SEL_XOR;
		`ARI_SR     : alusel_gen=inst[30]?`SEL_SRA:`SEL_SRL;
		`ARI_OR     : alusel_gen=`SEL_OR;
		`ARI_AND    : alusel_gen=`SEL_AND;
		default:;
	endcase
end 

reg pcsel_gen;
always@(*)
begin 
	case(inst[14:12])
		`BRAN_BEQ : pcsel_gen=breq?`PC_JUMP:`PC_PLUS4;
		`BRAN_BNE : pcsel_gen=breq?`PC_PLUS4:`PC_JUMP;
		`BRAN_BLT : begin brun=0;pcsel_gen=brlt?`PC_JUMP:`PC_PLUS4; end 
		`BRAN_BGE : begin brun=0;pcsel_gen=brlt?`PC_PLUS4:`PC_JUMP; end
		`BRAN_BLTU: begin brun=1;pcsel_gen=brlt?`PC_JUMP:`PC_PLUS4; end 
		`BRAN_BGEU: begin brun=1;pcsel_gen=brlt?`PC_PLUS4:`PC_JUMP; end
		default:;
	endcase
end


always@(*)
begin 
	memword=inst[13:12];
	memsign=inst[14];
end


always@(*)
begin 
	case(inst[6:2])
		`OP_LUI   :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_U;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `SEL_Y;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end 
		`OP_AUIPC :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_U;
				regwen= `REGW_EN;
				//brun=    0;
				asel=    0;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end
		`OP_JAL   :
			begin 
				pcsel=  `PC_JUMP;
				immsel= `IMM_J;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_PCPLUS4;
			end 
		`OP_JALR  :
			begin 
				pcsel=  `PC_JUMP;
				immsel= `IMM_I;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_PCPLUS4;
			end 
		`OP_BRAN  :
			begin 
				pcsel=  breq?`PC_JUMP:`PC_PLUS4;
				immsel= `IMM_B;
				regwen= `REGW_UN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=   0;
			end 
		`OP_LOAD  :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_I;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_MEM;
			end 
		`OP_STORE :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_S;
				regwen= `REGW_UN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `SEL_ADD;
				memrw=  `MEM_WRITE;
				//memword= 0;
				wbsel=   0;
			end 
		`OP_ARII  :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_I;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel=  inst[14:12]?alusel_gen:`SEL_ADD;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end 
		`OP_ARIR  :
			begin 
				pcsel=  `PC_PLUS4;
				immsel=  0;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_REG;
				alusel= alusel_gen;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end
		`OP_FENCE :;
		`OP_PRIV  :;
		default  :/*trap*/;
	endcase
end


endmodule



