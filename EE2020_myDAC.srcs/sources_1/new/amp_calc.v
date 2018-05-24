`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2017 08:34:20 PM
// Design Name: 
// Module Name: amp_calc
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


module amp_calc(
    input [11:0]Vmax, [11:0]Vmin, [16:0]maxVolt, [16:0]minVolt,
    output [11:0]ampBit, [16:0]ampVolt
    );
    
    assign ampBit = (Vmax - Vmin);
    assign ampVolt = (maxVolt - minVolt);
endmodule
