`timescale 1ns/100ps
module seg7_decode(seg7_in,oSEG7);
input		[3:0]	seg7_in;
output	[6:0]	oSEG7;
reg		[6:0]	oSEG7;

 // seg7 decoder
    always@(seg7_in)
    begin
        case(seg7_in)
            4'h0: oSEG7 = 7'b1000000; 
            4'h1: oSEG7 = 7'b1111001; 
            4'h2: oSEG7 = 7'b0100100; 
            4'h3: oSEG7 = 7'b0110000; 
            4'h4: oSEG7 = 7'b0011001; 
            4'h5: oSEG7 = 7'b0010010; 
            4'h6: oSEG7 = 7'b0000010; 
            4'h7: oSEG7 = 7'b1111000; 
            4'h8: oSEG7 = 7'b0000000; 
            4'h9: oSEG7 = 7'b0010000; 
            default: oSEG7 = 7'b1111111;
        endcase
    end
endmodule