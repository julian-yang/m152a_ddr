`timescale 1ns / 1ps

module arrow
#(`include "ddr_definitions.v")
(
    // outputs
    arrows,
    // inputs
    clk, next_arrow);

input metronome_clk;
input [NUM_ARROWS_BITS:0] next_arrow;

output [NUM_ARROWS_BITS:0] cur_arrows [3:0];

reg [NUM_ARROWS_BITS:0] arrows_reg [3:0];

// this module buffers the current arrows and passes them into the 
// display and collision modules

// note that arrows_reg[3] is the one that the user should be hitting
always @ (posedge clk) begin
    arrows_reg[3:1] = arrows_reg[2:0];
    arrows_reg[0] = next_arrow;
end

assign arrows = arrows_reg;

