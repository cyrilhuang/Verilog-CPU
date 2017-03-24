`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:46:20 04/06/2016
// Design Name:   counter
// Module Name:   D:/lab2/countert.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module countert;

	// Inputs
	reg mainClock;
	reg reset;

	// Outputs
	wire [3:0] count;

   parameter DELY = 20;
	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.mainClock(mainClock), 
		.reset(reset), 
		.count(count)
	);

   always #(DELY/2) mainClock = ~mainClock;
	initial begin
		// Initialize Inputs
		mainClock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1'b1;
		
		#(DELY*10) reset = 1'b0;
		#(DELY) reset = 1'b1;

	end
      
endmodule

