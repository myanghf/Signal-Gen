`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2017 10:32:59 AM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input CLK, output reg clock1
    );
    
    reg [24:0] COUNT = 0;
    
    always @ (posedge CLK) begin
        COUNT <= COUNT +1; 
        if(COUNT == 'd25000000) begin 
            clock1 <= ~clock1;
        end
    end
    
endmodule
