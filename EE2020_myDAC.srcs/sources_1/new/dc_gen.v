`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 14:18:33
// Design Name: 
// Module Name: dc_gen
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


module dc_gen(
    input [11:0]Vmax, 
    output [11:0]waveOUT
    );
    
    assign waveOUT = Vmax;
    
endmodule
