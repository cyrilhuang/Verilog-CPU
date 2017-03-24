`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:54:37 03/03/2016
// Design Name:   data_memory
// Module Name:   D:/lab4/test_for_datamen.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_datamen;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memWrite;
	reg memRead;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clock_in(clock_in), 
		.address(address), 
		.writeData(writeData), 
		.memWrite(memWrite), 
		.memRead(memRead), 
		.readData(readData)
	);
   always #100 clock_in = ~clock_in;
	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memWrite = 0;
		memRead = 0;

		// Wait 100 ns for global reset to finish
		#185;
		memWrite = 1'b1;
		address = 32'b00000000000000000000000000001111;
		writeData = 32'b11111111111111110000000000000000;
		
		#250;
		memRead = 1'b1;
		memWrite = 1'b0;
        
		// Add stimulus here

	end
      
endmodule

