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
module register(clock_in, reset, readReg1, readReg2, writeReg, writeData, regWrite, readData1, readData2);
    input clock_in;
	 input reset;
    input [25:21] readReg1;
    input [20:16] readReg2;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
    output [31:0] readData1;
    output [31:0] readData2;
    
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 reg [31:0] regFile[0:31];
	 integer k;
	 
	 initial
	 begin
	     regFile[0] = 8'h00000000;
	     regFile[1] = 8'h00000001;
	     regFile[2] = 8'h00000002;
	     regFile[3] = 8'h00000003;
	     regFile[4] = 8'h00000004;
	     regFile[5] = 8'h00000005;
	     regFile[6] = 8'h00000006;
	     regFile[7] = 8'h00000007;
	     regFile[8] = 8'h00000008;
	     regFile[9] = 8'h00000009;
	     regFile[10] = 8'h0000000a;
	     regFile[11] = 8'h0000000b;
	     regFile[12] = 8'h0000000c;
	     regFile[13] = 8'h0000000d;
	     regFile[14] = 8'h0000000e;
	     regFile[15] = 8'h00000000;
	 end
	 
	 always @ (readReg1 or readReg2)
	 begin
		  readData1 = regFile[readReg1];
		  readData2 = regFile[readReg2];
	 end
	 
	 always @ (negedge clock_in or reset)
	 begin
	     if (reset == 1)
		  begin
		      readData1 <= 0;
				readData2 <= 0;
		      regFile[0] <= 8'h00000000;
	         regFile[1] <= 8'h00000001;
	         regFile[2] <= 8'h00000002;
	         regFile[3] <= 8'h00000003;
	         regFile[4] <= 8'h00000004;
	         regFile[5] <= 8'h00000005;
	         regFile[6] <= 8'h00000006;
	         regFile[7] <= 8'h00000007;
	         regFile[8] <= 8'h00000008;
	         regFile[9] <= 8'h00000009;
	         regFile[10] <= 8'h0000000a;
	         regFile[11] <= 8'h0000000b;
	         regFile[12] <= 8'h0000000c;
	         regFile[13] <= 8'h0000000d;
	         regFile[14] <= 8'h0000000e;
	         regFile[15] <= 8'h00000000;
		      for( k = 16; k < 32; k = k + 1)
				    regFile[k] <= 0;
		  end
	     else if (regWrite == 1)
		      regFile[writeReg] = writeData;
	 end

endmodule
