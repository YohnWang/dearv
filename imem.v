module imem
(
	input wire[9:0] addr,
	input wire[1:0]  word,
	output reg[63:0] data
);

reg[7:0] mem[1023:0];

initial $readmemh("./riscv-test/imem.txt",mem);

always@(*)
begin 
	case(word)
		2'b00 : data={mem[addr]};
		2'b01 : data={mem[addr+1],mem[addr]};
		2'b10 : data={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
		2'b11 : data={mem[addr+7],mem[addr+6],mem[addr+5],mem[addr+4],mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
	endcase
end

endmodule
