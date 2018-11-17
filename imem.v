module imem
(
	input wire[9:0] addr,
	input wire[1:0]  word,
	output reg[63:0] data
);

wire[31:0] mem[31:0];

//initial $readmemh("./riscv-test/imem.txt",mem);

always@(*)
begin 
	data=mem[addr[6:2]];
end


assign mem[0] = 32'h00a00093; // li	ra,10
assign mem[1] = 32'h00102023; // sw	ra,0(zero) # 0 <_start>
assign mem[2] = 32'h00000063; // beqz	zero,8 <.L11>

endmodule
