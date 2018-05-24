`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 16:12:26
// Design Name: 
// Module Name: frequency_selector
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


module frequency_selector(
    input clock40, Up, Down, Center, reset, FREQ_sel, CH1_sel, CH2_sel, [13:0] step,  
    output [15:0] user_freqA, [15:0] user_freqB
    );
    
    reg [15:0] freq_tempA = 'd1;
    reg [15:0] freq_tempB = 'd1;
    
    always @(posedge clock40) begin
        if(FREQ_sel) begin
            if(CH1_sel) begin
                if(Down) begin freq_tempA <=  freq_tempA - step; end
                if(Up) begin freq_tempA <= freq_tempA + step; end
                if(freq_tempA >= 'd50001) begin freq_tempA <= 'd1; end
            end
            if(CH2_sel) begin
                if(Down) begin freq_tempB <= freq_tempB - step; end
                if(Up) begin freq_tempB <= freq_tempB + step; end
                if(freq_tempB >= 'd50001) begin freq_tempB <= 'd1; end
            end
        end
        if(reset && Center) begin
            if(CH1_sel) begin freq_tempA <= 'd1; end
            if(CH2_sel) begin freq_tempB <= 'd1; end
        end
    end

assign user_freqA = freq_tempA;
assign user_freqB = freq_tempB;

endmodule
