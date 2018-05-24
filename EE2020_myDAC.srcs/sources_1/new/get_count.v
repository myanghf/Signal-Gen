`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2017 03:21:13 PM
// Design Name: 
// Module Name: get_count
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


module get_count(
    input [15:0]user_freq, 
    output [18:0] COUNT_IN
    );
    assign COUNT_IN = (25'd500000 / user_freq);
endmodule