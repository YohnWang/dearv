module top
	(	
clk,reset_n,oSEG,oSEGDP,oCOM
	);

input clk;
input reset_n;
output [6:0] oSEG;
output [3:0] oCOM;
output oSEGDP;
reg [3:0] oCOM;
reg oSEGDP;

seg7_disp4	seg7_disp4_inst(.clk(clk),.reset_n(reset_n),.oSEG(seg7_out),.oSEGDP(seg7dp_out),.oCOM(seg7_sel),.digitals({4'd4,4'd3,4'd2,4'd2}));

endmodule