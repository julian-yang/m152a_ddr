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
module random
#(`include "ddr_definitions.v")
(
    //input 
    clk, sw, state,
    //output
    random_num,
    random_arrow
    );
//note feed in the metronome clk here.


input clk;
input [STATE_BITS:0] state;
input [RANDOM_BITS:0] sw;
output [RANDOM_BITS:0] random_num;
output [NUM_ARROWS_BITS:0] random_arrow;

reg [RANDOM_BITS:0] random_reg;
reg newBit;
//reg [5:0] random_num_array;
//reg [3:0] random_arrow_array [3:0];

always @ (posedge clk)
begin
    if(state == STATE_RESET)
        random_reg <= 1523;
    else begin
        //generate new number
        newBit <= random_num[RANDOM_BITS] + random_reg[1] + 1;
        random_reg <= {newBit, random_reg[RANDOM_BITS:1]};

        //shift over new number in our number trackers
        //random_num_array[2:0] = random_num_array[3:1];
        //random_num_array[3] = random_reg; 

        //random_arrow_array[2:0] = random_arrow_array[3:1];
        //random_arrow_array[3] = random_reg % NUM_ARROWS;
    end
end


assign random_num = random_reg;
assign random_arrow = (random_reg % 5) + 10;

endmodule
