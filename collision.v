`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:12 11/25/2014 
// Design Name: 
// Module Name:    collision 
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
module collision
#(`include "ddr_definitions.v")
(
	// input
	clk, metronome_clk, btnU, btnD, btnL, btnR, arrow, state,
	// output
	correctHit, incorrectHit, partialArrow
);



input clk;
input metronome_clk;
input btnU;
input btnD;
input btnL;
input btnR;
input [STATE_BITS:0] state;
input [NUM_ARROWS_BITS:0] arrow;
output correctHit;
output incorrectHit;
output partialArrow;


//set up async presses

// =================
// Asynchronous Up
// =================
reg [2:0] posedge_up = 0;
reg is_posedge_up = 0;
    
always @ (posedge clk) begin
    posedge_up <= {btnU, posedge_up[2:1]};
    
    is_posedge_up <= ~posedge_up[0] & posedge_up[1];
end

// =================
// Asynchronous Down
// =================
reg [2:0] posedge_down = 0;
reg is_posedge_down = 0;
    
always @ (posedge clk) begin
    posedge_down <= {btnD, posedge_down[2:1]};
    
    is_posedge_down <= ~posedge_down[0] & posedge_down[1];
end

// =================
// Asynchronous Left
// =================
reg [2:0] posedge_left = 0;
reg is_posedge_left = 0;
    
always @ (posedge clk) begin
    posedge_left <= {btnL, posedge_left[2:1]};
    
    is_posedge_left <= ~posedge_left[0] & posedge_left[1];
end

// =================
// Asynchronous Right
// =================
reg [2:0] posedge_right = 0;
reg is_posedge_right = 0;
    
always @ (posedge clk) begin
    posedge_right <= {btnR, posedge_right[2:1]};
    
    is_posedge_right <= ~posedge_right[0] & posedge_right[1];
end

// =====================
// Posedge Metronome_clk
// =====================
reg [2:0] posedge_metronome_clk = 0;
reg is_posedge_metronome_clk = 0;
    
always @ (posedge clk) begin
    posedge_metronome_clk <= {metronome_clk, posedge_metronome_clk[2:1]};
    
    is_posedge_metronome_clk <= ~posedge_metronome_clk[0] & posedge_metronome_clk[1];
end

// end detectors


reg hasPressedPartialArrow = 0;
reg [NUM_ARROWS_BITS:0] keysPressed = ARROW_NONE;
reg correctHit_reg = 0;
reg incorrectHit_reg = 0;

always @(posedge clk) begin
    //reset correctHit_reg && incorrectHit_reg on posedge metronome_clk
    if(is_posedge_metronome_clk) begin
        correctHit_reg = 0;
        incorrectHit_reg = 0;
		keysPressed = ARROW_NONE;
        hasPressedPartialArrow = 0;
    end
    if(state == STATE_GAME) begin
        //if user still has chance to score points on this arrow
        if(metronome_clk && !correctHit_reg && !incorrectHit_reg) begin
            //record key presses so far
            //takes care of incorrect hits for impossible combinations
            if(is_posedge_up) begin
                case(keysPressed) 
                    ARROW_NONE: keysPressed = ARROW_UP;
                    ARROW_LEFT: keysPressed = ARROW_UP_LEFT;
                    ARROW_RIGHT: keysPressed = ARROW_UP_RIGHT;
                    ARROW_DOWN: keysPressed = ARROW_UP_DOWN;
                    default: incorrectHit_reg = 1;
                endcase
            end
            if(is_posedge_down) begin
                case(keysPressed) 
                    ARROW_NONE: keysPressed = ARROW_DOWN;
                    ARROW_LEFT: keysPressed = ARROW_DOWN_LEFT;
                    ARROW_RIGHT: keysPressed = ARROW_DOWN_RIGHT;
                    ARROW_UP: keysPressed = ARROW_UP_DOWN;
                    default: incorrectHit_reg = 1;
                endcase
            end
            if(is_posedge_left) begin
                case(keysPressed) 
                    ARROW_NONE: keysPressed = ARROW_LEFT;
                    ARROW_RIGHT: keysPressed = ARROW_LEFT_RIGHT;
                    ARROW_UP: keysPressed = ARROW_UP_LEFT;
                    ARROW_DOWN: keysPressed = ARROW_DOWN_LEFT;
                    default: incorrectHit_reg = 1;
                endcase
            end
            if(is_posedge_right) begin
                case(keysPressed) 
                    ARROW_NONE: keysPressed = ARROW_RIGHT;
                    ARROW_LEFT: keysPressed = ARROW_LEFT_RIGHT;
                    ARROW_UP: keysPressed = ARROW_UP_RIGHT;
                    ARROW_DOWN: keysPressed = ARROW_DOWN_RIGHT;
                    default: incorrectHit_reg = 1;
                endcase
            end

            //check if user has pressed arrows to score points
            //only need to check if user has pressed something
            //TODO: decide if we are going to give points for empty arrow
            if(keysPressed == arrow) begin 
                correctHit_reg = 1;
                hasPressedPartialArrow = 0;
            end
            else if(keysPressed != ARROW_NONE) begin
                case(arrow) 
                    ARROW_UP_DOWN: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_UP || keysPressed == ARROW_DOWN);
                    end
                    ARROW_UP_LEFT: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_UP || keysPressed == ARROW_LEFT);
                    end
                    ARROW_UP_RIGHT: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_UP || keysPressed == ARROW_RIGHT); 
                    end
                    ARROW_DOWN_LEFT: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_DOWN || keysPressed == ARROW_LEFT); 
                    end
                    ARROW_DOWN_RIGHT: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_DOWN || keysPressed == ARROW_RIGHT); 
                    end
                    ARROW_LEFT_RIGHT: begin
                        hasPressedPartialArrow = (keysPressed == ARROW_LEFT || keysPressed == ARROW_RIGHT); 
                    end
                    default:
                        hasPressedPartialArrow = 0;
                endcase

                //at this point, all correct combinations have been filtered out, if
                //user has *partially* pressed a correct combination, it will have 
                //been marked with "hasPressedPartialArrow" (NOTE: this only applies
                //for double arrow combinations.
                
                //NOTE: we also know that the user has pressed something already

                //check for incorrect combinations
                if(!hasPressedPartialArrow && !correctHit_reg)
                    incorrectHit_reg = 1;

            end //end else if(keysPressed != ARROW_NONE) 
        end //end if user has chance to score points
        else if(!metronome_clk) begin
            //if user has pressed keys here, it is automatically an incorrect hit.
            if(is_posedge_up || is_posedge_down || is_posedge_left || is_posedge_right) begin
                incorrectHit_reg = 1;
            end
            // if user has not made a correct hit yet, they missed the arrow.
            if(!incorrectHit_reg && !correctHit_reg) begin
                incorrectHit_reg = 1;
            end
        end
    end //end if game_mode
end

assign correctHit = correctHit_reg;
assign incorrectHit = incorrectHit_reg;
assign partialArrow = hasPressedPartialArrow;
endmodule
