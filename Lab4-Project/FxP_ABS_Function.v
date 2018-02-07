`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    20:17:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    FxP_ABS_Function
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Fixed Point Absolute Value Function
//
//                 Input Data in Fixed Point Two's Complement Format
//                 Output Data is positive value integer
//
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module FxP_ABS_Function
#(
	parameter DATA_WIDTH = 16
)
(
	// Data Signals
	input   [DATA_WIDTH-1:0] DATA_IN,
	output  [DATA_WIDTH-1:0] DATA_ABS
);

	//
	// Two's Complement Absolute Function
	//
	// If the sign-bit (MSB) is high, then
	//    DATA_ABS = ~DATA_IN + 1'b1
	// Else
	//    DATA_ABS = DATA_IN
	//
	assign DATA_ABS = DATA_IN[DATA_WIDTH-1] ? ~DATA_IN + 1'b1 : DATA_IN;

endmodule
