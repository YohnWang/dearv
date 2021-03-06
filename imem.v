module imem
(
	input wire[9:0] addr,
	input wire[1:0]  word,
	output reg[63:0] data,
	input wire cs
);

reg[7:0] mem[1023:0];

initial $readmemh("./riscv-test/imem.txt",mem);

reg[63:0] datax;

always@(*) data = cs?datax:64'hzzzzzzzzzzzzzzzz;

always@(*)
begin 
	case(word)
		2'b00 : datax={mem[addr]};
		2'b01 : datax={mem[addr+1],mem[addr]};
		2'b10 : datax={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
		2'b11 : datax={mem[addr+7],mem[addr+6],mem[addr+5],mem[addr+4],mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
	endcase
end

endmodule
