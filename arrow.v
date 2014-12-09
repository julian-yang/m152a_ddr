`timescale 1ns / 1ps

module arrow
#(`include "ddr_definitions.v")
(
    // outputs
    arrow0, arrow1, arrow2, arrow3,
    // inputs
    clk, metronome_clk, next_arrow, state);

input clk;
input metronome_clk;
input [NUM_ARROWS_BITS:0] next_arrow;
input [STATE_BITS:0] state;
output [NUM_ARROWS_BITS:0] arrow0;
output [NUM_ARROWS_BITS:0] arrow1;
output [NUM_ARROWS_BITS:0] arrow2;
output [NUM_ARROWS_BITS:0] arrow3;

reg [NUM_ARROWS_BITS:0] arrow0_reg = ARROW_NONE;
reg [NUM_ARROWS_BITS:0] arrow1_reg = ARROW_NONE;
reg [NUM_ARROWS_BITS:0] arrow2_reg = ARROW_NONE;
reg [NUM_ARROWS_BITS:0] arrow3_reg = ARROW_NONE;

// =====================
// Posedge Metronome_clk
// =====================
reg [2:0] posedge_metronome_clk = 0;
reg is_posedge_metronome_clk = 0;
    
always @ (posedge clk) begin
    posedge_metronome_clk <= {metronome_clk, posedge_metronome_clk[2:1]};
    
    is_posedge_metronome_clk <= ~posedge_metronome_clk[0] & posedge_metronome_clk[1];
end


// this module buffers the current arrows and passes them into the 
// display and collision modules

// note that arrows_reg[3] is the one that the user should be hitting
always @ (posedge clk) begin
    case(state) 
        STATE_GAME: begin
            if(is_posedge_metronome_clk) begin
            arrow3_reg = arrow2_reg;
            arrow2_reg = arrow1_reg;
            arrow1_reg = arrow0_reg;
            arrow0_reg = next_arrow;
            end
        end
        STATE_RESET: begin
            arrow3_reg = ARROW_NONE;
            arrow2_reg = ARROW_NONE;
            arrow1_reg = ARROW_NONE;
            arrow0_reg = ARROW_NONE;
        end
    endcase
end

assign arrow0 = arrow0_reg;
assign arrow1 = arrow1_reg;
assign arrow2 = arrow2_reg;
assign arrow3 = arrow3_reg;

endmodule
