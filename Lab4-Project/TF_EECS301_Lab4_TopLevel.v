`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:14:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    TF_EECS301_Lab4_TopLevel
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    EECS301 Lab 4 Top Level Test Bench
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module TF_EECS301_Lab4_TopLevel();


	//
	// System Clock Emulation
	//
	// Toggle the CLOCK_50 signal every 10 ns to create to 50MHz clock signal
	//
	localparam CLK_RATE_HZ = 50000000; // Hz
	localparam CLK_HALF_PER = ((1.0 / CLK_RATE_HZ) * 1000000000.0) / 2.0; // ns
	
	reg        CLOCK_50;
	
	initial
	begin
		CLOCK_50 = 1'b0;
		forever #(CLK_HALF_PER) CLOCK_50 = ~CLOCK_50;
	end


	//
	// Unit Under Test: CLS_LED_Output_Fader
	//
	wire [9:0] LEDR;
	wire [6:0] HEX0;
	wire [6:0] HEX1;
	wire [6:0] HEX2;
	wire [6:0] HEX3;
	wire [6:0] HEX4;
	wire [6:0] HEX5;
	reg  [3:0] KEY;
	reg  [9:0] SW;

	EECS301_Lab4_TopLevel
	#(
		.KEY_LOCK_DELAY( 10000 ),  // 10 us
		.SW_DEBOUNCE_TIME( 100 )   // 100 nS
	)
	uut
	(
		// Clock Signals
		.CLOCK_50( CLOCK_50 ),

		// LED Signals
		.LEDR( LEDR ),
		
		// 7-Segment Display Signals (Active-Low)
		.HEX0( HEX0 ),
		.HEX1( HEX1 ),
		.HEX2( HEX2 ),
		.HEX3( HEX3 ),
		.HEX4( HEX4 ),
		.HEX5( HEX5 ),

		// Button Signals (Active-Low)
		.KEY( KEY ),
		
		// Switch Signals
		.SW( SW )
	);

	
	//
	// Test Stimulus
	//
	initial
	begin
		// Initialize Signals
		KEY = 4'hF;  // Active-Low
		SW = 10'h000;
		
		#1000;
		
		
		//
		// Begin Testing
		//
		
		// Set input test value
		SW = 10'h021;
		#1000;         // Wait 1uS for debounce
		
		// Press Add Key
		KEY[0] = 1'b0;
		#1000; // Press for 1uS
		KEY[0] = 1'b1;
				
		#10000; // Wait 10 uS
		
		// Press Sub Key
		KEY[1] = 1'b0;
		#1000; // Press for 1uS
		KEY[1] = 1'b1;
		
		#10000; // Wait 10 uS

		// Press Sub Key
		KEY[1] = 1'b0;
		#1000; // Press for 1uS
		KEY[1] = 1'b1;
		
		#10000; // Wait 10 uS

		SW = 10'h321;
		#1000;         // Wait 1uS for debounce
		
		// Press Add Key
		KEY[0] = 1'b0;
		#1000; // Press for 1uS
		KEY[0] = 1'b1;
				
		#10000; // Wait 10 uS

		// Press Clr Key
		KEY[3] = 1'b0;
		#1000; // Press for 1uS
		KEY[3] = 1'b1;
				
		#10000; // Wait 10 uS

	end
	
endmodule
