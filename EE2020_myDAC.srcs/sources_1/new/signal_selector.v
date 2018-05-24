`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2017 02:52:24 PM
// Design Name: 
// Module Name: signal_selector
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


module signal_selector(
    input clock40, HALF_CLOCK, CH1_sel, CH2_sel, DC_override, reset, Left, Right, Up, Down, Center,
    input FREQ_sel, DCYCLE_sel, VMAX, VMIN, AMP_sel, ARB_sel, 
    input [11:0]waveDCA, [11:0]waveDCB, [11:0]waveSquareA, [11:0]waveSquareB, [11:0]waveTriangleA, [11:0]waveTriangleB, [11:0]waveSinA, [11:0]waveSinB, [11:0]waveAM, [11:0] waveArb,
    output reg [11:0]Atemp, reg [11:0]Btemp, reg [2:0]waveFlagA, reg [2:0]waveFlagB, reg [15:0] led
    );
    
initial begin
waveFlagA <= 'd1;
waveFlagB <= 'd1;
end
    
    always @(posedge clock40) begin
        if(CH1_sel && !FREQ_sel && !DCYCLE_sel && !VMAX && !VMIN && !DC_override) begin
            if(Up) begin waveFlagA <= 'd0; end //DC
            if(Down) begin waveFlagA <= 'd1; end //Square
            if(Left) begin waveFlagA <= 'd2; end //Triangle
            if(Right) begin waveFlagA <= 'd3; end //Sin
            if(Center) begin waveFlagA <= 'd4; end //AM
        end
        if(CH2_sel && !FREQ_sel && !DCYCLE_sel && !VMAX && !VMIN && !DC_override) begin
            if(Up) begin waveFlagB <= 'd0; end
            if(Down) begin waveFlagB <= 'd1; end
            if(Left) begin waveFlagB <= 'd2; end
            if(Right) begin waveFlagB <= 'd3; end  
            if(Center) begin waveFlagB <= 'd4; end          
        end
        if(Center && reset) begin
            if(CH1_sel) begin waveFlagA <= 'd1; end
            if(CH2_sel) begin waveFlagB <= 'd1; end
        end
    end
        
    always @(posedge HALF_CLOCK) begin
        if(!ARB_sel) begin
            if(waveFlagA == 'd0) begin Atemp <= waveDCA; end
            if(waveFlagA == 'd1) begin Atemp <= waveSquareA; end
            if(waveFlagA == 'd2) begin Atemp <= waveTriangleA; end
            if(waveFlagA == 'd3) begin Atemp <= waveSinA; end
            if(waveFlagA == 'd4) begin Atemp <= waveAM; end
            if(waveFlagB == 'd0) begin Btemp <= waveDCB; end
            if(waveFlagB == 'd1) begin Btemp <= waveSquareB; end
            if(waveFlagB == 'd2) begin Btemp <= waveTriangleB; end
            if(waveFlagB == 'd3) begin Btemp <= waveSinB; end
            if(waveFlagB == 'd4) begin Btemp <= waveAM; end
        end
        else if(ARB_sel) begin
            Atemp <= waveArb;
            Btemp <= waveArb;
        end
        if(DC_override) begin
            if(CH1_sel) begin Atemp <= waveDCA; end
            if(CH2_sel) begin Btemp <= waveDCB; end
        end
    end

endmodule
