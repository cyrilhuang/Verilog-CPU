`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:59 03/02/2016 
// Design Name: 
// Module Name:    register 
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
module register(clock_in, readReg1, readReg2, reset, writeReg, writeData, regWrite, readData1, readData2);
    input clock_in;
    input [25:21] readReg1;
    input [20:16] readReg2;
	 input reset;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
    output [31:0] readData1;
    output [31:0] readData2;

	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 reg [31:0] regFile[0:7];
	 
	 always @ (readReg1 or readReg2 or reset or writeReg or writeData)
	 begin
	     if (reset == 0)
		  begin
		      readData1 = regFile[readReg1];
		      readData2 = regFile[readReg2];
		  end
		  else
		  begin
		      readData1 = 0;
				readData2 = 0;
		  end
	 end
	 
	 always @ (negedge clock_in)
	 begin
	     if (reset)
		  begin
			    regFile[0] <= 32'b00000000000000000000000000000000;
             regFile[1] <= 32'b00000000000000000000000000000001;
		       regFile[2] <= 32'b00000000000000000000000000000010;
		       regFile[3] <= 32'b00000000000000000000000000000011;
		       regFile[4] <= 32'b00000000000000000000000000000100;
		       regFile[5] <= 32'b00000000000000000000000000000101;
		       regFile[6] <= 32'b00000000000000000000000000000110;
		       regFile[7] <= 32'b00000000000000000000000000000111;
		  end
	     else if (regWrite == 1)
		      regFile[writeReg] <= writeData;
	 end

endmodule
