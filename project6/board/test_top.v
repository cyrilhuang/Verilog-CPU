`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:57:19 03/27/2016
// Design Name:   Top
// Module Name:   D:/lab6board/test_top.v
// Project Name:  lab6board
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
	reg clock_in;
	reg reset;
	reg [3:0] switch;

	// Outputs
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clock_in(clock_in), 
		.reset(reset), 
		.switch(switch), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		reset = 1;
		switch = 0;

		// Wait 100 ns for global reset to finish
		#20;
		reset = 0;
        
		// Add stimulus here

	end
	
	always #50 clock_in = ~clock_in;
      
endmodule

