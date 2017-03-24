`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:26 03/30/2016 
// Design Name: 
// Module Name:    forward 
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
module forward(
    input [4:0] ID_EX_regRt,
    input [4:0] ID_EX_regRs,
    input [4:0] EX_MEM_regRd,
    input [4:0] MEM_WB_regRd,
    input EX_regWrite,
    input MEM_regWrite,
    output reg[1:0] forwardA,
    output reg[1:0] forwardB
    );
	 
	 always @(ID_EX_regRt or ID_EX_regRs or EX_MEM_regRd or MEM_WB_regRd or EX_regWrite or MEM_regWrite)
	 begin
	     if (EX_regWrite && EX_MEM_regRd != 0 && ID_EX_regRs == EX_MEM_regRd)
		      forwardA = 2'b10;
		  else if(MEM_regWrite && MEM_WB_regRd!=0 && EX_MEM_regRd != ID_EX_regRs && MEM_WB_regRd == ID_EX_regRs)
		      forwardA = 2'b01;
		  else forwardA = 0;
		  
		  if (EX_regWrite && EX_MEM_regRd != 0 && ID_EX_regRt == EX_MEM_regRd)
		      forwardB = 2'b10;
		  else if(MEM_regWrite && MEM_WB_regRd!=0 && EX_MEM_regRd != ID_EX_regRt && MEM_WB_regRd == ID_EX_regRt)
		      forwardB = 2'b01;
		  else forwardB = 0;
	 end
	 


endmodule
