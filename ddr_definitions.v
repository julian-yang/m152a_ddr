
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:24 11/25/2014 
// Design Name: 
// Module Name:    ddr_definitions 
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
parameter STATE_GAME = 0;
parameter STATE_PAUSE = 1;
parameter STATE_RESET = 2;
parameter STATE_BITS = 1;


parameter ARROW_UP = 0;
parameter ARROW_DOWN = 1;
parameter ARROW_LEFT = 2;
parameter ARROW_RIGHT = 3;
parameter ARROW_UP_DOWN = 4;
parameter ARROW_UP_LEFT = 5;
parameter ARROW_UP_RIGHT = 6;
parameter ARROW_DOWN_LEFT = 7;
parameter ARROW_DOWN_RIGHT = 8;
parameter ARROW_LEFT_RIGHT = 9;

parameter SEG_ARROW_UP = 7'b0000001;
parameter SEG_ARROW_DOWN = 7'b0001000;
parameter SEG_ARROW_LEFT = 7'b0110000;
parameter SEG_ARROW_RIGHT = 7'b0000110;
parameter SEG_ARROW_UP_DOWN = SEG_ARROW_UP | SEG_ARROW_DOWN;
parameter SEG_ARROW_UP_LEFT = SEG_ARROW_UP | SEG_ARROW_LEFT;
parameter SEG_ARROW_UP_RIGHT = SEG_ARROW_UP | SEG_ARROW_RIGHT;
parameter SEG_ARROW_DOWN_LEFT = SEG_ARROW_DOWN | SEG_ARROW_LEFT;
parameter SEG_ARROW_DOWN_RIGHT = SEG_ARROW_DOWN | SEG_ARROW_RIGHT;
parameter SEG_ARROW_LEFT_RIGHT = SEG_ARROW_LEFT | SEG_ARROW_RIGHT;
