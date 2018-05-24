`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2017 10:35:21 PM
// Design Name: 
// Module Name: step_calc
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


module step_calc(
    input clock40, Up, Down, Center, reset, VMAX, VMIN, AMP_sel, CH1_sel, CH2_sel, [13:0] step,
    output [11:0] Vmax_outA, [11:0] Vmin_outA, [11:0] Vmax_outB, [11:0] Vmin_outB
    );
    
    reg [11:0] VmaxA = 'hfff;
    reg [11:0] VminA = 'h0;
    reg [11:0] VmaxB = 'hfff;
    reg [11:0] VminB = 'h0;
    
    always @(posedge clock40) begin
        if(VMAX) begin
            if(Up) begin 
                if(CH1_sel) begin VmaxA <= VmaxA + step; end
                if(CH2_sel) begin VmaxB <= VmaxB + step; end
                if(VmaxA +step >= 'hfff) begin VmaxA <= 'hfff; end
                if(VmaxB +step >= 'hfff) begin VmaxB <= 'hfff; end
            end
            if(Down) begin
                if(CH1_sel) begin VmaxA <= VmaxA - step; end
                if(CH2_sel) begin VmaxB <= VmaxB - step; end
                if(VmaxA -step <= VminA) begin VmaxA <= VminA; end
                if(VmaxB -step <= VminB) begin VmaxB <= VminB; end
                if(VmaxA -step <= 0) begin VmaxA <= 0; end
                if(VmaxB -step <= 0) begin VmaxB <= 0; end
            end
        end
        if(VMIN) begin
            if(Up) begin 
                if(CH1_sel) begin VminA <= VminA + step; end
                if(CH2_sel) begin VminB <= VminB + step; end
                if(VminA +step >= VmaxA) begin VminA <= VmaxA; end
                if(VminB +step >= VmaxB) begin VminB <= VmaxB; end
                if(VminA +step >= 'hfff) begin VminA <= 'hfff; end
                if(VminB +step >= 'hfff) begin VminB <= 'hfff; end
            end
            if(Down) begin 
                if(CH1_sel) begin VminA <= VminA - step; end
                if(CH2_sel) begin VminB <= VminB - step; end
                if(VminA -step <= 0) begin VminA <= 0; end
                if(VminB -step <= 0) begin VminB <= 0; end
            end
        end
        if(AMP_sel) begin
            if(Up) begin 
                if(CH1_sel) begin VmaxA <= VmaxA + step/2; VminA <= VminA - step/2; end
                if(CH2_sel) begin VmaxB <= VmaxB + step/2; VminB <= VminB - step/2; end
            end
            if(Down) begin 
                if(CH1_sel) begin VmaxA <= VmaxA - step/2; VminA <= VminA + step/2; end
                if(CH2_sel) begin VmaxB <= VmaxB - step/2; VminB <= VminB + step/2; end
            end
        end
        if(Center && reset) begin
            if(CH1_sel) begin VmaxA <= 'hfff; VminA <= 0; end
            if(CH2_sel) begin VmaxB <= 'hfff; VminB <= 0; end
        end
    end
    
    assign Vmax_outA = VmaxA;
    assign Vmin_outA = VminA;
    assign Vmax_outB = VmaxB;
    assign Vmin_outB = VminB;
endmodule
