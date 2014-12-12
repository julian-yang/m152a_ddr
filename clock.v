`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:59 11/13/2014 
// Design Name: 
// Module Name:    clk 
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
module clock 
#(`include "ddr_definitions.v")
(  // Input
                    clk, state,
					 // Output
                    oneHz_CLK,
                    display_CLK
						  );
input clk;
input [1:0] state;

output oneHz_CLK;
output display_CLK;



//reg clk; // 128Hz clk
// clk is 100,000,000Hz
//always #781250 clk = ~clk;

wire [8:0]  oneHz_counter;
reg [7:0]   oneHz_dv;

reg         oneHz_en;   // 1Hz
reg         display_en; // 128Hz, might be 256???

wire [21:0] display_counter;
reg [20:0] display_dv;


assign display_counter = display_dv + 1;
assign oneHz_counter = oneHz_dv + 1;

always @ (posedge clk)
    if (state == STATE_RESET)
		begin
			display_dv <= 0;
			oneHz_dv <= 0;

			oneHz_en <= 0;
			display_en <= 0;				
        end
    else //if(state == STATE_GAME)
		begin
			// do divider for 128hz
			if(display_dv == 390625) //390625
				begin
					display_en <= 1;
					display_dv <= 0;
				end
			else
				begin
					display_en <= 0;
					display_dv <= display_counter[20:0];
				end
			
			if(display_en)
				begin
					oneHz_dv <= oneHz_counter[7:0];
					oneHz_en <= ~oneHz_counter[8]; // Count to 128
				end
		end

assign oneHz_CLK = oneHz_en;
assign display_CLK = display_en;



endmodule