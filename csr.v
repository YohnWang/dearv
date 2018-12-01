`include "csrencoding.h"
module csr
#(
	parameter XLEN=64
)
(
	input wire[11:0] csraddr,
	input wire[1:0]  funct,
	input wire[XLEN-1:0] wdata,
	output reg[XLEN-1:0] rdata,
	
	output wire[XLEN-1:0] mtvec,
	output wire[XLEN-1:0] mepc,
	output wire[XLEN-1:0] mie,
	
	input wire wen,
	input wire clk,
	input wire rst
);

reg[XLEN-1:0] csr_file[15:0];

assign mtvec=csr_file[`MTVEC];
assign mepc=csr_file[`MEPC];
assign mie=csr_file[`MIE];




integer i;

always@(posedge clk)
begin 
	if(rst)
	begin 
		for(i=0;i<16;i=i+1)
			csr_file[i]<=0;
	end
	else if(!rst && wen)
	begin 
		rdata<=csr_file[decode];
		csr_file[decode]<=csr_gen;
	end
	else 
		;
end

reg[3:0] decode;

always@(*)
begin 
	case(csraddr)
		12'h300:decode=`MSTATUS;
		12'h304:decode=`MIE;
		12'h305:decode=`MTVEC;
		12'h306:decode=`MCOUNTEREN;
		12'h340:decode=`MSCRATCH;
		12'h341:decode=`MEPC;
		12'h342:decode=`MCAUSE;
		12'h343:decode=`MTVAL;
		12'h344:decode=`MIP;
		default:;
	endcase
end

reg[XLEN-1:0] csr_gen;

always@(*)
begin 
	case(funct)
		`CSR_RW:csr_gen=wdata;
		`CSR_RS:csr_gen=wdata|csr_file[decode];
		`CSR_RC:csr_gen=(~wdata)&csr_file[decode];
		default:;
	endcase 

end


endmodule
