`ifndef D_CONST
`define D_CONST


`define XLEN (64)

//alusel
`define SEL_ADD  4'd0
`define SEL_SUB  4'd1
`define SEL_SLL  4'd2
`define SEL_SLT  4'd3
`define SEL_SLTU 4'd4
`define SEL_XOR  4'd5
`define SEL_SRL  4'd6
`define SEL_SRA  4'd7
`define SEL_OR   4'd8
`define SEL_AND  4'd9
`define SEL_X   4'd10
`define SEL_Y   4'd11

//new alusel 
`define ALU_ADD  4'b0000
`define ALU_SUB  4'b1000
`define ALU_SLL  4'b0001
`define ALU_SLT  4'b0010
`define ALU_SLTU 4'b0011
`define ALU_XOR  4'b0100
`define ALU_SRL  4'b0101
`define ALU_SRA  4'b1101
`define ALU_OR   4'b0110
`define ALU_AND  4'b0111
`define ALU_X    4'b1110
`define ALU_Y    4'b1111


//immsel
`define IMM_I 3'd0
`define IMM_S 3'd1
`define IMM_B 3'd2
`define IMM_U 3'd3
`define IMM_J 3'd4

//pcsel
`define PC_PLUS4 1'd0
`define PC_JUMP  1'd1

`define REGW_EN 1'd1
`define REGW_UN 1'd0

`define BR_UN 1'd1
`define BR_SI 1'd0

`define ASEL_PC  1'd1 
`define ASEL_REG 1'd0

`define BSEL_REG 1'd0 
`define BSEL_IMM 1'd1 

`define MEM_READ  1'd0
`define MEM_WRITE 1'd1

`define MEM_BYTE  2'00 
`define MEM_HALF  2'01
`define MEM_WORD  2'10
`define MEM_DOUBLE 2'11

//write back sel 
`define WB_PCPLUS4 2'd2
`define WB_ALU     2'd1
`define WB_MEM     2'd0

//inst opcode
`define OP_LUI      5'b01101
`define OP_AUIPC    5'b00101
`define OP_JAL      5'b11011
`define OP_JALR     5'b11001
`define OP_BRAN     5'b11000
`define OP_LOAD     5'b00000
`define OP_STORE    5'b01000
`define OP_ARII     5'b00100
`define OP_ARIR     5'b01100
`define OP_FENCE    5'b00011
`define OP_PRIV     5'b11100

`define OP_ARII32   5'b00110
`define OP_ARIR32   5'b01110


//branch funct3
`define BRAN_BEQ  3'b000 
`define BRAN_BNE  3'b001 
`define BRAN_BLT  3'b100
`define BRAN_BGE  3'b101
`define BRAN_BLTU 3'b110
`define BRAN_BGEU 3'b111 

`define BRAN_EQ 2'b00 
`define BRAN_NE 2'b01 
`define BRAN_LT 2'b10 
`define BRAN_GE 2'b11


//load funct3
`define LOAD_LB   3'b000 
`define LOAD_LH   3'b001 
`define LOAD_LW   3'b010 
`define LOAD_LD   3'b011 
`define LOAD_LBU  3'b100
`define LOAD_LHU  3'b101
`define LOAD_LWU  3'b110 

//store funct3
`define STORE_SB  3'b000 
`define STORE_SH  3'b001 
`define STORE_SW  3'b010 
`define STORE_SD  3'b011 

//word size
`define WORD_BYTE 3'b000 
`define WORD_HALF 3'b001 
`define WORD_WORD 3'b010 
`define WORD_DOUB 3'b011


//arithmetic funct 
`define ARI_AS     3'b000 
`define ARI_AS_ADD 7'b0000000 
`define ARI_AS_SUB 7'b0100000
`define ARI_SLL    3'b001 
`define ARI_SLT    3'b010 
`define ARI_SLTU   3'b011 
`define ARI_XOR    3'b100 
`define ARI_SR     3'b101
`define ARI_SR_SRL 7'b0000000 
`define ARI_SR_SRA 7'b0100000
`define ARI_OR     3'b110 
`define ARI_AND    3'b111



//arithmetic imm funct
`define ARII_ADDI   3'b000 
`define ARII_SLTI   3'b010 
`define ARII_SLTIU  3'b011 
`define ARII_XORI   3'b110 
`define ARII_ANDI   3'b111 
`define ARII_SLLI   3'b001 
`define ARII_SRI    3'b101
`define ARII_SRI_L  7'b0000000
`define ARII_SRI_A  7'b0100000


//arithmetic reg funct 
`define ARIR_AS     3'b000 
`define ARIR_AS_ADD 7'b0000000 
`define ARIR_SLL    3'b001 
`define ARIR_SLT    3'b010 
`define ARIR_SLTU   3'b011 
`define ARIR_XOR    3'b100 
`define ARIR_SR     3'b101
`define ARIR_SR_SRL 7'b0000000 
`define ARIR_SR_SRA 7'b0100000
`define ARIR_OR     3'b110 
`define ARIR_AND    3'b111

//arithmetic imm 32 funct 
`define ARII32_SLLI 3'b001 
`define ARII32_SRI 3'b101 
`define ARII32_SRI_SRAI 7'b010000 
`define ARII32_SRI_SRLI 7'b000000 


`define ARII32_ADDIW 3'b000 
`define ARII32_SLLIW 3'b001 
`define ARII32_SRIW  3'b101

`endif

