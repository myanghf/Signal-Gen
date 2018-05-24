`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2017 09:40:14 PM
// Design Name: 
// Module Name: display_selector
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


module display_selector(
    input CLK, SAMP_CLOCK, clock1, CH1_sel, CH2_sel, FREQ_sel, DCYCLE_sel, VMAX, VMIN, VOLT_BIT, AMP_sel, DC_override, 
    input [11:0] VmaxA, [11:0] VmaxB, [11:0] VminA, [11:0] VminB, [15:0] user_freqA, [15:0] user_freqB, [6:0] duty_cycleA, [6:0] duty_cycleB,
    output reg dp, reg [3:0] an, reg [6:0] seg
);

wire [6:0] segMaxA, segMinA, segFreqA, segDCycleA, segVMaxA, segVMinB, segDashA, segAmpBB, segAmpVA;
wire [6:0] segMaxB, segMinB, segFreqB, segDCycleB, segVMaxB, segVMinA, segDashB, segAmpBA, segAmpVB;
reg [6:0] segStoreA, segStoreB;
wire [3:0] anMaxA, anMinA, anFreqA, anDCycleA, anVMaxA, anVMinA, anDashA, anAmpBA, anAmpVA;
wire [3:0] anMaxB, anMinB, anFreqB, anDCycleB, anVMaxB, anVMinB, anDashB, anAmpBB, anAmpVB;
reg [3:0] anStoreA, anStoreB;
wire dpMaxA, dpMinA, dpFreqA, dpDCycleA, dpVMaxA, dpVMinA, dpDashA, dpAmpBA, dpAmpVA; 
wire dpMaxB, dpMinB, dpFreqB, dpDCycleB, dpVMaxB, dpVMinB, dpDashB, dpAmpBB, dpAmpVB;
reg dpStoreA, dpStoreB;
wire [16:0] maxVoltA, maxVoltB, minVoltA, minVoltB, ampVoltA, ampVoltB;
wire [11:0] ampBitA, amptBitB;
reg toggle;

parser_voltage vParseA (VmaxA, VminA, maxVoltA, minVoltA);
parser_voltage vParseB (VmaxB, VminB, maxVoltB, minVoltB);

amp_calc getAmpA (VmaxA, VminA, maxVoltA, minVoltA, ampBitA, ampVoltA);
amp_calc getAmpB (VmaxB, VminB, maxVoltB, minVoltB, ampBitB, ampVoltB);

sevenseg displayMaxA (CLK, (VmaxA/1000), ((VmaxA%1000)/100), ((VmaxA%100)/10), (VmaxA%10), segMaxA, dpMaxA, anMaxA);
sevenseg displayMinA (CLK, (VminA/1000), ((VminA%1000)/100), ((VminA%100)/10), (VminA%10), segMinA, dpMinA, anMinA);
sevenseg displayAmpBitA (CLK, (ampBitA/1000), ((ampBitA%1000)/100), ((ampBitA%100)/10), (ampBitA%10), segAmpBA , dpAmpBA, anAmpBA);
sevenseg displayMaxB (CLK, (VmaxB/1000), ((VmaxB%1000)/100), ((VmaxB%100)/10), (VmaxB%10), segMaxB, dpMaxB, anMaxB);
sevenseg displayMinB (CLK, (VminB/1000), ((VminB%1000)/100), ((VminB%100)/10), (VminB%10), segMinB, dpMinB, anMinB);
sevenseg displayAmpBitB (CLK, (ampBitB/1000), ((ampBitB%1000)/100), ((ampBitB%100)/10), (ampBitB%10), segAmpBB , dpAmpBB, anAmpBB);

sevenseg_dp displayVMaxA (CLK, (maxVoltA/1000), ((maxVoltA%1000)/100), ((maxVoltA%100)/10), (maxVoltA%10), segVMaxA, dpVMaxA, anVMaxA);
sevenseg_dp displayVMinA (CLK, (minVoltA/1000), ((minVoltA%1000)/100), ((minVoltA%100)/10), (minVoltA%10), segVMinA, dpVMinA, anVMinA);
sevenseg_dp displayAmpVoltA (CLK, (ampVoltA/1000), ((ampVoltA%1000)/100), ((ampVolAt%100)/10), (ampVoltA%10), segAmpVA, dpAmpVA, anAmpVA);

sevenseg_dp displayVMaxB (CLK, (maxVoltB/1000), ((maxVoltB%1000)/100), ((maxVoltB%100)/10), (maxVoltB%10), segVMaxB, dpVMaxB, anVMaxB);
sevenseg_dp displayVMinB (CLK, (minVoltB/1000), ((minVoltB%1000)/100), ((minVoltB%100)/10), (minVoltB%10), segVMinB, dpVMinB, anVMinB);
sevenseg_dp displayAmpVoltB (CLK, (ampVoltB/1000), ((ampVoltB%1000)/100), ((ampVoltB%100)/10), (ampVoltB%10), segAmpVB, dpAmpVB, anAmpVB);

sevenseg_freq displayFreqA (CLK, user_freqA, segFreqA, dpFreqA, anFreqA);
sevenseg_freq displayFreqB (CLK, user_freqB, segFreqB, dpFreqB, anFreqB);

sevenseg displayDCycleA(CLK, (duty_cycleA/1000), ((duty_cycleA%1000)/100), ((duty_cycleA%100)/10), (duty_cycleA%10), segDCycleA, dpDCycleA, anDCycleA);
sevenseg displayDCycleB(CLK, (duty_cycleB/1000), ((duty_cycleB%1000)/100), ((duty_cycleB%100)/10), (duty_cycleB%10), segDCycleB, dpDCycleB, anDCycleB);
sevenseg displayDashA(CLK, 'd10, 'd10, 'd10, 'd10, segDashA, dpDashA, anDashA);
sevenseg displayDashB(CLK, 'd10, 'd10, 'd10, 'd10, segDashB, dpDashB, anDashB);
    
    always @(posedge clock1) begin
        toggle <= ~toggle;
    end
    
    always @(posedge SAMP_CLOCK) begin
            if (!toggle)   begin
                if  (VMAX)   begin 
                    segStoreA <= segMaxA; anStoreA <= anMaxA; dpStoreA <= dpMaxA;
                    segStoreB <= segMaxB; anStoreB <= anMaxB; dpStoreB <= dpMaxB; 
                end
                if  (VMIN)   begin 
                    segStoreA <= segMinA; anStoreA <= anMinA; dpStoreA <= dpMinA; 
                    segStoreB <= segMinB; anStoreB <= anMinB; dpStoreB <= dpMinB;
                end
                if  (AMP_sel)begin 
                    segStoreA <= segAmpBA; anStoreA <= anAmpBA; dpStoreA <= dpAmpBA;
                    segStoreB <= segAmpBB; anStoreB <= anAmpBB; dpStoreB <= dpAmpBB;
                end
            end
            if (toggle)    begin
                if  (VMAX)   begin 
                    segStoreA <= segVMaxA; anStoreA <= anVMaxA; dpStoreA <= dpVMaxA;
                    segStoreB <= segVMaxB; anStoreB <= anVMaxB; dpStoreB <= dpVMaxA;
                end
                if  (VMIN)   begin 
                    segStoreA <= segVMinA; anStoreA <= anVMinA; dpStoreA <= dpVMinA;
                    segStoreB <= segVMinB; anStoreB <= anVMinB; dpStoreB <= dpVMinB;
                end
                if  (AMP_sel)begin 
                    segStoreA <= segAmpVA; anStoreA <= anAmpVA; dpStoreA <= dpAmpVA;
                    segStoreB <= segAmpVB; anStoreB <= anAmpVB; dpStoreB <= dpAmpVB;
                end
            end
            if  (FREQ_sel)   begin 
                segStoreA <= segFreqA; anStoreA <= anFreqA; dpStoreA <= dpFreqA; 
                segStoreB <= segFreqB; anStoreB <= anFreqB; dpStoreB <= dpFreqB;
            end
            if  (DCYCLE_sel) begin
                segStoreA <= segDCycleA; anStoreA <= anDCycleA; dpStoreA <= dpDCycleA;
                segStoreB <= segDCycleB; anStoreB <= anDCycleB; dpStoreB <= dpDCycleB;
            end
            if  (!FREQ_sel && !DCYCLE_sel && !VMAX && !VMIN && !AMP_sel) begin 
                segStoreA <= segDashA; anStoreA <= anDashA; dpStoreA <= dpDashA;
                segStoreB <= segDashB; anStoreB <= anDashB; dpStoreB <= dpDashB;
            end
        
        if(CH1_sel) begin seg <= segStoreA; an <= anStoreA; dp <= dpStoreA; end 
        if(CH2_sel && !CH1_sel) begin seg <= segStoreB; an <= anStoreB; dp <= dpStoreB; end
        if(!CH1_sel && !CH2_sel) begin seg <= segDashA; an <= anDashA; dp <= dpDashA; end
    end



endmodule
