`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2017 03:24:08 PM
// Design Name: 
// Module Name: arb_gen
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


module arb_gen(
    input [11:0] waveDCA, [11:0] waveDCB, [11:0] waveSquareA, [11:0] waveSquareB, [11:0] waveTriangleA, [11:0] waveTriangleB, [11:0] waveSinA, [11:0] waveSinB, [11:0] waveAM,
    input [2:0] waveFlagA, [2:0] waveFlagB,
    output [11:0] waveArb
    );
    
    reg [11:0] arbtempA;
    reg [11:0] arbtempB;
    
    always @(*) begin
        if(waveFlagA == 'd0) begin arbtempA <= waveDCA; end
        if(waveFlagA == 'd1) begin arbtempA <= waveSquareA; end
        if(waveFlagA == 'd2) begin arbtempA <= waveTriangleA; end
        if(waveFlagA == 'd3) begin arbtempA <= waveSinA; end
        if(waveFlagA == 'd4) begin arbtempA <= waveAM; end
        if(waveFlagB == 'd0) begin arbtempB <= waveDCB; end
        if(waveFlagB == 'd1) begin arbtempB <= waveSquareA; end
        if(waveFlagB == 'd2) begin arbtempB <= waveTriangleA; end
        if(waveFlagB == 'd3) begin arbtempB <= waveSinA; end
        if(waveFlagB == 'd4) begin arbtempB <= waveAM; end
    end
    
    assign waveArb = (arbtempA + arbtempB) / 2; 
endmodule
