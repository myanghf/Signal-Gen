`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 14:18:33
// Design Name: 
// Module Name: step_sel
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


module step_selector(
    input CLK, FREQ_sel, VOLT_BIT, [4:0]step_sel, 
    output reg [13:0]step
    );
    
    always @(posedge CLK) begin
        if(FREQ_sel) begin
            if(step_sel == 'b10000) begin step <= 'd10000; end
            if(step_sel =='b1000) begin step<='d1000; end
            if(step_sel =='b0100) begin step<='d100; end
            if(step_sel =='b0010) begin step<='d10; end
            if(step_sel =='b0001) begin step<='d1; end
            if(step_sel =='b0000) begin step<='d0; end
        end
        if(VOLT_BIT) begin
            if(step_sel =='b1000) begin step<='b0100_1101_1001; end
            if(step_sel =='b0100) begin step<='b0000_0111_1100; end
            if(step_sel =='b0010) begin step<='b0000_0000_1100; end
            if(step_sel =='b0001) begin step<='b0000_0000_0001; end
            if(step_sel =='b0000) begin step<='b0000_0000_0000; end
        end
        if(!VOLT_BIT) begin
            if(step_sel =='b1000) begin step<='d1000; end
            if(step_sel =='b0100) begin step<='d100; end
            if(step_sel =='b0010) begin step<='d10; end
            if(step_sel =='b0001) begin step<='d1; end
            if(step_sel =='b0000) begin step<='d0; end
        end
    end
endmodule
