`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2017 04:56:39 PM
// Design Name: 
// Module Name: temp_div
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


module temp_div(
    input CLK, output reg clock50
    );
    
    reg [1:0] COUNT = 0;
    
    always@ (posedge CLK) begin
        COUNT <= COUNT + 1;
        if(COUNT[1] == 0) begin 
            COUNT <= 0;
            clock50 <= ~clock50;
        end
    end
    
endmodule
