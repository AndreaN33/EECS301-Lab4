`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:14:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    EECS301_Lab4_TopLevel
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    EECS301 Lab 4 Top Level File
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module Calculator_Module
#(
	parameter DATA_WIDTH = 10,
	parameter RESULT_WIDTH = 18
)
(
	// Control Signals
	output reg              DONE,
	input                   CLEAR,
	input                   COMPUTE,
	input                   OPERATION, // 0=Add, 1=Sub, 
	input  [DATA_WIDTH-1:0] CALC_DATA,
	
	// Result Signals
	output reg                    RESULT_READY,
	output     [RESULT_WIDTH-1:0] RESULT_DATA,
	
	// System Signals
	input CLK,
	input RESET
);


	//
	// The Calculation Data operand is shorter than the Result Data output so
	//   extend the CALC_DATA input width to match the RESULT_DATA output.
	//
	wire [RESULT_WIDTH-1:0] calc_data_ext = { {RESULT_WIDTH-DATA_WIDTH{1'b0}}, CALC_DATA };
	
	
	//
	// Full Adder
	//
	reg  [RESULT_WIDTH-1:0] accumulator_reg;
	reg  [RESULT_WIDTH-1:0] oper_bin;
	reg                     oper_cin;
	wire [RESULT_WIDTH-1:0] adder_result;
	
	Calculator_Full_Adder
	#(
		.WIDTH( RESULT_WIDTH )
	)
	adder
	(
		// Operand Signals
		.A( accumulator_reg ),
		.B( oper_bin ),
		.CIN( oper_cin ),
		
		// Result Signals
		.RES( adder_result ),
		.COUT(  )
	);
	
	
	//
	// Output the value of the accumulator register
	//
	assign RESULT_DATA = accumulator_reg;
	
	
	//
	// Calculator State Machine
	//

	// !! Lab 4: Add Calculator State Machine implementation here !!

	
endmodule
