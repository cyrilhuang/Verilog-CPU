`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:49:12 03/01/2016 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(input1, input2, aluCtr, zero, aluRes);
    input [31:0] input1;
    input [31:0] input2;
    input [3:0] aluCtr;
    output zero;
    output [31:0] aluRes;
	 reg zero;
	 reg [31:0] aluRes;
	 
	 always @ (input1 or input2 or aluCtr)
	 begin
	     if (aluCtr == 4'b0010)
		      aluRes = input1 + input2;
		  else if (aluCtr == 4'b0110)
		  begin
		      aluRes = input1 - input2;
				if (aluRes == 0)
				    zero = 1;
				else
				    zero = 0;
			end
			else if (aluCtr == 4'b0000)
			    aluRes = input1 & input2;
			else if (aluCtr == 4'b0001)
			    aluRes = input1 | input2;
			else if (aluCtr == 4'b0111)
			begin
			    if (input1 < input2)
			        aluRes = 1;
				 else
				     aluRes = 0;
			end
			else if (aluCtr == 4'b1100)
			begin
			    aluRes = ~input1;
			end
     end


endmodule
