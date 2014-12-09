`timescale 1ns / 1ps 

module score
#(`include "ddr_definitions.v")
(
    // inputs
    clk, correctHit, incorrectHit, state,
    // outputs
    score, comboCount, multiplier);


input clk;
input [STATE_BITS:0] state;
input correctHit;
input incorrectHit;

output [13:0] score;
output [13:0] comboCount;
output [3:0] multiplier;

reg [13:0] score_reg = 0;
reg [3:0] multiplier_reg = 1;
reg [13:0] combos = 0;

reg [3:0] reg_num0;
reg [3:0] reg_num1;
reg [3:0] reg_num2;
reg [3:0] reg_num3;

reg is_paused = 0;

// =================
// Asynchronous correctHit
// =================
reg [2:0] posedge_correctHit = 0;
reg is_posedge_correctHit = 0;
    
always @ (posedge clk) begin
    posedge_correctHit <= {correctHit, posedge_correctHit[2:1]};
    
    is_posedge_correctHit <= ~posedge_correctHit[0] & posedge_correctHit[1];
end


// =================
// Asynchronous incorrectHit
// =================
reg [2:0] posedge_incorrectHit = 0;
reg is_posedge_incorrectHit = 0;
    
always @ (posedge clk) begin
    posedge_incorrectHit <= {incorrectHit, posedge_incorrectHit[2:1]};
    
    is_posedge_incorrectHit <= ~posedge_incorrectHit[0] & posedge_incorrectHit[1];
end



always @(posedge clk) begin
    //figure out what the current multiplier should be.
    if (is_posedge_correctHit) begin
        if (combos >= 15)
            multiplier_reg = 8;
        else if (combos >= 10)
            multiplier_reg = 4;
        else if (combos >= 4)
            multiplier_reg = 2;
        else
            multiplier_reg = 1;
    end
    
    //reset multiplier for incorrect hits
    if (is_posedge_incorrectHit) begin
        multiplier_reg = 1;   
        combos = 0;
    end
    

    case(state)
        STATE_RESET: begin //reset mode
            score_reg = 0;
            combos = 0;
            multiplier_reg = 1;
        end
        STATE_GAME: begin 
            score_reg = score_reg + (is_posedge_correctHit * multiplier_reg);
            combos = combos + is_posedge_correctHit;
            
        end
    endcase
	
end

assign score = score_reg;
assign comboCount = combos;
assign multiplier = multiplier_reg;
endmodule

