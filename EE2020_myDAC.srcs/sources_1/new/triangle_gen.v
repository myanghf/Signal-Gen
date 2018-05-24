`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2017 12:18:45 AM
// Design Name: 
// Module Name: triangle_gen
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


module triangle_gen(
    input clockVARTRI, [11:0] Vmax, [11:0] Vmin, [6:0]duty_cycle, 
    output [11:0] waveTriangle 
);

reg direction = 0; 
reg [11:0] tri_temp = 0;
reg [6:0] COUNT = 0; 
reg [11:0] stepup = 0;
reg [11:0] stepdn = 0;

    always @(posedge clockVARTRI) begin
        stepup <= (Vmax - Vmin) / duty_cycle;
        stepdn <= (Vmax - Vmin) / (100 - duty_cycle);
        COUNT <= COUNT +1;
        
        if(COUNT == 100) begin COUNT <= 0; end
        if(COUNT <= duty_cycle) begin direction <= 0; end
        if(COUNT >= duty_cycle) begin direction <= 1; end
        
        if(!direction) begin
            tri_temp <= tri_temp + stepup; 
            if(tri_temp >= Vmax-stepup) begin 
                direction <= 1;
                tri_temp <= (Vmax - stepdn);  
            end
        end
        if(direction) begin
            tri_temp <= tri_temp - stepdn; 
            if(tri_temp <= Vmin +stepdn) begin 
                direction <= 0;
                tri_temp <= Vmin + stepup;
             end
        end
    end
    
    assign waveTriangle = tri_temp;
    
endmodule