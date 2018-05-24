`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 14:18:33
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider(
    input CLK, [15:0]user_freq, 
    output reg clockSQ, reg clockTRI, reg clockSIN, reg clockHALF, reg clockSAMP, reg clock40
    );
    
    wire [18:0] COUNT_IN, COUNT_IN_SIN;
    reg [18:0] COUNT, COUNT2, COUNT3, COUNT4, COUNT5;
    
    get_count getCount (user_freq, COUNT_IN);
    get_count_sin getCountSin (user_freq, COUNT_IN_SIN);
    
    always @(posedge CLK) begin
        COUNT <= COUNT +1;
        COUNT2 <= COUNT2 +1;
        COUNT3 <= COUNT3 +1;
        COUNT4 <= COUNT4 +1;
        COUNT5 <= COUNT5 +1;

        
        if(COUNT == COUNT_IN) begin
            COUNT <= 0; 
            clockSQ <= ~clockSQ;
            clockTRI <= ~clockTRI;
        end
        if(COUNT2 == COUNT_IN_SIN) begin
            COUNT2 <= 0;
            clockSIN <= ~clockSIN;
        end
        if(COUNT3 == 1) begin
            COUNT3 <= 0;
            clockHALF <= ~clockHALF;
        end
        if(COUNT4 == 'd16) begin
            COUNT4 <= 0;
            clockSAMP <= ~clockSAMP;
        end
        if(COUNT5 == 'd500000) begin
            COUNT5 <= 0;
            clock40 <= ~clock40;
        end
    end
    
endmodule
