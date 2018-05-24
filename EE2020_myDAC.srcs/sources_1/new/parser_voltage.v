`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2017 06:05:55 PM
// Design Name: 
// Module Name: parser_voltage
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


module parser_voltage(
    input [11:0]Vmax, [11:0]Vmin, 
    output [16:0] maxVolt, [16:0] minVolt
    );
    
assign maxVolt = (((Vmax * 'd1000000) / 'd4095 ) * 'd33)/'d10000;
assign minVolt = (((Vmin * 'd1000000) / 'd4095 ) * 'd33)/'d10000;
    
endmodule
