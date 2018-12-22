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
	output reg[1:0] wbsel,
	output reg csrsel,
	output reg csr_wen,
	output reg[1:0] csr_funct
);


//branch 
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

//memory 
always@(*)
begin 
	memword=inst[13:12];
	memsign=inst[14];
	memrw= (inst[6:2]==`OP_STORE)?`MEM_WRITE:`MEM_READ;
end


//regwen
always@(*) 
begin 
	case(inst[6:2])
		`OP_LUI,
		`OP_AUIPC,
		`OP_JAL,
		`OP_JALR,
		`OP_LOAD,
		`OP_ARII,
		`OP_ARIR,
		`OP_ARIR32,
		`OP_ARII32:regwen=`REGW_EN;
		
		`OP_PRIV:regwen=inst[14:12]?`REGW_EN:`REGW_UN;
		
		default:regwen=`REGW_UN;
	endcase
end

//immgen
always@(*) 
begin 
	case(inst[6:2])
		`OP_LUI,
		`OP_AUIPC: immsel=`IMM_U;
		
		`OP_JAL:   immsel=`IMM_J;
		
		`OP_JALR,
		`OP_LOAD,
		`OP_ARII,
		`OP_ARII32:immsel=`IMM_I;
		
		`OP_BRAN:  immsel=`IMM_B;
		`OP_STORE: immsel=`IMM_S;
		default:;
	endcase
end

//pc
always@(*)
begin 
	case(inst[6:2])
		`OP_JAL,   
		`OP_JALR: pcsel=`PC_JUMP;
		
		`OP_BRAN: pcsel=pcsel_gen;
		
		default:  pcsel=`PC_PLUS4;
	endcase
end

always@(*)
begin 
	case(inst[6:2])
		`OP_LUI   :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_U;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_PC;
				aluupper = 1;
				bsel=   `BSEL_IMM;
				alusel= `ALU_Y;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
				csr_wen=0;
			end 
		`OP_AUIPC :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_U;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
				csr_wen=0;
			end
		`OP_JAL   :
			begin 
				//pcsel=  `PC_JUMP;
				//immsel= `IMM_J;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_PCPLUS4;
				csr_wen=0;
			end 
		`OP_JALR  :
			begin 
				//pcsel=  `PC_JUMP;
				//immsel= `IMM_I;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_PCPLUS4;
				csr_wen=0;
			end 
		`OP_BRAN  :
			begin 
				//pcsel=  pcsel_gen;
				//immsel= `IMM_B;
				//regwen= `REGW_UN;
				//brun=    0;
				asel=   `ASEL_PC;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=   0;
				csr_wen=0;
			end 
		`OP_LOAD  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_I;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_MEM;
			end 
		`OP_STORE :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_S;
				//regwen= `REGW_UN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel= `ALU_ADD;
				aluupper = 1;
				//memrw=  `MEM_WRITE;
				//memword= 0;
				wbsel=   0;
				csr_wen=0;
			end 
		`OP_ARII  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_I;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel=  (inst[14:12]==3'b101)?({inst[30],inst[14:12]}):({1'b0,inst[14:12]});
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
				csr_wen=0;
			end 
		`OP_ARIR  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel=  0;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_REG;
				alusel= {inst[30],inst[14:12]};
				aluupper = 1;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
				csr_wen=0;
			end
		`OP_ARIR32  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel=  0;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_REG;
				alusel= {inst[30],inst[14:12]};
				aluupper = 0;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
			end
		`OP_ARII32  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= `IMM_I;
				//regwen= `REGW_EN;
				//brun=    0;
				asel=   `ASEL_REG;
				bsel=   `BSEL_IMM;
				alusel=  (inst[14:12]==3'b101)?({inst[30],inst[14:12]}):({1'b0,inst[14:12]});
				aluupper = 0;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_ALU;
				csr_wen=0;
			end 
		`OP_FENCE :
			begin 
				/*just do nothing*/
				//regwen = `REGW_UN;
				//memrw = `MEM_READ;
				csr_wen=0;
			end
		`OP_PRIV  :
			begin 
				//pcsel=  `PC_PLUS4;
				//immsel= 0;
				//regwen= `REGW_UN;
				//asel=   `ASEL_REG;
				//bsel=   `BSEL_IMM;
				//alusel=  (inst[14:12]==3'b101)?({inst[30],inst[14:12]}):({1'b0,inst[14:12]});
				//aluupper = 0;
				//memrw=  `MEM_READ;
				//memword= 0;
				wbsel=  `WB_CSR;
				csr_funct=inst[13:12];
				csrsel=inst[14];
				csr_wen=inst[13:12]?1:0;
			end
		default  :/*trap*/;
	endcase
end


endmodule



