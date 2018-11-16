module gpio
(
	input wire addr,
	input wire rw,
	input wire[31:0] in,
	input wire[31:0] wdata,
	input wire clk,
	output reg[31:0] gpout,
	output reg[31:0] gpread
);

reg[31:0] array[1:0]; //array[0] is output,array[1] is input

always@(posedge clk)
begin 
	if(rw && !addr)
		array[0]<=wdata;
	else 
		gpread<=array[addr];
end


always@(*)
begin 
	gpout=array[0];
end



endmodule
