`timescale 1ns / 1ps
`include "ddr_definitions.v"
module display(
	// outputs
	seg, an,
	// inputs
	clk, state, next_arrow, score, comboCount, combo_enable /*todo find right var name */ );
	
input clk;
input [STATE_BITS:0] state;
input [4:0] next_arrow;
input [13:0] score;
input [13:0] comboCount;
input combo_enable;
reg [3:0] num0;
reg [3:0] num1;
reg [3:0] num2;
reg [3:0] num3;

output [6:0] seg;
output [3:0] an;

reg [1:0] numTracker; //keep track of what number we're displaying.
reg [3:0] numToDisplay; //copy the digit value to display in here.
reg [3:0] anToDisplay;
reg [6:0] segToDisplay;

reg [6:0] arrow0;
reg [6:0] arrow1;
reg [6:0] arrow2; //store the previous 3 arrows.

always @(posedge clk) begin
    case(state)
        STATE_GAME:
        begin
           	// assign arrows to num's
           	num3 = next_arrow;
           	num2 = arrow2;
           	num1 = arrow1;
           	num0 = arrow0;

           	// store previous arrows
           	arrow0 = arrow1;
           	arrow1 = arrow2;
           	arrow2 = next_arrow;
        end
        STATE_PAUSE:
        begin
            if (combo_enable)
            begin
            // display combo count
	            num0 = comboCount / 1000;
	            num1 = (comboCount % 1000) / 100;
	            num2 = (comboCount % 100) / 10;
	            num3 = comboCount % 10;
            end
            else
            begin
            //calculate score
	            num0 = score / 1000;
	            num1 = (score % 1000) / 100;
	            num2 = (score % 100) / 10;
	            num3 = score % 10;
            end
            // convert nums to binary count
        end
    endcase


	numTracker = numTracker + 1;
	case(numTracker)
		0: begin
			anToDisplay = 4'b0111;
			numToDisplay = num0;
            
		end
		1: begin
			anToDisplay = 4'b1011;
			numToDisplay = num1;
		end
		2: begin
			anToDisplay = 4'b1101;
			numToDisplay = num2;
		end
		3: begin
			anToDisplay = 4'b1110;
			numToDisplay = num3;
		end
	endcase
    
end

assign seg = segToDisplay;
assign an = anToDisplay;
	
endmodule