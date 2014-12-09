`timescale 1ns / 1ps

module display
#(`include "ddr_definitions.v")
(
	// outputs
	seg, an,
	// inputs
	clk, metronome_clk, state, cur_arrow0, cur_arrow1, cur_arrow2, cur_arrow3, score, comboCount, combo_enable);
	
input clk;
input metronome_clk;
input [STATE_BITS:0] state;
input [NUM_ARROWS_BITS:0] cur_arrow3;
input [NUM_ARROWS_BITS:0] cur_arrow2;
input [NUM_ARROWS_BITS:0] cur_arrow1;
input [NUM_ARROWS_BITS:0] cur_arrow0;
input [13:0] score;
input [13:0] comboCount;
input combo_enable;
reg [NUM_ARROWS_BITS:0] num0;
reg [NUM_ARROWS_BITS:0] num1;
reg [NUM_ARROWS_BITS:0] num2;
reg [NUM_ARROWS_BITS:0] num3;

output [6:0] seg;
output [3:0] an;

reg [1:0] numTracker; //keep track of what number we're displaying.
reg [NUM_ARROWS_BITS:0] numToDisplay; //copy the digit value to display in here.
reg [3:0] anToDisplay;
reg [6:0] segToDisplay;

// =====================
// Posedge Metronome_clk
// =====================
reg [2:0] posedge_metronome_clk = 0;
reg is_posedge_metronome_clk = 0;
    
always @ (posedge clk) begin
    posedge_metronome_clk = {metronome_clk, posedge_metronome_clk[2:1]};
    
    is_posedge_metronome_clk = ~posedge_metronome_clk[0] & posedge_metronome_clk[1];
end
// end posedge detection


always @(posedge clk) begin
    case(state)
        STATE_GAME: begin
            if(is_posedge_metronome_clk) begin
                // assign arrows to num's
                
                num3 = cur_arrow3; //this is the one that the user should be pressing
                num2 = cur_arrow2;
                num1 = cur_arrow1;
                num0 = cur_arrow0;
            end
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
    
    case(numToDisplay)
        0: segToDisplay = SEG_ZERO;
        1: segToDisplay = SEG_ONE;
        2: segToDisplay = SEG_TWO;
        3: segToDisplay = SEG_THREE;
        4: segToDisplay = SEG_FOUR;
        5: segToDisplay = SEG_FIVE;
        6: segToDisplay = SEG_SIX;
        7: segToDisplay = SEG_SEVEN;
        8: segToDisplay = SEG_EIGHT;
        9: segToDisplay = SEG_NINE;
        10: segToDisplay = SEG_ARROW_UP;
        11: segToDisplay = SEG_ARROW_DOWN;
        12: segToDisplay = SEG_ARROW_LEFT;
        13: segToDisplay = SEG_ARROW_RIGHT;
        14: segToDisplay = SEG_ARROW_UP_DOWN;
        15: segToDisplay = SEG_ARROW_UP_LEFT;
        16: segToDisplay = SEG_ARROW_UP_RIGHT;
        17: segToDisplay = SEG_ARROW_DOWN_LEFT;
        18: segToDisplay = SEG_ARROW_DOWN_RIGHT;
        19: segToDisplay = SEG_ARROW_LEFT_RIGHT;
        20: segToDisplay = SEG_ARROW_NONE;
    endcase
end



assign seg = segToDisplay;
assign an = anToDisplay;
	
endmodule
