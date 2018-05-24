`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2017 07:31:15 PM
// Design Name: 
// Module Name: sevenseg_freq
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

module sevenseg_freq(
    input clock, [19:0] user_freq,
    output [6:0] seg, dp, [3:0] an
);
 
localparam N = 18;
 
reg [N-1:0]count; 

always @ (posedge clock )begin count <= count + 1; end
 
reg [6:0]sseg;
reg [3:0]an_temp, in3, in2, in1, in0;
reg dp_temp;

always @ (*) begin
    if(user_freq <= 'd9999) begin
        in3 <= user_freq/1000;
        in2 <= (user_freq%1000)/100;
        in1 <= (user_freq%100)/10;
        in0 <= user_freq%10;
    end
    else if(user_freq >= 'd10000 && user_freq <= 'd99999) begin
        in3 <= user_freq/10000;
        in2 <= (user_freq%10000)/1000;
        in1 <= (user_freq%1000)/100;
        in0 <= (user_freq%100)/10;
    end
end


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
        4'd0 : sseg_temp = 7'b1000000; //0
        4'd1 : sseg_temp = 7'b1111001; //1
        4'd2 : sseg_temp = 7'b0100100; //2
        4'd3 : sseg_temp = 7'b0110000; //3
        4'd4 : sseg_temp = 7'b0011001; //4
        4'd5 : sseg_temp = 7'b0010010; //5
        4'd6 : sseg_temp = 7'b0000010; //6
        4'd7 : sseg_temp = 7'b1111000; //7
        4'd8 : sseg_temp = 7'b0000000; //8
        4'd9 : sseg_temp = 7'b0010000; //9
        default : sseg_temp = 7'b0111111; //-
    endcase
end
assign seg = sseg_temp; 

always @ (*) begin
    if(user_freq <= 'd999) begin
        dp_temp <= 1'b1;
    end
    
    else if(user_freq >= 'd1000 && user_freq <= 'd9999) begin
        if(an_temp == 4'b0111) begin 
            dp_temp <= 1'b0 ;
        end
        else begin 
            dp_temp <= 1'b1; 
        end
    end

    else if(user_freq >= 'd10000 && user_freq <= 'd99999) begin
        if(an_temp == 4'b1011) begin 
            dp_temp <= 1'b0 ;
        end
        else begin 
            dp_temp <= 1'b1; 
        end
    end
    
end

assign dp = dp_temp;
 
endmodule
