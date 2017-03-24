`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:49 03/30/2016 
// Design Name: 
// Module Name:    muxForward 
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
module muxForward(
    input [31:0] inputReg,
    input [31:0] inputMux,
    input [31:0] inputAlu,
    input [1:0] forward,
    output [31:0] outputData
    );

    assign outputData = (forward[1] == 1) ? inputAlu : ((forward[0] == 1) ? inputMux : inputReg);

endmodule
