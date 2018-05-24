`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2017 11:16:49 PM
// Design Name: 
// Module Name: duty_cycle_control
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


module duty_cycle_control(
    input clock40, Up, Down, Center, reset, DCYCLE_sel, CH1_sel, CH2_sel, [13:0] step, 
    output [6:0]duty_cycleA, [6:0]duty_cycleB
    );
    
    reg [6:0] dc_flagA = 'd50;
    reg [6:0] dc_flagB = 'd50;
    
    always @ (posedge clock40) begin
        if(DCYCLE_sel) begin
            if(Down) begin 
                if(CH1_sel) begin dc_flagA <= dc_flagA -step; end
                if(CH2_sel) begin dc_flagB <= dc_flagB -step; end
            end
            if(Up) begin
                if(CH1_sel) begin dc_flagA <= dc_flagA +step; end
                if(CH2_sel) begin dc_flagB <= dc_flagB +step; end
            end
            if(dc_flagA >= 'd101) begin dc_flagA <= 'd100; end
            if(dc_flagB >= 'd101) begin dc_flagB <= 'd100; end
            if(dc_flagA < 'd0) begin dc_flagA <= 'd0; end
            if(dc_flagB < 'd0) begin dc_flagB <= 'd0; end
         end
         if(Center && reset) begin
            if(CH1_sel) begin dc_flagA <= 'd50; end
            if(CH2_sel) begin dc_flagB <= 'd50; end
        end
     end
     
     assign duty_cycleA = dc_flagA; 
     assign duty_cycleB = dc_flagB;
endmodule
