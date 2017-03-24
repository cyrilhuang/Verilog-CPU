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
    output reg[31:0] readData
    );
	 
	 reg [31:0]instMem[0:15];
	 
	 initial
	 begin
	     instMem[0]=32'b00001000000000000000000000000100;
		  instMem[1]=32'b00000000000000000000000000000000;
		  instMem[2]=32'b00000000000000000000000000000000;
		  instMem[3]=32'b00000000000000000000000000000000;
		  instMem[4]=32'b10101100000011000000000000000000;
		  instMem[5]=32'b10101100001011000000000000000000;
		  instMem[6]=32'b10001100001001100000000000000000;
		  instMem[7]=32'b00000000000000000000000000000000;
		  instMem[8]=32'b00000000001000100010000000100000;
		  instMem[9]=32'b00000000001000100010000000100010;
		  instMem[10]=32'b00000000001000100010000000100100;
		  instMem[11]=32'b00000000001000100010000000100101;
		  instMem[12]=32'b00000000001000100010000000101010;
		  instMem[13]=32'b00001000000000000000000000000100;
		  instMem[14]=32'b00000000000000000000000000000000;
		  instMem[15]=32'b00000000000000000000000000000000;
	 end
	 
	 always @(address or reset)
	 begin
	     if (reset == 1) readData = 0;
	     else readData = instMem[address>>2];
    end		  


endmodule
