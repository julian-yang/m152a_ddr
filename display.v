`timescale 1ns / 1ps
module display(
	// outputs
	seg, an,
	// inputs
	clk, state, arrow, score, comboCount, combo_enable /*todo find right var name */ );
	
input clk;
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

//store the previous 3 arrows.




assign seg = segToDisplay;
assign an = anToDisplay;

always @(posedge clk) begin
    case(state)
        game
            //assign arrows to num's
        pause
            if  comboenable_i
                display combo count
            else {
            //calculate score
            num0 = score / 1000;
            num1 = (score % 1000) / 100;
            num2 = (score % 100) / 10;
            num3 = score % 10;
            convert score Num's to binary seg version
            }


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
	
    //TODO: move this to ddr_definitions.v
    // SEG_ONE.. SEG_NINE
	case(numToDisplay)
		0: segToDisplay[6:0] = 7'b1000000; //A,B,C,D,E,F
		1: segToDisplay[6:0] = 7'b1111001; //B,C
		
		2: segToDisplay[6:0] = 7'b0100100; //A,B,D,E,G //0100100
		
		3: segToDisplay[6:0] = 7'b0110000; //A,B,C,D,G //0110000
		
		4: segToDisplay[6:0] = 7'b0011001; //B,C,F,G //0011001
		5: segToDisplay[6:0] = 7'b0010010; //A,C,D,F,G //0100010
		6: segToDisplay[6:0] = 7'b0000010; //A,C,D,E,F,G
		7: segToDisplay[6:0] = 7'b1111000; //A,B,C
		8: segToDisplay[6:0] = 7'b0000000; //A,B,C,D,E,F,G
		9: segToDisplay[6:0] = 7'b0011000; //A,B,C,F,G
		10: segToDisplay[6:0] = 7'b1111111; //10 means nothing is lit up.
		
	endcase
    
end
	
endmodule