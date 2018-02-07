`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    22:29:00 09/09/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #4 Project
// Module Name:    TF_BCD_Segment_Decoder
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    BCD to Seven Segment Decoder Test Bench
//                 
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module TF_BCD_Segment_Decoder();


	//
	// System Clock Emulation
	//
	localparam CLK_RATE_HZ = 500000000; // 500 MHz
	localparam CLK_HALF_PER = ((1.0 / CLK_RATE_HZ) * 1000000000.0) / 2.0; // ns
	
	reg CLK;
	
	initial
	begin
		CLK = 1'b0;
		forever #(CLK_HALF_PER) CLK = ~CLK;
	end


	
	//
	// Unit Under Test: BCD_Segment_Decoder
	//

	localparam BCD_DIGITS = 5;
	localparam BCD_WIDTH = 4; // 4-bits per digit
	localparam SEG_WIDTH = 7; // 7-bits per segment
	
	reg  [BCD_WIDTH-1:0] bcd_reg_0;
	reg  [BCD_WIDTH-1:0] bcd_reg_1;
	reg  [BCD_WIDTH-1:0] bcd_reg_2;
	reg  [BCD_WIDTH-1:0] bcd_reg_3;
	reg  [BCD_WIDTH-1:0] bcd_reg_4;
	
	wire [SEG_WIDTH-1:0] seg_out_0;
	wire [SEG_WIDTH-1:0] seg_out_1;
	wire [SEG_WIDTH-1:0] seg_out_2;
	wire [SEG_WIDTH-1:0] seg_out_3;
	wire [SEG_WIDTH-1:0] seg_out_4;

	
	BCD_Segment_Decoder
	#(
		.BCD_DIGITS( BCD_DIGITS )
	)
	uut
	(
		// BCD Input (Packed Array)
		.BCD_IN( { bcd_reg_4, bcd_reg_3, bcd_reg_2, bcd_reg_1, bcd_reg_0 } ),
		
		// Seven-Segment Output (Packed Array)
		.SEG_OUT( { seg_out_4, seg_out_3, seg_out_2, seg_out_1, seg_out_0 } ),
		
		// System Signals
		.CLK( CLK )
	);

	
	//
	// Expected Segment Output Patterns
	//
	wire [6:0] Expected_Segment_Output [15:0];

	assign Expected_Segment_Output[ 0] = 7'b0111111; // 0
	assign Expected_Segment_Output[ 1] = 7'b0000110; // 1
	assign Expected_Segment_Output[ 2] = 7'b1011011; // 2
	assign Expected_Segment_Output[ 3] = 7'b1001111; // 3
	assign Expected_Segment_Output[ 4] = 7'b1100110; // 4
	assign Expected_Segment_Output[ 5] = 7'b1101101; // 5
	assign Expected_Segment_Output[ 6] = 7'b1111101; // 6
	assign Expected_Segment_Output[ 7] = 7'b0000111; // 7
	assign Expected_Segment_Output[ 8] = 7'b1111111; // 8
	assign Expected_Segment_Output[ 9] = 7'b1100111; // 9
	assign Expected_Segment_Output[10] = 7'b0000000; // Blank
	assign Expected_Segment_Output[11] = 7'b0000000; // Blank
	assign Expected_Segment_Output[12] = 7'b0000000; // Blank
	assign Expected_Segment_Output[13] = 7'b0000000; // Blank
	assign Expected_Segment_Output[14] = 7'b0000000; // Blank
	assign Expected_Segment_Output[15] = 7'b0000000; // Blank
	
	
	//
	// Testing Procedure
	//
	integer test_digit_0;
	integer test_digit_1;
	integer test_digit_2;
	integer test_digit_3;
	integer test_digit_4;
	
	reg  [4:0] test_output_errors;

	integer total_errors;
	
	initial
	begin
	
		// Initialize signals
		bcd_reg_0 = {BCD_WIDTH{1'b0}};
		bcd_reg_1 = {BCD_WIDTH{1'b0}};
		bcd_reg_2 = {BCD_WIDTH{1'b0}};
		bcd_reg_3 = {BCD_WIDTH{1'b0}};
		bcd_reg_4 = {BCD_WIDTH{1'b0}};
		
		test_digit_0 = 0;
		test_digit_1 = 0;
		test_digit_2 = 0;
		test_digit_3 = 0;
		test_digit_4 = 0;
		
		test_output_errors = 5'b00000;
		
		total_errors = 0;
		
		
		// Wait for system to stabilize
		#500;
		
		
		//
		// Generate full coverage test vectors for every possible input combination
		//
		for (test_digit_4 = 0; test_digit_4 < 16; test_digit_4 = test_digit_4 + 1)
		begin

			for (test_digit_3 = 0; test_digit_3 < 16; test_digit_3 = test_digit_3 + 1)
			begin

				for (test_digit_2 = 0; test_digit_2 < 16; test_digit_2 = test_digit_2 + 1)
				begin

					for (test_digit_1 = 0; test_digit_1 < 16; test_digit_1 = test_digit_1 + 1)
					begin

						for (test_digit_0 = 0; test_digit_0 < 16; test_digit_0 = test_digit_0 + 1)
						begin

							// Set the BCD Input Values on the Rising Clock Edge
							@(posedge CLK);
							bcd_reg_0 = test_digit_0[3:0];
							bcd_reg_1 = test_digit_1[3:0];
							bcd_reg_2 = test_digit_2[3:0];
							bcd_reg_3 = test_digit_3[3:0];
							bcd_reg_4 = test_digit_4[3:0];
							
							// Wait a clock cycle for the inputs to be registered
							@(posedge CLK);
							
							// Wait another clock cycle for the outputs to update
							@(posedge CLK);
							
							// Check the output results
							test_output_errors[0] = (seg_out_0 != Expected_Segment_Output[test_digit_0]) ? 1'b1 : 1'b0;
							test_output_errors[1] = (seg_out_1 != Expected_Segment_Output[test_digit_1]) ? 1'b1 : 1'b0;
							test_output_errors[2] = (seg_out_2 != Expected_Segment_Output[test_digit_2]) ? 1'b1 : 1'b0;
							test_output_errors[3] = (seg_out_3 != Expected_Segment_Output[test_digit_3]) ? 1'b1 : 1'b0;
							test_output_errors[4] = (seg_out_4 != Expected_Segment_Output[test_digit_4]) ? 1'b1 : 1'b0;
							
							// Output Testing Message
							$display("Test: %02d %02d %02d %02d %02d : %s %s %s %s %s : %s ", 
								bcd_reg_4, bcd_reg_3, bcd_reg_2, bcd_reg_1, bcd_reg_0,
								test_output_errors[4] ? "X" : ".",
								test_output_errors[3] ? "X" : ".",
								test_output_errors[2] ? "X" : ".",
								test_output_errors[1] ? "X" : ".",
								test_output_errors[0] ? "X" : ".",
								|test_output_errors ? "FAILURE!!!" : "Pass      "
							);
							
							// Increment the Total Errors count if there was an error
							if (|test_output_errors)
								total_errors = total_errors + 1;
							
						end
						
					end
					
				end
				
			end
			
		end
		
		$display("Testing Complete: %d Total Errors", total_errors);
		
	end
	
endmodule
