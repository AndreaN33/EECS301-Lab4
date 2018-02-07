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

module EECS301_Lab4_TopLevel
#(
	// These parameters are listed here so they can be overridden in simulation.
	parameter KEY_LOCK_DELAY = 500000000, // 500 ms
	parameter SW_DEBOUNCE_TIME = 10000000 // 10 mS
)
(
	// Clock Signals
	input         CLOCK_50,

	// LED Signals
	output  [9:0] LEDR,
	
	// 7-Segment Display Signals (Active-Low)
	output  [6:0] HEX0,
	output  [6:0] HEX1,
	output  [6:0] HEX2,
	output  [6:0] HEX3,
	output  [6:0] HEX4,
	output  [6:0] HEX5,

	// Button Signals (Active-Low)
	input   [3:0] KEY,
	
	// Switch Signals
	input   [9:0] SW
);

	localparam CLOCK_50_RATE = 50000000; // 50 MHz 

	//
	// Show the Switch position value on the Status LEDs (0 = off, 1 = on)
	//
	assign LEDR = SW;
	

	////////////////////////////////////////////////////////
	//
	// System Reset Controller
	//	
	wire sys_reset;
	
	System_Reset_Module
	#(
		.REF_CLK_RATE_HZ( CLOCK_50_RATE ),
		.POWER_ON_DELAY( 500 )  // 500 ns
	)
	sys_reset_ctrl
	(
		// Input Signals
		.PLL_LOCKED( 1'b1 ),  // No PLL so force true
		.REF_CLK( CLOCK_50 ),
		
		// Output Signals
		.RESET( sys_reset )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Key Input Synchronizers
	//
	wire key_add;
	wire key_sub;
	wire key_clr;
	
	Key_Synchronizer_Bank
	#(
		.KEY_SYNC_CHANNELS( 3 ),
		.CLK_RATE_HZ( CLOCK_50_RATE ),
		.KEY_LOCK_DELAY( KEY_LOCK_DELAY ) // nS
	)
	key_sync_bank
	(
		// Input Signals
		.KEY( { ~KEY[3], ~KEY[1:0] } ),
		
		// Output Signals
		.KEY_EVENT( { key_clr, key_sub, key_add } ),
		
		// System Signals
		.CLK( CLOCK_50 )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Switch Input Debounce Synchronizers
	//
	wire [9:0] calc_operand;
	
	Switch_Synchronizer_Bank
	#(
		.SWITCH_SYNC_CHANNELS( 10 ),
		.CLK_RATE_HZ( CLOCK_50_RATE ),
		.DEBOUNCE_TIME( SW_DEBOUNCE_TIME ),
		.SIG_OUT_INIT( 1'b0 )
	)
	switch_sync_bank
	(
		// Input  Signals (asynchronous)
		.SIG_IN( SW ),
		
		// Output Signals (synchronized to CLK domain)
		.SIG_OUT( calc_operand ),
		
		// System Signals
		.CLK( CLOCK_50 )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Key Controller
	//
	wire cmd_clear;
	wire cmd_compute;
	wire cmd_operation;
	wire cmd_done;
	
	Key_Command_Controller key_commander
	(
		// Key Input Signals
		.KEY_CLEAR( key_clr ),
		.KEY_ADD( key_add ),
		.KEY_SUB( key_sub ),
	
		// Command Signals
		.CMD_DONE( cmd_done ),
		.CMD_CLEAR( cmd_clear ),
		.CMD_COMPUTE( cmd_compute ),
		.CMD_OPERATION( cmd_operation ),
		
		// System Signals
		.CLK( CLOCK_50 ),
		.RESET( sys_reset )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Calculator
	//
	localparam CALC_DATA_WIDTH = 10;
	localparam CALC_RESULT_WIDTH = 18;
	
	wire                         calc_result_ready;
	wire [CALC_RESULT_WIDTH-1:0] calc_result_data;	
	
	Calculator_Module
	#(
		.DATA_WIDTH( CALC_DATA_WIDTH ),
		.RESULT_WIDTH( CALC_RESULT_WIDTH )
	)
	calculator
	(
		// Control Signals
		.DONE( cmd_done ),
		.CLEAR( cmd_clear ),
		.COMPUTE( cmd_compute ),
		.OPERATION( cmd_operation ), // 0=Add, 1=Sub
		.CALC_DATA( calc_operand ),
		
		// Result Signals
		.RESULT_READY( calc_result_ready ),
		.RESULT_DATA( calc_result_data ),
		
		// System Signals
		.CLK( CLOCK_50 ),
		.RESET( sys_reset )
	);

	
	////////////////////////////////////////////////////////
	//
	// Compute Absolute Value of Calc Result
	//
	wire [CALC_RESULT_WIDTH-1:0] abs_result_data;

	FxP_ABS_Function
	#(
		.DATA_WIDTH( CALC_RESULT_WIDTH )
	)
	calc_result_abs
	(
		// Data Signals
		.DATA_IN( calc_result_data ),
		.DATA_ABS( abs_result_data )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Result Register to BCD Digits
	//
	localparam BCD_DIGITS = 5;
	
	wire [BCD_DIGITS*4-1:0] bcd_result;
	wire                    bcd_overflow;
	
	BCD_Binary_Encoder
	#(
		.BIN_WIDTH( CALC_RESULT_WIDTH ),
		.BDC_DIGITS( BCD_DIGITS )
	)
	result_to_bcd_converter
	(
		// Control Signals
		.CONVERT( calc_result_ready ),
		.DONE(  ),
		.BIN_IN( abs_result_data ),
		
		// BCD Data Output Signals	
		.BCD_OUT( bcd_result ),
		.BCD_OVERFLOW( bcd_overflow ),
		
		// System Signals
		.CLK( CLOCK_50 ),
		.RESET( sys_reset )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Convert BCD Digits to drive Seven Segment Outputs
	//
	wire [BCD_DIGITS*7-1:0] seg_out;
	
	BCD_Segment_Decoder
	#(
		.BCD_DIGITS( BCD_DIGITS )
	)
	bcd_to_7seg_decoders
	(
		// BCD Input (Packed Array)
		.BCD_IN( bcd_result ),
		
		// Seven-Segment Output (Packed Array)
		.SEG_OUT( seg_out ),
		
		// System Signals
		.CLK( CLOCK_50 )
	);
	
	
	////////////////////////////////////////////////////////
	//
	// Map the Segment Output values from the packed arry 
	//   to the FPGA output pins.
	//
	// Note: The hardware signals are active-low so the
	//       values of seg_out need to be inverted.
	//
	assign HEX0 = ~seg_out[0*7+:7];
	assign HEX1 = ~seg_out[1*7+:7];
	assign HEX2 = ~seg_out[2*7+:7];
	assign HEX3 = ~seg_out[3*7+:7];
	assign HEX4 = ~seg_out[4*7+:7];
	
	assign HEX5[0] = 1'b1;                          // Unused
	assign HEX5[2:1] = bcd_overflow ? 2'h0 : 2'h3;  // If overflowed, show "1" else blank
	assign HEX5[5:3] = 3'h7;                        // Unused
	assign HEX5[6] = ~calc_result_data[17];         // Show "-" when value is negative
	
endmodule
