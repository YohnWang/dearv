module dmem
(
	input wire[11:0] addr,
	input wire[63:0] dataw,
    input wire[1:0] word,
	input wire rw,
	input wire clk,
	output reg[63:0] datar
);

reg[7:0] mem[4095:0];


always @(posedge clk)
begin
	if(rw)
	begin	
		case(word)
			2'b00: mem[addr]<=dataw[7:0];
			2'b01: {mem[addr+1],mem[addr]}<=dataw[15:0];
			2'b10: {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}<=dataw[31:0];
			2'b11: {mem[addr+7],mem[addr+6],mem[addr+5],mem[addr+4],mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}<=dataw;
		endcase
	end
	else
		;
end

always@(*)
begin
	case(word)
		2'b00: datar={mem[addr]};
		2'b01: datar={mem[addr+1],mem[addr]};
	 	2'b10: datar={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
		2'b11: datar={mem[addr+7],mem[addr+6],mem[addr+5],mem[addr+4],mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};
	endcase
end

endmodule


