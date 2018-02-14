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
	
	
	
	genvar i;
	generate
	begin
			for(i=0;i<BCD_DIGITS;i=i+1)
			begin : bcd_to_seg_mapping
					always @(posedge CLK)
					begin 
						
						case(BCD_IN[i*4 +: 4])
							4'b0000 : SEG_OUT[i*7 +:7] <= 7'b0111111; //0
							4'b0001 : SEG_OUT[i*7 +:7] <= 7'b0000110; //1
							4'b0010 : SEG_OUT[i*7 +:7] <= 7'b1011011; //2
							4'b0011 : SEG_OUT[i*7 +:7] <= 7'b1001111; //3
							4'b0100 : SEG_OUT[i*7 +:7] <= 7'b1100110; //4
							4'b0101 : SEG_OUT[i*7 +:7] <= 7'b1101101; //5
							4'b0110 : SEG_OUT[i*7 +:7] <= 7'b1111101; //6
							4'b0111 : SEG_OUT[i*7 +:7] <= 7'b0000111; //7
							4'b1000 : SEG_OUT[i*7 +:7] <= 7'b1111111; //8
							4'b1001 : SEG_OUT[i*7 +:7] <= 7'b1100111; //9
//							4'b1010 : SEG_OUT[i*7 +:7] <= 7'b0000000;
//							4'b1011 : SEG_OUT[i*7 +:7] <= 7'b0000000;
//							4'b1100 : SEG_OUT[i*7 +:7] <= 7'b0000000;
//							4'b1101 : SEG_OUT[i*7 +:7] <= 7'b0000000;
//							4'b1110 : SEG_OUT[i*7 +:7] <= 7'b0000000;
//							4'b1111 : SEG_OUT[i*7 +:7] <= 7'b0000000;
							default : SEG_OUT[i*7 +:7] <= 7'b0000000; //blank
						endcase
						
					end
			end
	end
	endgenerate
	
endmodule
