
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
// game states
parameter STATE_GAME = 0,
parameter STATE_PAUSE = 1,
parameter STATE_RESET = 2,
parameter STATE_BITS = 1,

// random settings
parameter RANDOM_BITS = 6,


// arrows (there are 11)
parameter NUM_ARROWS = 11,
parameter NUM_ARROWS_BITS = 4,
parameter ARROW_UP = 10,
parameter ARROW_DOWN = 11,
parameter ARROW_LEFT = 12,
parameter ARROW_RIGHT = 13,
parameter ARROW_UP_DOWN = 14,
parameter ARROW_UP_LEFT = 15,
parameter ARROW_UP_RIGHT = 16,
parameter ARROW_DOWN_LEFT = 17,
parameter ARROW_DOWN_RIGHT = 18,
parameter ARROW_LEFT_RIGHT = 19,
parameter ARROW_NONE = 20,




//Segment settings
// arrows to be displayed
parameter SEG_ARROW_UP = 7'b1111110,
parameter SEG_ARROW_DOWN = 7'b1110111,
parameter SEG_ARROW_LEFT = 7'b1001111,
parameter SEG_ARROW_RIGHT = 7'b1111001,
parameter SEG_ARROW_UP_DOWN = SEG_ARROW_UP & SEG_ARROW_DOWN,
parameter SEG_ARROW_UP_LEFT = SEG_ARROW_UP & SEG_ARROW_LEFT,
parameter SEG_ARROW_UP_RIGHT = SEG_ARROW_UP & SEG_ARROW_RIGHT,
parameter SEG_ARROW_DOWN_LEFT = SEG_ARROW_DOWN & SEG_ARROW_LEFT,
parameter SEG_ARROW_DOWN_RIGHT = SEG_ARROW_DOWN & SEG_ARROW_RIGHT,
parameter SEG_ARROW_LEFT_RIGHT = SEG_ARROW_LEFT & SEG_ARROW_RIGHT,
parameter SEG_ARROW_NONE = 7'b1111111,
// numbers to be displayed
parameter SEG_ZERO = 7'b1000000, //A,B,C,D,E,F
parameter SEG_ONE = 7'b1111001, //B,C
parameter SEG_TWO = 7'b0100100, //A,B,D,E,G
parameter SEG_THREE = 7'b0110000, //A,B,C,D,G
parameter SEG_FOUR = 7'b0011001, //B,C,F,G
parameter SEG_FIVE = 7'b0010010, //A,C,D,F,G
parameter SEG_SIX = 7'b0000010, //A,C,D,E,F,G
parameter SEG_SEVEN = 7'b1111000, //A,B,C
parameter SEG_EIGHT = 7'b0000000, //A,B,C,D,E,F,G
parameter SEG_NINE = 7'b0011000 //A,B,C,F,G
