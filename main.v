`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:08 11/25/2014 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main
#(`include "ddr_definitions.v")
( 
                        // inputs 
						clk, btnU, btnD, btnL, btnR, sw, 
						// outputs
						led, seg, an
    );

input clk;
input btnU;
input btnD;
input btnL;
input btnR;
input [7:0] sw;
output [7:0] led;
output [6:0] seg;
output [3:0] an;
reg reset;
wire oneHz;
wire twoHz;
wire fourHz; //4Hz
wire display;
wire combo_en;
wire [13:0] score;
wire [13:0] comboCount;

wire [RANDOM_BITS:0] randomNum;
wire [NUM_ARROWS_BITS:0] randomArrow;
wire [STATE_BITS:0] state;
wire [NUM_ARROWS_BITS:0] curArrow;
wire correctHit;
wire incorrectHit;

clock clkModule ( .clk(clk), .state(state), .twoHz_CLK(twoHz), .oneHz_CLK(oneHz), .fourHz_CLK(fourHz), .display_CLK(display));
stateGenerator stateModule (.output_state(state), .display_combo_en(combo_en), .clk(clk), .pauseSwitch(sw[0]), .btnR(btnR), .btnL(btnL));
random randomModule(.clk(oneHz), .sw(sw[7:1]), .random_num(randomNum), .random_arrow(randomArrow), .state(state));
//score scoreModule (.clk(clk), .oneHz_CLK(oneHz), .twoHz_CLK(twoHz), .blink_CLK(blink), .state(state), .num0(num0), .num1(num1), .num2(num2), .num3(num3), .isBlink(isBlink));
display displayModule (.seg(seg), .an(an), .clk(display), .metronome_clk(oneHz), .state(state), .next_arrow(randomArrow), .comboCount(comboCount), .combo_enable(combo_en), .score(score), .cur_arrow(curArrow));
collision collisionModule(.clk(clk), .metronome_clk(twoHz), .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .arrow(curArrow), .correctHit(correctHit), .incorrectHit(incorrectHit));
//assign randomArrow = 15;
assign score = randomNum;
assign comboCount = 24;

assign led[7] = 0;
assign led[6] = 0;
assign led[5] = 0;
assign led[4] = 0;
assign led[3] = correctHit;
assign led[2] = incorrectHit;
assign led[1] = state[1];
assign led[0] = state[0];


//assign an = 4'b0000;
//assign seg[6:0] = 7'b1000000;


endmodule
