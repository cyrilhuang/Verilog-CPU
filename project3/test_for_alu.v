`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:09:05 03/01/2016
// Design Name:   alu
// Module Name:   D:/lab3/test_for_alu.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr), 
		.zero(zero), 
		.aluRes(aluRes)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
      #100 aluCtr = 4'b0000;
		#100 input1 = 32'b00000000000000000000000011111111;
		#100 input2 = 32'b00000000000000000000000001111111;
      #100 aluCtr = 4'b0001;
		#100 input1 = 32'b00000000000000000000000000111111;
      #100 aluCtr = 4'b0010;
		#100 input2 = 32'b00000000000000000000000001101111;
      #100 aluCtr = 4'b0110;
		#100 input1 = 32'b00000000000000000000000001111000;
      #100 aluCtr = 4'b0111;
		#100 aluCtr = 4'b1100;
		// Add stimulus here

	end
      
endmodule

