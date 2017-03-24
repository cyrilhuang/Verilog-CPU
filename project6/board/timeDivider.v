`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:42:25 03/24/2016 
// Design Name: 
// Module Name:    timeDivider 
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
module timeDivider(
    input clk,
	 input pause,
    output reg clockOut
    );
	 
	 reg [23:0]buffer;
	 
	 initial
	 begin
	     buffer = 0;
		  clockOut = 0;
	 end
	 
	 always@(posedge clk)
	 begin
	     if (!pause)
	     buffer <= buffer + 1;
		  clockOut <= &buffer;
	 end


endmodule
