module stateGenerator 
#(`include "ddr_definitions.v")
(
	// Outputs
	output_state, display_combo_en,
	// Inputs
	btnR, clk, btnL, pauseSwitch
	);

output [STATE_BITS:0] output_state;
output display_combo_en;

input btnR; //reset
input btnL; //display combo
input pauseSwitch; //pause

input clk;


reg [STATE_BITS:0] state = STATE_RESET;
reg is_paused = 0;
reg display_combo_reg = 0;
// ===============
// Asynchronous Reset
// =================
wire 			rst;
wire			arst_i;
reg [1:0]	arst_ff;

assign arst_i = btnR;
assign rst = arst_ff[0];

always @ (posedge clk or posedge arst_i)
	if (arst_i)
		arst_ff <= 2'b11;
	else 
		arst_ff <= {1'b0, arst_ff[1]};

// =================
// END Reset
// =================

// ===============
// Asynchronous Display Combo
// =================
wire 			display_combo_i;
wire			async_displayCombo_i;
reg [1:0]	async_displayCombo_ff;

assign async_displayCombo_i = btnL;
assign display_combo_i = async_displayCombo_ff[0];

always @ (posedge clk or posedge async_displayCombo_i)
	if (async_displayCombo_i)
		async_displayCombo_ff <= 2'b11;
	else 
		async_displayCombo_ff <= {1'b0, async_displayCombo_ff[1]};

// =================
// END Display Combo
// =================





always @ (posedge clk) //reset mode
    begin
        if (pauseSwitch) //if is paused
            begin
                if (rst)
                    state <= STATE_RESET;
                else
                    state <= STATE_PAUSE;
            end
        else//
            begin
                state <= STATE_GAME;
            end
        
        if (pauseSwitch && display_combo_i)
            display_combo_reg <= 1;
        else 
            display_combo_reg <= 0;
    end   
    

		
assign output_state = state;
assign display_combo_en = display_combo_reg;
endmodule 

