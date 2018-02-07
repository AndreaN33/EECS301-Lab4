`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:29:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    BCD_Segment_Decoder
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    BCD to Seven Segment Decoder
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module BCD_Segment_Decoder
#(
	parameter BCD_DIGITS = 1
)
(
	// BCD Input (Packed Array)
	input      [BCD_DIGITS*4-1:0] BCD_IN,
	
	// Seven-Segment Output (Packed Array)
	output reg [BCD_DIGITS*7-1:0] SEG_OUT,
	
	// System Signals
	input CLK
);

	//
	// Initialize Output
	//
	initial
	begin
		SEG_OUT <= {BCD_DIGITS*7{1'b0}};
	end
	

	//
	// Select Segment Output using BCD index for each Digit
	//

	// !! Lab 4: Add SEG_OUT Registered Multiplexers for each BCD Digit here !!
	
endmodule
