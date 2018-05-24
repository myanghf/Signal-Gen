`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2017 01:04:18 PM
// Design Name: 
// Module Name: sevenseg
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

module sevenseg(
    input clock, [3:0]in3, [3:0]in2, [3:0]in1, [3:0]in0,
    output [6:0] seg, dp, [3:0] an 
);
 
localparam N = 18;
 
reg [N-1:0]count; 
 
always @ (posedge clock )begin count <= count + 1; end
 
reg [6:0]sseg; 
reg [3:0]an_temp; 
 
always @ (*) begin
    case(count[N-1:N-2]) 
        'b00: begin sseg = in0; an_temp = 4'b1110; end
        'b01: begin sseg = in1; an_temp = 4'b1101; end
        'b10: begin sseg = in2; an_temp = 4'b1011; end
        'b11: begin sseg = in3; an_temp = 4'b0111; end
    endcase
end
assign an = an_temp;
 
reg [6:0] sseg_temp; 
 
always @ (*) begin
    case(sseg)
        'd0 : sseg_temp = 'b1000000; //0
        'd1 : sseg_temp = 'b1111001; //1
        'd2 : sseg_temp = 'b0100100; //2
        'd3 : sseg_temp = 'b0110000; //3
        'd4 : sseg_temp = 'b0011001; //4
        'd5 : sseg_temp = 'b0010010; //5
        'd6 : sseg_temp = 'b0000010; //6
        'd7 : sseg_temp = 'b1111000; //7
        'd8 : sseg_temp = 'b0000000; //8
        'd9 : sseg_temp = 'b0010000; //9
        default : sseg_temp = 'b0111111; //-
    endcase
end
assign seg = sseg_temp; 
assign dp = 1'b1;
 
endmodule