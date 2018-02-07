`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    00:48:00 01/25/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #3 Project
// Module Name:    Key_Synchronizer_Module
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Key input signal synchronizer to align asynchronous key
//                 press signals to the system clock.  Also, provides a
//                 key lockout so only one key press will be generated per
//                 lockout delay period.
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module Key_Synchronizer_Module
#(
	parameter CLK_RATE_HZ = 50000000, // Hz
	parameter KEY_LOCK_DELAY = 800000000 // nS
)
(
	// Input Signals
	input KEY,
	
	// Output Signals
	output reg KEY_EVENT,
	
	// System Signals
	input CLK
);

	// Include Standard Functions header file (needed for bit_index())
	`include "StdFunctions.vh"
	
	
	//
	// Synchronize Key Input to System Clock
	//
	wire key_sync;
	
	CDC_Input_Synchronizer
	#(
		.SYNC_REG_LEN( 2 )
	)
	key_synchronizer
	(
		// Input Signal
		.ASYNC_IN( KEY ),
		
		// Output Signal
		.SYNC_OUT( key_sync ),
		
		// System Signals
		.CLK( CLK )
	);
	
	
	//
	// Key Lockout Counter
	//
	localparam KEY_LOCK_DELAY_TICKS = (1.0 * KEY_LOCK_DELAY) / (1000000000.0 / CLK_RATE_HZ);
	localparam KEY_LOCK_WIDTH = bit_index(KEY_LOCK_DELAY_TICKS);
	localparam [KEY_LOCK_WIDTH:0] KEY_LOCK_LOADVAL = {1'b1, {(KEY_LOCK_WIDTH-1){1'b0}}, 1'b1} - KEY_LOCK_DELAY_TICKS;
	localparam KEY_LOCK_CLEARVAL = {1'b1, {KEY_LOCK_WIDTH{1'b0}}};

	wire                    key_lock_out;
	reg  [KEY_LOCK_WIDTH:0] key_lock_counter_reg;

	assign key_lock_out = ~key_lock_counter_reg[KEY_LOCK_WIDTH];
	
	initial
	begin
		// Startout with the key lockout disenabled
		key_lock_counter_reg <= KEY_LOCK_CLEARVAL;
		KEY_EVENT <= 1'b0;
	end
		
	always @(posedge CLK)
	begin
		if (~key_lock_out)
		begin
			if (key_sync)
				key_lock_counter_reg <= KEY_LOCK_LOADVAL;
		end
		else
		begin
			if (~key_sync)
				key_lock_counter_reg <= KEY_LOCK_CLEARVAL;
			else
				key_lock_counter_reg <= key_lock_counter_reg + 1'b1;
		end
	end
	
	
	//
	// Key Event Register
	//
	always @(posedge CLK)
	begin
		if (key_sync & ~key_lock_out)
			KEY_EVENT <= 1'b1;
		else
			KEY_EVENT <= 1'b0;
	end

endmodule
