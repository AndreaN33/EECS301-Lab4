# Lab #4: HDL Component Reference

This document describes useful components that will be needed for this lab.


# HDL Constructs

## Packed Arrays

Definitions used in the following examples.

```verilog
localparam DATA_SIZE = 8;
localparam ARRAY_LENGTH = 4;
localparam PACKED_ARRAY_WIDTH = DATA_SIZE * ARRAY_LENGTH;

// Array Data
wire [DATA_SIZE-1:0] data0, data1, data2, data3;

// Packed Array Register
wire [PACKED_ARRAY_WIDTH-1:0] packed_array;
```

The packed array can be filled using the concatenation operator.

```verilog
assign packed_array = { data3, data2, data1, data0 };
```

Or the packed array can be filled by indexing the individual sections of the packed_array vector.

```verilog
assign packed_array[0 * DATA_SIZE +: DATA_SIZE] = data0;
assign packed_array[1 * DATA_SIZE +: DATA_SIZE] = data1;
assign packed_array[2 * DATA_SIZE +: DATA_SIZE] = data2;
assign packed_array[3 * DATA_SIZE +: DATA_SIZE] = data3;
```

Unpacking the data from the packed array can be done using the same procedures in reverse.

Unpacking using reverse concatenation.

```verilog
assign { data3, data2, data1, data0 } = packed_array;
```

Unpacking by indexing the individual sections of the packed_array vector.

```verilog
assign data0 = packed_array[0 * DATA_SIZE +: DATA_SIZE];
assign data1 = packed_array[1 * DATA_SIZE +: DATA_SIZE];
assign data2 = packed_array[2 * DATA_SIZE +: DATA_SIZE];
assign data3 = packed_array[3 * DATA_SIZE +: DATA_SIZE];
```


## State Machine Framework

The following example provides an example of a skeleton State Machine structure to be used as a reference when creating new State Machines (copy, paste, then start the real design work).

```verilog
	reg [3:0] State;	localparam [3:0]		S0 = 4'b0001,		S1 = 4'b0010,		S2 = 4'b0100,		S3 = 4'b1000;	always @(posedge CLK, posedge RESET)	begin			if (RESET)		begin
		
				end		else		begin					case (State)							S0 :				begin	
				end
				
				S1 :
				begin
				
				end
				
				S2 :
				begin
				
				end
				
				S3 :
				begin
				
				end
				
			endcase
			
		end
		
	end
```
