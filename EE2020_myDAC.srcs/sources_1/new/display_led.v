`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2017 03:12:15 PM
// Design Name: 
// Module Name: display_led
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


module display_led(
    input clock40, CH1_sel, CH2_sel, FREQ_sel, DCYCLE_sel, VMAX, VMIN, [2:0]waveFlagA, [2:0]waveFlagB,
    input [14:0] user_freqB, [6:0] duty_cycleB, [11:0] VmaxB, [11:0] VminB, [11:0] VminA,
    output reg [15:0]led
    );
    
    reg [4:0]ledA;
    reg [4:0]ledB;
    
    always@ (posedge clock40) begin
    
        if(!CH1_sel && !CH2_sel) begin led <= 0; end
        if(CH1_sel && !CH2_sel) begin
            if(VMAX && VMIN)begin 
                led <= VminA;
            end
            else begin led <= 0; end
        end
        if(!CH1_sel && CH2_sel) begin
            if(VMAX && VMIN) begin
                led <= VminB;
            end
            else begin led <= 0; end
        end
        if(CH1_sel && CH2_sel) begin 
            if(FREQ_sel) begin led <= user_freqB; end
            if(DCYCLE_sel) begin led <= duty_cycleB; end
            if(VMAX) begin led <= VmaxB; end
            if(VMIN) begin led <= VminB; end
            if(!FREQ_sel && !DCYCLE_sel && !VMAX && !VMIN) begin led <= 0; end
        end
        if(!FREQ_sel && !DCYCLE_sel && !VMAX && !VMIN) begin
            if(waveFlagA == 'd0) begin ledA <= 'b10000; end
            else if(waveFlagA == 'd1) begin ledA <= 'b01000; end
            else if(waveFlagA == 'd2) begin ledA <= 'b00100; end
            else if(waveFlagA == 'd3) begin ledA <= 'b00010; end
            else if(waveFlagA == 'd4) begin ledA <= 'b00001; end
            if(waveFlagB == 'd0) begin ledB <= 'b10000; end
            else if(waveFlagB == 'd1) begin ledB <= 'b01000; end
            else if(waveFlagB == 'd2) begin ledB <= 'b00100; end
            else if(waveFlagB == 'd3) begin ledB <= 'b00010; end
            else if(waveFlagB == 'd4) begin ledB <= 'b00001; end
            led[15:11] <= ledA[4:0];
            led[10:6] <= ledB[4:0];
        end
    end
endmodule
