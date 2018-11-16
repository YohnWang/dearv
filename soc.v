module soc
(
	input wire clk,
	input wire rst
);


wire[63:0] iaddr,idata,ddata,daddr,wdata;
wire rw;

cpu cpu_inst
(
	.idata(idata),
	.ddata(ddata),
	.iaddr(iaddr),
	.daddr(daddr),
	.wdata(wdata),
	.memrw(rw),
	.clk(clk),
	.rst(rst)
);

assign iaddr[63:10]=0;
assign daddr[63:12]=0;

imem imem_inst
(
	.addr(iaddr[9:0]),
	.word(2'b10),
	.data(idata)
);

dmem dmem_inst
(
	.addr(daddr[11:0]),
	.dataw(wdata),
	.word(2'b11),
	.rw(rw),
	.clk(clk),
	.datar(ddata)
);


endmodule
