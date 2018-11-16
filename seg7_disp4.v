`timescale 1ns/100ps
module seg7_disp4(clk,reset_n,oSEG,oSEGDP,oCOM,digitals);
    input clk;
    input reset_n;
    output [6:0] oSEG;
    output [3:0] oCOM;
    output oSEGDP;
    input [15:0] digitals;
    reg [3:0] oCOM;
    reg oSEGDP;
    parameter IDLE=5'b00000;
    parameter DISP0=5'b00010;
    parameter DISP1=5'b00100;
    parameter DISP2=5'b01000;
    parameter DISP3=5'b10000;

    reg [4:0] state,nxstate;

    reg [3:0] tmp_reg;

    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            state <= IDLE;
        else
            state <= nxstate;
    end

    //next state
    always@(state)
    begin
        case(state)
            IDLE: nxstate <= DISP0;
            DISP0: nxstate <= DISP1;
            DISP1: nxstate <= DISP2;
            DISP2: nxstate <= DISP3;
            DISP3: nxstate <= DISP0;
            default: nxstate <= IDLE;
        endcase
    end

    //output
    always@(state or digitals)
    begin
        case(state)
            DISP0: begin
                tmp_reg <= digitals[3:0];
                oCOM <=4'b0001;
                oSEGDP <=1'b1;
            end

            DISP1: begin
                tmp_reg <= digitals[7:4];
                oCOM <=4'b0010;
                oSEGDP <=1'b1;                
            end
            DISP2: begin
                tmp_reg <= digitals[11:8];
                oCOM <=4'b0100;
                oSEGDP <=1'b1;                
            end
            DISP3: begin
                tmp_reg <= digitals[15:12];
                oCOM <=4'b1000;
                oSEGDP <=1'b0;
            end
            default: begin
                tmp_reg <= 4'b0000;
                oCOM <=4'b0000;
                oSEGDP <=1'b1;                
            end
        endcase
    end

seg7_decode		seg7_decode_inst(tmp_reg,oSEG);
	
endmodule
