module clint
(
	input wire[15:0]  addr,
	input wire[63:0]  wdata,
	input wire        rw,
	input wire[1:0]   word,
	output wire[63:0] ddata,
	input clk,
	input rst,
	input cs
);

parameter MTIME_BASE=16'hbff8,MTIMECMP_BASE=16'h4000,MSIP_BASE=16'h0;


reg[63:0] mtime,mtimecmp,msip;
reg[63:0] mtime_tmp,mtimecmp_tmp,msip_tmp;



reg[63:0] ddatax;
assign ddata = cs?ddatax:64'hzzzzzzzzzzzzzzzz;

always@(posedge clk)
begin 
	case(addr)
		MSIP_BASE:    if(rw) ddatax=msip;     else ;
		MTIMECMP_BASE:if(rw) ddatax=mtime_tmp; else ;
		MTIME_BASE:   if(rw) ddatax=mtime;    else ;
		default:;
	endcase
end


always@(*)
begin 
	if(cs)
	begin 
		if(addr == MTIMECMP_BASE)
			case(word)
				2'b00:mtimecmp[7:0] =mtimecmp_tmp[7:0];
				2'b01:mtimecmp[15:0]=mtimecmp_tmp[15:0];
				2'b10:mtimecmp[31:0]=mtimecmp_tmp[31:0];
				2'b11:mtimecmp[63:0]=mtimecmp_tmp[63:0];
				default:;
			endcase
		else if(addr == MSIP_BASE)
			case(word)
				2'b00:msip[7:0] =msip_tmp[7:0];
				2'b01:msip[15:0]=msip_tmp[15:0];
				2'b10:msip[31:0]=msip_tmp[31:0];
				2'b11:msip[63:0]=msip_tmp[63:0];
				default:;
			endcase
		else
			;
	end
	else 
		;	
end


always@(*)
begin 
	case(addr)
		MSIP_BASE:    if(rw) msip_tmp<=wdata;     else ;
		MTIMECMP_BASE:if(rw) mtimecmp_tmp<=wdata; else ;
		MTIME_BASE:   if(rw) mtime_tmp<=wdata;    else ;
		default:;
	endcase
end

reg[15:0] count;
always@(posedge clk)
begin 
	if(rst)
	begin 
		mtime<=0;
		count<=0;
	end
	else 
	begin 
		count<=count+1;
	end
end

always@(posedge clk)
begin 
	if(count<50000)
		mtime<=mtime;
	else 
	begin
		mtime<=mtime+1;
		count<=0;
	end
end

endmodule
