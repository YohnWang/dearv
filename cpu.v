`include "const.h"
module cpu
(
	input wire[63:0]  idata,
	input wire[63:0]  ddata,
	output wire[63:0] iaddr,
	output wire[63:0] daddr,
	output wire[63:0] wdata,
	output wire memrw,
	output wire[1:0] memword,
	input wire clk,
	input wire rst
);

wire[2:0] wimmsel;
wire wregwen;
wire wbrun;
wire wbsel;
wire wasel;
wire[3:0] walusel;
wire waluupper;
wire wmemrw;
wire[1:0] wwbsel;
wire[63:0] wpc;
wire wpcsel;
wire[31:0] winst;
wire wbreq;
wire wbrlt;
wire[1:0] wmemword;
wire[63:0] wdataa;
wire[63:0] wdatab;
reg[63:0] wwb;
wire signed [63:0] wimm;
wire[63:0] walu;
wire wmemsign;


reg[63:0] memdata_gen;
always@(*)
begin 
	case(wmemword)
		2'b00: memdata_gen=wmemsign?{56'b0,ddata[7:0]}:{{56{ddata[7]}},ddata[7:0]};
		2'b01: memdata_gen=wmemsign?{48'b0,ddata[15:0]}:{{48{ddata[7]}},ddata[15:0]};
		2'b10: memdata_gen=wmemsign?{32'b0,ddata[31:0]}:{{32{ddata[7]}},ddata[31:0]};
		2'b11: memdata_gen=ddata;
	endcase
end

always @(*)
begin
	case(wwbsel)
		`WB_MEM:    wwb=memdata_gen;
		`WB_ALU:    wwb=walu;
		`WB_PCPLUS4:wwb=wpc+4;
		default:;
	endcase
end

assign winst=idata[31:0];
assign memword=wmemword;

cu cu_inst
(
	.inst(winst),
	.breq(wbreq),
	.brlt(wbrlt),
	.pcsel(wpcsel),
	.immsel(wimmsel),
	.regwen(wregwen),
	.brun(wbrun),
	.asel(wasel),
	.bsel(wbsel),
	.alusel(walusel),
	.aluupper(waluupper),
	.memrw(memrw),
	.memword(wmemword),
	.memsign(wmemsign),
	.wbsel(wwbsel)
);

//wire[63:0] wpcplus4=wpc+4;
//wire[63:0] wpcx=wpcsel?walu:wpc+4;

assign iaddr=wpc;

pc pc_inst
(
	.x(wpcsel?walu:wpc+4),
	.y(wpc),
	.clk(clk),
	.reset(rst)
);



register register_inst
(
	.rd(winst[11:7]),
	.rs1(winst[19:15]),
	.rs2(winst[24:20]),
	.out1(wdataa),
	.out2(wdatab),
	.rd_in(wwb),
	.rd_we(wregwen),
	.clk(clk)
);

immgen immgen_inst
(
	.inst(winst),
	.immsel(wimmsel),
	.imm(wimm)
);

brcomp brcomp_inst
(
	.x(wdataa),
	.y(wdatab),
	.brun(wbrun),
	.brlt(wbrlt),
	.breq(wbreq)
);

assign daddr=walu;
assign wdata=wdatab;

alu alu_inst
(
	.x(wasel?wpc:wdataa),
	.y(wbsel?wimm:wdatab),
	.alusel(walusel),
	.upper(waluupper),
	.z(walu)
);




endmodule
