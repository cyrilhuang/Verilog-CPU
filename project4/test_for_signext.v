`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:26:48 03/03/2016
// Design Name:   signext
// Module Name:   D:/lab4/test_for_signext.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_signext;

	// Inputs
	reg [15:0] inst;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	signext uut (
		.inst(inst), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#100 inst = 16'b0010001110101101;
      #300 inst = 16'b1010001110101101;
		// Add stimulus here

	end
      
endmodule

