`timescale 1ns / 1ps

module myDAC_TOP(
input CLK,
input btnU, btnD, btnL, btnR, btnC,
input [4:0] step_sel,
input CH1_sel, CH2_sel, FREQ_sel, DCYCLE_sel, VMAX, VMIN, VOLT_BIT, AMP_sel, DC_override, ARB_sel, reset,
output [3:0] JA,
output [6:0] seg, 
output dp, 
output [3:0] an,
output [15:0] led,
output [3:0] VGA_RED,
output [3:0] VGA_GREEN,
output [3:0] VGA_BLUE,
output VGA_HS, VGA_VS
   );

wire HALF_CLOCK, SAMP_CLOCK, clock40A, clockVARSQA, clockVARTRIA, clockVARSINA, clock1;
wire HALF_CLOCKB, SAMP_CLOCKB, clock40B, clockVARSQB, clockVARTRIB, clockVARSINB;
wire Up, Down, Left, Right, Center;
wire [11:0] DATA_A, DATA_B, waveDCA, waveDCB, waveSquareA, waveSquareB, waveTriangleA, waveTriangleB, waveSinA, waveSinB, waveAM, waveArb, VmaxA, VmaxB, VminA, VminB,  ampBitA, ampBitB; //12 bits 0-4095
wire [13:0] step; //14 bits 0-10000
wire [15:0] user_freqA, user_freqB; //16 bits 0-50000
wire [6:0] duty_cycleA, duty_cycleB; //6 bits 0-100
wire [2:0] waveFlagA, waveFlagB;
    
//Clock Divider
clock_divider CLOCKA (CLK, user_freqA, clockVARSQA, clockVARTRIA, clockVARSINA, HALF_CLOCK, SAMP_CLOCK, clock40);
clock_divider CLOCKB (CLK, user_freqB, clockVARSQB, clockVARTRIB, clockVARSINB, HALF_CLOCKB, SAMP_CLOCKB, clock40B);
clk_divider clk1 (CLK, clock1);
frequency_selector getFreq (clock40, Up, Down, Center, reset, FREQ_sel, CH1_sel, CH2_sel, step, user_freqA, user_freqB);

//Debouncing
single_pulse DB1(clock40, btnU, Up);
single_pulse DB2(clock40, btnD, Down);
single_pulse DB3(clock40, btnL, Left);
single_pulse DB4(clock40, btnR, Right);
single_pulse DB5(clock40, btnC, Center);

//Voltage Control
step_selector selStep(clock40, FREQ_sel, VOLT_BIT, step_sel, step);    
step_calc moveStep(clock40, Up, Down, Center, reset, VMAX, VMIN, AMP_sel, CH1_sel, CH2_sel, step, VmaxA, VminA, VmaxB, VminB);

//Duty Cycle Adjustment
duty_cycle_control adjDCycle (clock40, Up, Down, Center, reset, DCYCLE_sel, CH1_sel, CH2_sel, step, duty_cycleA, duty_cycleB);

//Signal Generation
dc_gen DCA (VmaxA, waveDCA);
dc_gen DCB (VmaxA, waveDCB);
square_gen SQUAREA (clockVARSQA, VmaxA, VminA, duty_cycleA, waveSquareA);
square_gen SQUAREB (clockVARSQB, VmaxB, VminB, duty_cycleB, waveSquareB);
triangle_gen TRIANGLEA (clockVARTRIA, VmaxA, VminA, duty_cycleA, waveTriangleA);
triangle_gen TRIANGLEB (clockVARTRIB, VmaxB, VminB, duty_cycleB, waveTriangleB);
sine_gen SINEA (clockVARSINA, VmaxA, VminA, waveSinA);
sine_gen SINEB (clockVARSINB, VmaxB, VminB, waveSinB);
am_gen AM (waveSinA, waveSinB, VmaxA, VminA, VmaxB, VminB, waveAM);
arb_gen ARB(waveDCA, waveDCB, waveSquareA, waveSquareB, waveTriangleA, waveTriangleB, waveSinA, waveSinB, waveAM, waveFlagA, waveFlagB, waveArb);

//Signal Selection
signal_selector selSignal(clock40, HALF_CLOCK, CH1_sel, CH2_sel, DC_override, reset, Left, Right, Up, Down, Center, FREQ_sel, DCYCLE_sel, VMAX, VMIN, AMP_sel, ARB_sel, waveDCA, waveDCB, waveSquareA, waveSquareB, waveTriangleA, waveTriangleB, waveSinA, waveSinB, waveAM, waveArb, DATA_A, DATA_B, waveFlagA, waveFlagB);

//Displays
//7 Segment Display
display_selector selDisplay (CLK, SAMP_CLOCK, clock1, CH1_sel, CH2_sel, FREQ_sel, DCYCLE_sel, VMAX, VMIN, VOLT_BIT, AMP_sel, DC_override, VmaxA, VmaxB, VminA, VminB, user_freqA, user_freqB, duty_cycleA, duty_cycleB, dp, an, seg);
//LED Display
display_led selLED (clock40, CH1_sel, CH2_sel, FREQ_sel, DCYCLE_sel, VMAX, VMIN, waveFlagA, waveFlagB, user_freqB, duty_cycleB, VmaxB, VminB, VminA, led);

//--------------------------------------------------------------------------------------------------------------------

DA2RefComp u1(
    //SIGNALS PROVIDED TO DA2RefComp
    .CLK(HALF_CLOCK), 
    .START(SAMP_CLOCK), 
    .DATA1(DATA_A), 
    .DATA2(DATA_B), 
    .RST(), 
        
    //DO NOT CHANGE THE FOLLOWING LINES
    .D1(JA[1]), 
    .D2(JA[2]), 
    .CLK_OUT(JA[3]), 
    .nSYNC(JA[0]), 
    .DONE(LED)
    );

endmodule