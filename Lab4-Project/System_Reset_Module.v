`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    00:28:00 01/29/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    System_Reset_Module
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    System Reset Module
//                 Reset output will asynchronously assert and synchronously 
//                   release with the input clock.
//                 Simple counter provides reset delay after power-on.
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module System_Reset_Module
#(
	parameter REF_CLK_RATE_HZ = 50000000, // Hz
	parameter POWER_ON_DELAY = 500  // ns
)
(
	// Input Signals
	input  PLL_LOCKED,  // If not used, set to 1'b1
	input  REF_CLK,
	
	// Output Signals
	output reg RESET
);

	// Include StdFunctions for bit_index()
	`include "StdFunctions.vh"

	
	//
	// Async Set / Sync Release Reset Controller
	//
	// When PLL_LOCKED goes low, reset_reg is cleared to assert the Reset condition.
	//
	// When PLL_LOCKED goes high, the reset_reg double buffer releases the reset
	//   synchronously with the REF_CLK, hopefully avoiding any metastable events.
	//
	reg [1:0] reset_reg;
	
	//
	// Initialize reset_reg in case PLL_LOCKED is not used and hard assigned to 1'b1
	//
	initial
	begin
		reset_reg <= 2'h0;
	end

	//
	// Reset the register chain when PLL_LOCKED goes low.  
	// This in turn causes the RESET output to assert.
	//
	wire sync_reset_n = reset_reg[1];
	
	always @(posedge REF_CLK, negedge PLL_LOCKED)
	begin
		if (!PLL_LOCKED)
			reset_reg <= 2'h0;
		else
			reset_reg <= { reset_reg[0], 1'b1 };
	end
	
	
	//
	// Reset Power-On Delay Counter
	//
	wire reset_done;
	
	generate
	begin
	
		// Create counter for delay if delay is greater than 0. 
		if (POWER_ON_DELAY > 0)
		begin
		
			// Reset Timer Parameter Calculations for the Rollover Counter
			localparam RESET_DELAY_TICKS = POWER_ON_DELAY / (1000000000.0 / REF_CLK_RATE_HZ);
			localparam RESET_COUNT_WIDTH = bit_index(RESET_DELAY_TICKS);
			localparam RESET_COUNT_LOADVAL = {1'b1, {RESET_COUNT_WIDTH{1'b0}}} - RESET_DELAY_TICKS;

			reg  [RESET_COUNT_WIDTH:0] reset_counter;
			
			assign reset_done = reset_counter[RESET_COUNT_WIDTH];	
			
			// Initialize reset_counter incase PLL_LOCKED is not used and hard assigned to 1'b1
			initial
			begin
				reset_counter <= RESET_COUNT_LOADVAL;
			end
			
			// Reset the register chain while PLL_LOCKED is low.
			// Start counting when the Sync Reset is released.
			// Stop counting then the rollover occurs.
			always @(posedge REF_CLK, negedge sync_reset_n)
			begin
				if (!sync_reset_n)
					reset_counter <= RESET_COUNT_LOADVAL;
				else if (~reset_done)
					reset_counter <= reset_counter + 1'b1;
			end
	
		end
		else
		begin
		
			// No Power-On Delay so assert Reset Done immediately
			assign reset_done = 1'b1;
			
		end
		
	end
	endgenerate
	
	
	//
	// Output the Delayed Reset Signal
	//
	always @(posedge REF_CLK, negedge sync_reset_n)
	begin
		if (!sync_reset_n)
			RESET <= 1'b1;
		else if (reset_done)
			RESET <= 1'b0;
	end
	
endmodule
