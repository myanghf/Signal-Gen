`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 14:18:33
// Design Name: 
// Module Name: single_pulse
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


module single_pulse(
    input CLK, PUSH, 
    output PULSE
    );
    
    wire Q1, Q2;
    dff pc1(CLK, PUSH, Q1);
    dff pc2(CLK, Q1, Q2);
    
    assign PULSE = Q1 & ~Q2;
    
endmodule
