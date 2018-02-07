`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    20:21:00 09/20/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    TF_BCD_Binary_Encoder
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Binary to BCD Converter Test Bench
//
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module TF_BCD_Binary_Encoder();


	//
	// Set the Binary Width and BCD Digit parameters
	//
	localparam BIN_WIDTH = 17;
	localparam BDC_DIGITS = 5;

	reg [BIN_WIDTH-1:0] BIN_DATA;


	//
	// System Clock Emulation
	//
	localparam CLK_RATE_HZ = 500000000; // 500 MHz
	localparam CLK_HALF_PER = ((1.0 / CLK_RATE_HZ) * 1000000000.0) / 2.0; // ns
	
	reg        CLK;
	
	initial
	begin
		CLK = 1'b0;
		forever #(CLK_HALF_PER) CLK = ~CLK;
	end

	
	//
	// Unit Under Test: BCD_Binary_Encoder
	//
	reg  RESET;
	reg  BCD_CONVERT;
	wire BCD_DONE;
	
	wire [3:0] bcd_out_0;
	wire [3:0] bcd_out_1;
	wire [3:0] bcd_out_2;
	wire [3:0] bcd_out_3;
	wire [3:0] bcd_out_4;
	wire       bcd_overflow;
	
	BCD_Binary_Encoder
	#(
		.BIN_WIDTH( BIN_WIDTH ),
		.BDC_DIGITS( BDC_DIGITS )
	)
	uut
	(
		// Input Signals
		.CONVERT( BCD_CONVERT ),
		.DONE( BCD_DONE ),
		.BIN_IN( BIN_DATA ),	
		
		// BCD Data Output Signals	
		.BCD_OUT( { bcd_out_4, bcd_out_3, bcd_out_2, bcd_out_1, bcd_out_0 } ),
		.BCD_OVERFLOW( bcd_overflow ),
		
		// System Signals
		.CLK( CLK ),
		.RESET( RESET )
	);


	//
	// Testing Procedure
	//
	
	integer i;
	
	integer expected_value;
	integer result_value;
	integer total_errors;
	
	reg error_status;
	reg expected_overflow;
	reg bcd_out_0_valid;
	reg bcd_out_1_valid;
	reg bcd_out_2_valid;
	reg bcd_out_3_valid;
	reg bcd_out_4_valid;
	
	
	initial
	begin
	
		// Initialize Signals
		RESET = 1'b1;
		
		BCD_CONVERT = 1'b0;
		BIN_DATA = {BIN_WIDTH{1'b0}};
	

		expected_value = 0;
		result_value = 0;
		
		total_errors = 0;
		
		error_status = 1'b0;
		expected_overflow = 1'b0;
	
		bcd_out_0_valid = 1'b0;
		bcd_out_1_valid = 1'b0;
		bcd_out_2_valid = 1'b0;
		bcd_out_3_valid = 1'b0;
		bcd_out_4_valid = 1'b0;
	
		#500;
		
		// Release the Reset
		@(posedge CLK);
		RESET = 1'b0;
		
		#500;
		
		
		// Start the Testing
		
		for (i = 0; i < 2**BIN_WIDTH; i=i+1)
		begin

			// Pulse the Convert signal
			@(posedge CLK);
			BCD_CONVERT = 1'b1;
			@(posedge CLK);
			BCD_CONVERT = 1'b0;
			
			// Wait for the Conversion to finish
			@(posedge BCD_DONE);
			
			// Wait till next Clock
			@(posedge CLK); 
			
			//
			// Verify the output BCD data
			//
			
			// Set Expected Value to Binary Input
			if (BIN_DATA < 100000)
			begin
				expected_value = BIN_DATA;  // Normal Value
				expected_overflow = 1'b0;
			end
			else
			begin
				expected_value = BIN_DATA - 100000;  // Overflow Value
				expected_overflow = 1'b1;
			end
				
			// Compute Result value from BCD output
			result_value = bcd_out_4 * 10000 + bcd_out_3 * 1000 + bcd_out_2 * 100 + bcd_out_1 * 10 + bcd_out_0;
		
			// Check each BCD ouptut is valid
			bcd_out_0_valid = bcd_out_0 >= 0 && bcd_out_0 < 10;
			bcd_out_1_valid = bcd_out_0 >= 0 && bcd_out_0 < 10;
			bcd_out_2_valid = bcd_out_0 >= 0 && bcd_out_0 < 10;
			bcd_out_3_valid = bcd_out_0 >= 0 && bcd_out_0 < 10;
			bcd_out_4_valid = bcd_out_0 >= 0 && bcd_out_0 < 10;
					
			// Set Error Status		
			error_status = (expected_value != result_value) ||
				!bcd_out_4_valid ||
				!bcd_out_3_valid ||
				!bcd_out_2_valid ||
				!bcd_out_1_valid ||
				!bcd_out_0_valid ||
				expected_overflow != bcd_overflow;
			
			// Report Test Results
			$display("Test: [%05X] %01d %01d %01d %01d %01d : %s %s %s %s %s %s %s : %s", 
				BIN_DATA,
				bcd_out_4,
				bcd_out_3,
				bcd_out_2,
				bcd_out_1,
				bcd_out_0,
				expected_overflow == bcd_overflow ? "." : "X",
				bcd_out_4_valid ? "." : "X",
				bcd_out_3_valid ? "." : "X",
				bcd_out_2_valid ? "." : "X",
				bcd_out_1_valid ? "." : "X",
				bcd_out_0_valid ? "." : "X",
				expected_value == result_value ? "." : "X",				
				error_status ? "FAILURE!!!" : "Pass      " 
			);
			
			// Increment Error Count if an Error occured
			if (error_status)
				total_errors = total_errors + 1;
				
			// Increment the Binary Data for the next Test
			@(posedge CLK)
			BIN_DATA = BIN_DATA + 1'b1;
			
		end
	
		$display("Testing Complete: %d Total Errors", total_errors);
	
	end

endmodule
