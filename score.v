`timescale 1ns / 1ps 

module score(
    // inputs
    clk, correctHit, incorrectHit, state,
    // outputs
    score, comboCount);
`include "ddr_definitions.v"

input clk;
input oneHz_CLK;
input twoHz_CLK;
input blink_CLK;
input [STATE_BITS:0] state;

output [13:0] score;

reg [13:0] score_reg = 0;
reg [3:0] multiplier = 1;
reg [13:0] combos = 0;

reg [3:0] reg_num0;
reg [3:0] reg_num1;
reg [3:0] reg_num2;
reg [3:0] reg_num3;

reg is_paused = 0;

always @(posedge clk) begin

    if (correctHit) begin
        if (combos >= 15)
            multiplier = 8;
        else if (combos >= 10)
            multiplier = 4;
        else if (combos >= 4)
            multiplier = 2;
        else
            multiplier = 1;
    end
    
    if (incorrectHit) begin
        multiplier = 1;   
        combos = 0;
    end
    

    case(state)
        STATE_RESET: begin //reset mode
            score_reg = 0;
        end
        STATE_PAUSE: begin //pause mode 
            //is_paused = 1; //activate paused mode.
        end
        STATE_GAME: begin //adjust minutes mode 
            score_reg = score_reg + correctHit * multiplier;
            combos = combos + correctHit;
        end
    endcase
	
end

assign score = score_reg;
assign comboCount = combos;

endmodule

