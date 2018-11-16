module soc
(
	input wire clk,
	input wire rst,
	output [6:0] seg7_out,
    output [3:0] seg7_sel,
    output seg7dp_out
);


wire[63:0] iaddr,idata,ddata,daddr,wdata;
wire rw;
wire[1:0] word;

cpu cpu_inst
(
	.idata(idata),
	.ddata(ddata),
	.iaddr(iaddr),
	.daddr(daddr),
	.wdata(wdata),
	.memrw(rw),
	.memword(word),
	.clk(clk),
	.rst(rst)
);

assign iaddr[63:10]=0;
assign daddr[63:12]=0;

`define _TEST
`ifdef _TEST

imem imem_inst
(
	.addr(iaddr[9:0]),
	.word(2'b10),
	.data(idata)
);

`else

imem imem_inst(
        .dout(idata), //output [31:0] dout
        .clk(clk), //input clk
        .oce(1), //input oce
        .ce(1), //input ce
        .reset(rst), //input reset
        .wre(), //input wre
        .ad(iaddr[7:0]) //input [7:0] ad
);

GW_PLL gw_pll_inst
(
        .clkout(clk), //output clkout
        .clkoutp(), //output clkoutp
        .clkoutd(), //output clkoutd
        .clkoutd3(), //output clkoutd3
        .clkin(clk), //input clkin
        .psda(), //input [3:0] psda
        .dutyda(), //input [3:0] dutyda
        .fdly() //input [3:0] fdly
);
`endif


dmem dmem_inst
(
	.addr(daddr[11:0]),
	.dataw(wdata),
	.word(word),
	.rw(rw),
	.clk(clk),
	.datar(ddata)
);

gpio gpio_inst
(
	.addr(daddr[2]),
	.rw(rw),
	.in(),
	.wdata(),
	.clk(clk),
	.gpout(),
	.gpread()

);

reg[15:0] seg7_data;
always@(*)
begin 
	if(daddr==64'h1024 && word==2'b01 && rw==1)
		seg7_data=wdata[15:0];
	else 
		;
end

seg7_disp4 seg7_disp4_inst
(
	.clk(clk),
	.reset_n(!rst),
	.oSEG(seg7_out),
	.oSEGDP(seg7dp_out),
	.oCOM(seg7_sel),
	.digitals(seg7_data)
);


endmodule
