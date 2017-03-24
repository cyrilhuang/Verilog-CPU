`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:47:52 03/27/2016
// Design Name:   Top
// Module Name:   D:/test/test_top.v
// Project Name:  test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg clkOld;
	reg [3:0] switch;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clkOld(clkOld), 
		.switch(switch), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clkOld = 0;
		switch = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

