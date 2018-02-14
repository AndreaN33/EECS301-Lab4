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
	
	reg [3:0] State;
	localparam [3:0]
		S0 = 4'b0001,
		S1 = 4'b0010,
		S2 = 4'b0100,
		S3 = 4'b1000;
		
always @(posedge CLK, posedge RESET)
begin

		if (RESET)
		begin
				DONE <= 1'b0;
				RESULT_READY <= 1'b0;

				oper_cin <= 1'b0;
				oper_bin <= {RESULT_WIDTH{1'b0}};
				accumulator_reg <= {RESULT_WIDTH{1'b0}};

				State <= S0;
		
		end
		else
		begin
		
				case (State)
				
					S0 :
					begin
						//clear Result Ready signal
						RESULT_READY <= 1'b0;
						//clear done signal
						DONE <= 1'b0;
						
						if(CLEAR)
							State <= S3;
						else if(COMPUTE)
							State <= S1;
						

					end
					
					S1 :
					begin
						case (OPERATION)
							1'b0 : { oper_cin, oper_bin } <= { 1'b0,  calc_data_ext }; // Add
							1'b1 : { oper_cin, oper_bin } <= { 1'b1, ~calc_data_ext }; // Sub
						endcase

						State <= S2;
					
					end
					
					S2 :
					begin
					
						// Store the result
						accumulator_reg <= adder_result;

						// Assert Result Ready
						RESULT_READY <= 1'b1;

						// Command Done
						DONE <= 1'b1;

						State <= S0;	
					
					end
					
					S3 :
					begin
					
						// Clear accumulator register
						accumulator_reg <= {RESULT_WIDTH{1'b0}};

						// Assert Result Ready
						RESULT_READY <= 1'b1;

						// Command Done
						DONE <= 1'b1;

						State <= S0;
					
					end
					
				endcase
			
		end
	
end

	
endmodule
