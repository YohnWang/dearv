`include "const.h"

module register
#(
	parameter XLEN=64
)
(
	input  wire[4:0] rd,
	input  wire[4:0] rs1,
	input  wire[4:0] rs2,
	output wire[XLEN-1:0]  out1,
	output wire[XLEN-1:0]  out2,
	input  wire[XLEN-1:0] rd_in,
	input  wire rd_we,
	input  wire clk
);

reg[XLEN-1:0] reg_file[31:0];

assign out1 = rs1?reg_file[rs1]:0;
assign out2 = rs2?reg_file[rs2]:0;

always @ (posedge clk)
begin 
	if(rd_we)
		reg_file[rd]<=rd_in;
	else 
		;
end

endmodule
