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
module data_memory(clock_in, address, writeData, memWrite, memRead, reset, readData);
    input clock_in;
    input [31:0] address;
    input [31:0] writeData;
    input memWrite;
    input memRead;
	 input reset;
    output [31:0] readData;
	 
	 reg [31:0] readData;
	 reg [31:0] memFile[0:15];
	 
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
	     memFile[10] = 8'h0000000a;
	     memFile[11] = 8'h0000000b;
	     memFile[12] = 8'h0000000c;
	     memFile[13] = 8'h0000000d;
	     memFile[14] = 8'h0000000e;
	     memFile[15] = 8'h0000000f;
	 end
	 
	 always @(memRead)
	     readData = memFile[address];
		  
	 always @(negedge clock_in or posedge reset)
	 begin
	     if (reset)
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
	         memFile[10] = 8'h0000000a;
	         memFile[11] = 8'h0000000b;
	         memFile[12] = 8'h0000000c;
	         memFile[13] = 8'h0000000d;
	         memFile[14] = 8'h0000000e;
	         memFile[15] = 8'h0000000f;
		  end
	     else if (memWrite)
		      memFile[address] = writeData;
		  
	 end


endmodule
