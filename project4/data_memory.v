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
module data_memory(clock_in, address, writeData, memWrite, memRead, readData);
    input clock_in;
    input [31:0] address;
    input [31:0] writeData;
    input memWrite;
    input memRead;
    output [31:0] readData;
	 
	 reg [31:0] readData;
	 reg [31:0] memFile[0:127];
	 
	 always @(memRead)
	     readData = memFile[address];
		  
	 always @(negedge clock_in)
	 begin
	     if (memWrite)
		      memFile[address] = writeData;
	 end


endmodule
