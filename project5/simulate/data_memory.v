`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:35 03/03/2016 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(clock_in, address, reset, writeData, memWrite, memRead, readData);
    input clock_in;
    input [31:0] address;
	 input reset;
    input [31:0] writeData;
    input memWrite;
    input memRead;
    output [31:0] readData;
	 
	 reg [31:0] readData;
	 reg [31:0] memFile[0:127];
	 integer k;
	 
	 initial
	 begin
	     memFile[0] = 8'h00000000;
	     memFile[1] = 8'h00000001;
	     memFile[2] = 8'h00000002;
	     memFile[3] = 8'h00000003;
	     memFile[4] = 8'h00000004;
	     memFile[5] = 8'h00000005;
	     memFile[6] = 8'h00000006;
	     memFile[7] = 8'h00000007;
	     memFile[8] = 8'h00000008;
	     memFile[9] = 8'h00000009;
	 end
		  
	 
	 always @(memRead or reset)
	 begin
	     if (reset)
		  begin
		      readData = 0;
				memFile[0] <= 8'h00000000;
	         memFile[1] <= 8'h00000001;
	         memFile[2] <= 8'h00000002;
	         memFile[3] <= 8'h00000003;
	         memFile[4] <= 8'h00000004;
	         memFile[5] <= 8'h00000005;
	         memFile[6] <= 8'h00000006;
	         memFile[7] <= 8'h00000007;
	         memFile[8] <= 8'h00000008;
	         memFile[9] <= 8'h00000009;
				for (k = 10; k < 128; k = k + 1)
				    memFile[k] <= 0;
		  end
		  else if (memRead)
		      readData = memFile[address];
	  end
		  
	 always @(negedge clock_in)
	 begin
	     if (memWrite)
		      memFile[address] = writeData;
	 end


endmodule
