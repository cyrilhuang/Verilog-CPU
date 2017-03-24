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
	 reg [31:0] memFile[0:7];
		  
	 
	 always @(memRead or reset or address)
	 begin
	     if (reset)
		      readData = 0;
		  else if (memRead)
		      readData = memFile[address];
	  end
		  
	 always @(negedge clock_in)
	 begin
	     if (reset)
		  begin
				memFile[0] <= 32'b00000000000000000000000000000000;
	         memFile[1] <= 32'b00000000000000000000000000000001;
	         memFile[2] <= 32'b00000000000000000000000000000010;
	         memFile[3] <= 32'b00000000000000000000000000000011;
	         memFile[4] <= 32'b00000000000000000000000000000100;
	         memFile[5] <= 32'b00000000000000000000000000000101;
	         memFile[6] <= 32'b00000000000000000000000000000110;
	         memFile[7] <= 32'b00000000000000000000000000000111;
		  end
	     else if (memWrite)
		      memFile[address] <= writeData;
	 end


endmodule
