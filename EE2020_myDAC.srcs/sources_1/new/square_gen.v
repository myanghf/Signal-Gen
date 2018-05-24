`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2017 14:18:33
// Design Name: 
// Module Name: square_gen
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


module square_gen(
    input CLOCK, [11:0]Vmax, [11:0]Vmin, [6:0]duty_cycle, 
    output reg [11:0]waveSquare
);
    
    reg [11:0] COUNT = 12'd0; 
    
    always @(posedge CLOCK) begin
        COUNT <= COUNT+1;
        
        if(COUNT == 100) begin COUNT <= 0; end
        if(duty_cycle == 100 || duty_cycle == 0) begin
            waveSquare <= (duty_cycle == 100) ? Vmax : Vmin; 
        end          
        else begin waveSquare <= (COUNT <= duty_cycle) ? Vmax : Vmin; end 
    end

endmodule
