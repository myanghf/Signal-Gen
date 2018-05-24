`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2017 08:18:59 PM
// Design Name: 
// Module Name: get_count_sin
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


module get_count_sin(
    input [15:0] user_freq, 
    output [18:0] COUNT_IN_SIN
    );
    assign COUNT_IN_SIN = ('d250000 / user_freq); 
endmodule