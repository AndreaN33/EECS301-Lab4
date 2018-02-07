`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:14:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    Calculator_Full_Adder
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Calculator Full Adder
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module Calculator_Full_Adder
#(
	parameter WIDTH = 4
)
(
	// Operand Signals
	input  [WIDTH-1:0] A,
	input  [WIDTH-1:0] B,
	input              CIN,
	
	// Result Signals
	output [WIDTH-1:0] RES,
	output             COUT
);

	wire signed [WIDTH:0] op_a; 
	wire signed [WIDTH:0] op_b;
	
	
	//
	// Sign Extend Input Data
	//
	assign op_a = { A[WIDTH-1], A };
	assign op_b = { B[WIDTH-1], B };

	
	//
	// Signed Adder with Carry-In
	//	
	assign { COUT, RES } = op_a + op_b + CIN;
	
endmodule
