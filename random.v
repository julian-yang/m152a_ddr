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

input clk;
input [5:0] sw;
output [5:0] random_num;
output [4:0] random_arrow;

reg [5:0] random_reg = sw;

always @ (posedge clk)
begin
    newBit = random_num[5] + random_num[1] + 1;
    random_num_reg = {6{newBit,random_num}};
end

assign random_num = random_num_reg;
assign random_arrow = random_num_reg % 10;

endmodule
