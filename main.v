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
module main( // inputs 
						clk, btnR, btnL, sw, 
						// outputs
						led, seg, an
    );
`include "ddr_definitions.v"
input clk;
input btnR;
input btnL;
input [1:0] sw;
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



wire [STATE_BITS:0] state;

clock clkModule ( .clk(clk), .state(state), .twoHz_CLK(twoHz), .oneHz_CLK(oneHz), .fourHz_CLK(fourHz), .display_CLK(display));
stateGenerator stateModule (.output_state(state), .display_combo_en(combo_en), .clk(clk), .pauseSwitch(sw[0]), .btnR(btnR), .btnL(btnL));
//score scoreModule (.clk(clk), .oneHz_CLK(oneHz), .twoHz_CLK(twoHz), .blink_CLK(blink), .state(state), .num0(num0), .num1(num1), .num2(num2), .num3(num3), .isBlink(isBlink));
//display displayModule (.seg(seg), .an(an), .clk(display), .state(state), .next_arrow(arrow), .comboCount(comboCount), .combo_enable(combo_en));

assign led[7] = oneHz;
assign led[6] = twoHz;
assign led[5] = fourHz;
assign led[4] = combo_en;
assign led[3] = display;
assign led[2] = 0;
assign led[1] = state[1];
assign led[0] = state[0];


assign an = 4'b0000;
assign seg[6:0] = 7'b1000000;


endmodule
