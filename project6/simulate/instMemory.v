`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:46:59 03/17/2016 
// Design Name: 
// Module Name:    instMemory 
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
module instMemory(
    input [31:0] address,
    input clk,
    input reset,
    output [31:0] readData
    );
	 
	 reg [31:0]readData;
	 reg [31:0]memBuffer[0:63];
	 
	 initial
	 begin
		  memBuffer[0] = 32'b00000000000000000000000000000000;//noop
		  memBuffer[1] = 32'b00010000000011110000000000000100;//beq 0,15 ->4
	     memBuffer[2] = 32'b10001100000000010000000000000100;//lw 0 4(1)
	     memBuffer[3] = 32'b10001100000000110000000000000100;//lw 0 4(3)
	     memBuffer[4] = 32'b10001100000000110000000000000000;//lw 0 0(3)
		  memBuffer[5] = 32'b00000000000000000000000000000000;//noop
		  memBuffer[6] = 32'b00000000000000000000000000000000;//noop
		  memBuffer[7] = 32'b00000000000000000000000000000000;//noop
		  memBuffer[8] = 32'b00000000000000000000000000000000;//noop
	     memBuffer[9] = 32'b00000000001000100010000000100000;//4=1+2
	     memBuffer[10] = 32'b00000000100000010010100000100010;//5=4-1
	     memBuffer[11] = 32'b00000000010000010011000000100100;//6=2&1
	     memBuffer[12] = 32'b10001100000010100000000000000100;//lw 0 4(10)
	     memBuffer[13] = 32'b10001100000010100000000000000100;//lw 0 4(10)
	     memBuffer[14] = 32'b10001100000010100000000000000100;//lw 0 4(10)
	     memBuffer[15] = 32'b00000000011000010011100000100101;//7=3|1
	     memBuffer[16] = 32'b00000000011000010100000000101010;//8=3slt1
	 end
	 
	 always @(address)
	 begin
	     if (reset == 1) readData <= 0;
	     else readData = memBuffer[address>>2];
    end		  


endmodule
