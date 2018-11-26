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
	output reg aluupper,
	output reg memrw,
	output reg[1:0] memword,
	output reg memsign,
	output reg[1:0] wbsel
);

reg pcsel_gen;

always@(*) brun=inst[13];

always@(*)
begin 
	case({inst[14],inst[12]})
		`BRAN_EQ : pcsel_gen=breq?`PC_JUMP:`PC_PLUS4;
		`BRAN_NE : pcsel_gen=breq?`PC_PLUS4:`PC_JUMP;
		`BRAN_LT : pcsel_gen=brlt?`PC_JUMP:`PC_PLUS4;
		`BRAN_GE : pcsel_gen=brlt?`PC_PLUS4:`PC_JUMP;
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
				aluupper = 1;
				bsel=   `BSEL_IMM;
				alusel= `ALU_Y;
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
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
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
				alusel= `ALU_ADD;
				aluupper = 1;
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
				alusel= `ALU_ADD;
				aluupper = 1;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_PCPLUS4;
			end 
		`OP_BRAN  :
			begin 
				pcsel=  pcsel_gen;
				immsel= `IMM_B;
				regwen= `REGW_UN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
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
				alusel= `ALU_ADD;
				aluupper = 1;
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
				alusel= `ALU_ADD;
				aluupper = 1;
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
				alusel=  (inst[14:12]==3'b101)?({inst[30],inst[14:12]}):({1'b0,inst[14:12]});
				aluupper = 1;
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
				alusel= {inst[30],inst[14:12]};
				aluupper = 1;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end
		`OP_ARIR32  :
			begin 
				pcsel=  `PC_PLUS4;
				immsel=  0;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_REG;
				alusel= {inst[30],inst[14:12]};
				aluupper = 0;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end
		`OP_ARII32  :
			begin 
				pcsel=  `PC_PLUS4;
				immsel= `IMM_I;
				regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel=  (inst[14:12]==3'b101)?({inst[30],inst[14:12]}):({1'b0,inst[14:12]});
				aluupper = 0;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end 
		`OP_FENCE :
			begin 
				/*just do nothing*/
				regwen = `REGW_UN;
				memrw = `MEM_READ;
			end
		`OP_PRIV  :;
		default  :/*trap*/;
	endcase
end


endmodule



