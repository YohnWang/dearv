module imem
(
	input wire[9:0] addr,
	input wire[1:0]  word,
	output reg[63:0] data
);

wire[31:0] mem[63:0];

//initial $readmemh("./riscv-test/imem.txt",mem);

always@(*)
begin 
	data=mem[addr[7:2]];
end


assign mem[0] = 32'h000002b7; // lui	t0,0x0
assign mem[1] = 32'h00a28293; // addi	t0,t0,10 # a <_start+0xa>
assign mem[2] = 32'h00a00393; // li	t2,10
assign mem[3] = 32'h00000593; // li	a1,0
assign mem[4] = 32'h00000413; // li	s0,0
assign mem[5] = 32'h00000493; // li	s1,0
assign mem[6] = 32'h00000913; // li	s2,0
assign mem[7] = 32'h00000993; // li	s3,0
assign mem[8] = 32'h00b02023; // sw	a1,0(zero) # 0 <_start>
assign mem[9] = 32'h00028513; // mv	a0,t0
assign mem[10] = 32'h010000ef; // jal	ra,38 <delay>
assign mem[11] = 32'h00040513; // mv	a0,s0
assign mem[12] = 32'h014000ef; // jal	ra,44 <update>
assign mem[13] = 32'hfe0006e3; // beqz	zero,20 <.L11>
assign mem[14] = 32'hfff50513; // addi	a0,a0,-1
assign mem[15] = 32'hfe051ee3; // bnez	a0,38 <delay>
assign mem[16] = 32'h00008067; // ret
assign mem[17] = 32'h00140413; // addi	s0,s0,1
assign mem[18] = 32'h02744c63; // blt	s0,t2,80 <END>
assign mem[19] = 32'h00000413; // li	s0,0
assign mem[20] = 32'h00148493; // addi	s1,s1,1
assign mem[21] = 32'h0274c663; // blt	s1,t2,80 <END>
assign mem[22] = 32'h00000493; // li	s1,0
assign mem[23] = 32'h00190913; // addi	s2,s2,1
assign mem[24] = 32'h02794063; // blt	s2,t2,80 <END>
assign mem[25] = 32'h00000913; // li	s2,0
assign mem[26] = 32'h00198993; // addi	s3,s3,1
assign mem[27] = 32'h0079ca63; // blt	s3,t2,80 <END>
assign mem[28] = 32'h00000993; // li	s3,0
assign mem[29] = 32'h001a0a13; // addi	s4,s4,1
assign mem[30] = 32'h007a4463; // blt	s4,t2,80 <END>
assign mem[31] = 32'h00000a13; // li	s4,0
assign mem[32] = 32'h00000593; // li	a1,0
assign mem[33] = 32'h00449493; // slli	s1,s1,0x4
assign mem[34] = 32'h00891913; // slli	s2,s2,0x8
assign mem[35] = 32'h00c99993; // slli	s3,s3,0xc
assign mem[36] = 32'h0085e5b3; // or	a1,a1,s0
assign mem[37] = 32'h0095e5b3; // or	a1,a1,s1
assign mem[38] = 32'h0125e5b3; // or	a1,a1,s2
assign mem[39] = 32'h0135e5b3; // or	a1,a1,s3
assign mem[40] = 32'h0044d493; // srli	s1,s1,0x4
assign mem[41] = 32'h00895913; // srli	s2,s2,0x8
assign mem[42] = 32'h00c9d993; // srli	s3,s3,0xc
assign mem[43] = 32'h00008067; // ret




endmodule
