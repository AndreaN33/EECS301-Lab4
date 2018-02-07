`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    23:15:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    Switch_Synchronizer_Bank
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Switch Synchronizer Bank
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module Switch_Synchronizer_Bank
#(
	parameter SWITCH_SYNC_CHANNELS = 1,
	parameter CLK_RATE_HZ = 50000000, // Hz
	parameter DEBOUNCE_TIME = 10000, // ns
	parameter SIG_OUT_INIT = 1'b0
)
(
	// Input  Signals (asynchronous)
	input  [SWITCH_SYNC_CHANNELS-1:0] SIG_IN,
	
	// Output Signals (synchronized to CLK domain)
	output [SWITCH_SYNC_CHANNELS-1:0] SIG_OUT,
	
	// System Signals
	input CLK
);

	//
	// Switch Input Debounce Synchronizers
	//
	genvar i;
	
	generate
	begin
	
		for (i = 0; i < SWITCH_SYNC_CHANNELS; i=i+1)
		begin : sw_sync_gen

			Switch_Debounce_Synchronizer
			#(
				.CLK_RATE_HZ( CLK_RATE_HZ ),
				.DEBOUNCE_TIME( DEBOUNCE_TIME ),
				.SIG_OUT_INIT( SIG_OUT_INIT )
			)
			sw_synchronizer
			(
				// Input  Signals (asynchronous)
				.SIG_IN( SIG_IN[i] ),
				
				// Output Signals (synchronized to CLK domain)
				.SIG_OUT( SIG_OUT[i] ),
				
				// System Signals
				.CLK( CLK )
			);
	
		end
		
	end
	endgenerate

endmodule
