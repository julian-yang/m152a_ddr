`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:45 11/25/2014 
// Design Name: 
// Module Name:    random 
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
module random(
    //input 
    clk, sw,
    //output
    random_num,
    random_arrow
    );
//note feed in the metronome clk here.
`include "ddr_definitions.v"

input clk;
input [5:0] sw;
output [5:0] random_num [3:0];
output [3:0] random_arrow [3:0];

reg [5:0] random_reg = sw;
reg [5:0] random_num_array;
reg [3:0] random_arrow_array [3:0];

always @ (posedge clk)
begin
    //generate new number
    newBit = random_num[5] + random_reg[1] + 1;
    random_reg = {6{newbit, random_reg[5:1]}};

    //shift over new number in our number trackers
    random_num_array[2:0] = random_num_array[3:1];
    random_num_array[3] = random_reg; 

    random_arrow_array[2:0] = random_arrow_array[3:1];
    random_arrow_array[3] = random_reg % NUM_ARROWS;
end

assign random_num = random_num_array;
assign random_arrow = random_arrow_array;

endmodule
