module brcomp
#(
	parameter XLEN=64
)
(
	input wire[XLEN-1:0] x,
	input wire[XLEN-1:0] y,
	input wire brun,
	output reg brlt,
	output reg breq
);

always@(*)
begin 
	brlt=brun?$unsigned(x)<$unsigned(y):$signed(x)<$signed(y);
	breq=(x==y);
end 

endmodule
