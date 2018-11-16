module soc
(
	input wire clk,
	input wire rst
);


wire[63:0] iaddr,idata,ddata,daddr,wdata;

cpu cpu_inst
(
	.idata(idata),
	.ddata(ddata),
	.iaddr(iaddr),
	.daddr(daddr),
	.wdata(wdata),
	.clk(clk),
	.rst(rst)
);

imem imem_inst
(
	.addr(iaddr),
	.word(10),
	.data(idata)
);

dmem dmem_inst
(
	.addr(daddr),
	.dataw(ddata),
	.word(11),
	.rw(),
	.clk(clk),
	.datar(wdata)
);


endmodule
