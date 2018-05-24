`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2017 03:13:42 PM
// Design Name: 
// Module Name: am_gen
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


module am_gen(
    input [11:0] waveSinA, [11:0] waveSinB, [11:0] VmaxA, [11:0] VminA, [11:0] VmaxB, [11:0] VminB,
    output [11:0]waveAM
    );
    
    assign waveAM = (((waveSinA - (VmaxA+VminA)/2 ) * (waveSinB - (VmaxB+VminB)/2))/'d2048) +'d2047;
endmodule
