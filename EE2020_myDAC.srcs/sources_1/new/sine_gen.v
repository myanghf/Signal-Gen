`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2017 01:07:15 PM
// Design Name: 
// Module Name: sine_gen
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


module sine_gen(
    input ClockVARSIN, [11:0] Vmax, [11:0] Vmin,
    output [11:0] waveSin
);

    reg [31:0] sin [0:99];
    reg [31:0] data_out; 
    wire [31:0] Amplitude = (Vmax - Vmin) /2;
      
    integer i;  
    
    initial begin
        i = 0;
        sin [0] = 'd0;
        sin [1] = 'd31411;
        sin [2] = 'd62790;
        sin [3] = 'd94108;
        sin [4] = 'd125333;
        sin [5] = 'd156434;
        sin [6] = 'd187381;
        sin [7] = 'd218143;
        sin [8] = 'd248690;
        sin [9] = 'd278991;
        sin [10] = 'd309017;
        sin [11] = 'd338738;
        sin [12] = 'd368124;
        sin [13] = 'd397148;
        sin [14] = 'd425779;
        sin [15] = 'd453990;
        sin [16] = 'd481753;
        sin [17] = 'd509041;
        sin [18] = 'd535826;
        sin [19] = 'd562083;
        sin [20] = 'd587785;
        sin [21] = 'd612907;
        sin [22] = 'd637424;
        sin [23] = 'd661311;
        sin [24] = 'd684547;
        sin [25] = 'd707106;
        sin [26] = 'd728968;
        sin [27] = 'd750111;
        sin [28] = 'd770513;
        sin [29] = 'd790155;
        sin [30] = 'd809017;
        sin [31] = 'd827080;
        sin [32] = 'd844327;
        sin [33] = 'd860742;
        sin [34] = 'd876306;
        sin [35] = 'd891006;
        sin [36] = 'd904827;
        sin [37] = 'd917754;
        sin [38] = 'd929776;
        sin [39] = 'd940880;
        sin [40] = 'd951056;
        sin [41] = 'd960293;
        sin [42] = 'd968583;
        sin [43] = 'd975917;
        sin [44] = 'd982287;
        sin [45] = 'd987688;
        sin [46] = 'd992115;
        sin [47] = 'd995562;
        sin [48] = 'd998027;
        sin [49] = 'd999507;
        sin [50] = 'd1000000;
        sin [51] = 'd999507;
        sin [52] = 'd998027;
        sin [53] = 'd995562;
        sin [54] = 'd992115;
        sin [55] = 'd987689;
        sin [56] = 'd982288;
        sin [57] = 'd975917;
        sin [58] = 'd968584;
        sin [59] = 'd960294;
        sin [60] = 'd951057;
        sin [61] = 'd940881;
        sin [62] = 'd929777;
        sin [63] = 'd917755;
        sin [64] = 'd904828;
        sin [65] = 'd891007;
        sin [66] = 'd876308;
        sin [67] = 'd860743;
        sin [68] = 'd844329;
        sin [69] = 'd827082;
        sin [70] = 'd809018;
        sin [71] = 'd790156;
        sin [72] = 'd770514;
        sin [73] = 'd750112;
        sin [74] = 'd728970;
        sin [75] = 'd707108;
        sin [76] = 'd684549;
        sin [77] = 'd661313;
        sin [78] = 'd637426;
        sin [79] = 'd612909;
        sin [80] = 'd587787;
        sin [81] = 'd562085;
        sin [82] = 'd535829;
        sin [83] = 'd509043;
        sin [84] = 'd481756;
        sin [85] = 'd453993;
        sin [86] = 'd425781;
        sin [87] = 'd397150;
        sin [88] = 'd368127;
        sin [89] = 'd338740;
        sin [90] = 'd309019;
        sin [91] = 'd278993;
        sin [92] = 'd248692;
        sin [93] = 'd218146;
        sin [94] = 'd187384;
        sin [95] = 'd156437;
        sin [96] = 'd125336;
        sin [97] = 'd94111;
        sin [98] = 'd62793;
        sin [99] = 'd31413;

    end
    
    always@ (posedge ClockVARSIN)
    begin
        data_out <= sin[i];
        i <= i+ 1;
        if(i == 99) begin i <= 0; end
    end

wire [31:0]temp = data_out * Amplitude;
wire [31:0] tophalf = (temp/'d1000000) + 'd2047;
wire [31:0] btmhalf = 'd2047 - (temp/'d1000000);
reg [31:0] waveSintemp;
reg [31:0] COUNT = 0;

always @(posedge ClockVARSIN) begin
    COUNT <= COUNT + 1;
    if(COUNT == 199) begin COUNT <= 0; end
    
    if(COUNT < 100) begin 
        waveSintemp <= tophalf; 
    end
    if(COUNT >= 100 && COUNT < 200) begin
        waveSintemp <= btmhalf;
    end
end
assign waveSin = waveSintemp;
endmodule