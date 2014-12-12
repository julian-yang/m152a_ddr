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
wire display;
wire combo_en;
wire [13:0] score;
wire [13:0] comboCount;

wire [RANDOM_BITS:0] randomNum;
wire [NUM_ARROWS_BITS:0] randomArrow;
wire [STATE_BITS:0] state;
wire [NUM_ARROWS_BITS:0] curArrow0;
wire [NUM_ARROWS_BITS:0] curArrow1;
wire [NUM_ARROWS_BITS:0] curArrow2;
wire [NUM_ARROWS_BITS:0] curArrow3;
wire correctHit;
wire incorrectHit;
wire [3:0] multiplier;
wire partialArrow;

clock clkModule ( .clk(clk), .state(state), .oneHz_CLK(oneHz), .display_CLK(display));
stateGenerator stateModule (.output_state(state), .display_combo_en(combo_en), .clk(clk), .pauseSwitch(sw[0]), .btnR(btnR), .btnL(btnL));
random randomModule(.clk(oneHz), .sw(sw[7:1]), .random_num(randomNum), .random_arrow(randomArrow), .state(state));
score scoreModule (.clk(clk), .state(state), .multiplier(multiplier), .comboCount(comboCount), .score(score), .correctHit(correctHit), .incorrectHit(incorrectHit));
arrow arrowModule(.state(state), .clk(clk), .metronome_clk(oneHz), .next_arrow(randomArrow), .arrow0(curArrow0), .arrow1(curArrow1), .arrow2(curArrow2), .arrow3(curArrow3));

display displayModule (.seg(seg), .an(an), .clk(display), .metronome_clk(oneHz), .state(state),  .cur_arrow0(curArrow0), .cur_arrow1(curArrow1), .cur_arrow2(curArrow2), .cur_arrow3(curArrow3), .score(score), .comboCount(comboCount), .combo_enable(combo_en));
collision collisionModule(.partialArrow(partialArrow), .clk(clk), .state(state), .metronome_clk(oneHz), .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR), .arrow(curArrow3), .correctHit(correctHit), .incorrectHit(incorrectHit));
//assign randomArrow = 15;
//assign score = randomNum;
//assign comboCount = 24;

assign led[7] = multiplier[3];
assign led[6] = multiplier[2];
assign led[5] = multiplier[1];
assign led[4] = multiplier[0];
assign led[3] = correctHit;
assign led[2] = incorrectHit;
assign led[1] = state[1];
assign led[0] = state[0];


//assign an = 4'b0000;
//assign seg[6:0] = 7'b1000000;


endmodule
