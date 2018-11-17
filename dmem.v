module dmem
(
	input wire[11:0] addr,
	input wire[63:0] dataw,
	input wire[1:0] word,
	input wire rw,
	input wire clk,
	output reg[63:0] datar,
	output reg[7:0]  gpio
);

reg[7:0] mem[63:0];
wire[5:0] addr_gen=addr[5:0];

always @(posedge clk)
begin
	if(rw)
	begin	
		case(word)
			2'b00: mem[addr_gen]<=dataw[7:0];
			2'b01: {mem[addr_gen+1],mem[addr_gen]}<=dataw[15:0];
			2'b10: {mem[addr_gen+3],mem[addr_gen+2],mem[addr_gen+1],mem[addr_gen]}<=dataw[31:0];
			2'b11: {mem[addr_gen+7],mem[addr_gen+6],mem[addr_gen+5],mem[addr_gen+4],mem[addr_gen+3],mem[addr_gen+2],mem[addr_gen+1],mem[addr_gen]}<=dataw;
		endcase
	end
	else
		;
end

always@(*)
begin
	datar={mem[addr_gen+7],mem[addr_gen+6],mem[addr_gen+5],mem[addr_gen+4],mem[addr_gen+3],mem[addr_gen+2],mem[addr_gen+1],mem[addr_gen]};
end

always@(*)
begin 
	gpio=mem[0];
end

endmodule


