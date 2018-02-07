`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:29:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    Key_Synchronizer_Bank
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Key Synchronizer Bank
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module Key_Synchronizer_Bank
#(
	parameter KEY_SYNC_CHANNELS = 1,
	parameter CLK_RATE_HZ = 50000000, // Hz
	parameter KEY_LOCK_DELAY = 800000000 // 800 mS
)
(
	// Input Signals
	input  [KEY_SYNC_CHANNELS-1:0] KEY,
	
	// Output Signals
	output [KEY_SYNC_CHANNELS-1:0] KEY_EVENT,
	
	// System Signals
	input CLK
);

	//
	// Key Input Synchronizers
	//
	genvar i;
	
	generate
	begin
	
		for (i = 0; i < KEY_SYNC_CHANNELS; i=i+1)
		begin : key_sync_gen
		
			Key_Synchronizer_Module
			#(
				.CLK_RATE_HZ( CLK_RATE_HZ ),
				.KEY_LOCK_DELAY( KEY_LOCK_DELAY )
			)
			key_synchronizer
			(
				// Input Signals
				.KEY( KEY[i] ),
				
				// Output Signals
				.KEY_EVENT( KEY_EVENT[i] ),
				
				// System Signals
				.CLK( CLK )
			);
		
		end
		
	end
	endgenerate

endmodule
