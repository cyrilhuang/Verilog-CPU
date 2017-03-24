`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:03:05 03/03/2016 
// Design Name: 
// Module Name:    Top 
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
module Top(
    //input clock_in,
	 input clkOld,
	 input [5:0]switch,
	 output reg[7:0] led
    );
	 
	 wire [31:0] INST;
	 reg [31:0] pc;
	 wire clock_in;
	 
	 //ctr
	 wire REG_DST,
	      JUMP,
			BRANCH,
			MEM_READ,
			MEM_TO_REG,
			MEM_WRITE;
	 wire[1:0] ALU_OP;
	 wire ALU_SRC,
	      REG_WRITE;
	 wire reset;
	 
	 //reg
	 wire [31:0]reg_alu;
	 wire [31:0]reg_dataMem;
	 //signext
	 wire [31:0]signext_pc;
	 //alu
	 wire alu_pc;
	 wire [31:0]alu_dataMem;
	 //dataMem
	 wire [31:0]dataMem_muxMem2Reg;
	 //aluCtr
	 wire [3:0]aluCtr_alu;
	 //muxMem2Reg
	 wire [31:0]muxMem2Reg_reg;
	 //muxAlu
	 wire [31:0] muxAlu_alu;
	 //muxResDst
	 wire [4:0] muxResDst_reg;
	 //muxCtr;
	 wire [31:0] muxCtr;
	 //mucPc;
	 wire [31:0] muxPc;
	 
			
	 Ctr mainCtr(
	         .reset(reset),
	         .opCode(INST[31:26]),
				.regDst(REG_DST),
				.jump(JUMP),
				.branch(BRANCH),
				.memRead(MEM_READ),
				.memToReg(MEM_TO_REG),
				.aluOp(ALU_OP),
				.memWrite(MEM_WRITE),
				.aluSrc(ALU_SRC),
				.regWrite(REG_WRITE));
	 
	 register mainrRgister(
	         .clock_in(clock_in),
				.reset(reset),
	         .readData1(reg_alu),
				.readData2(reg_dataMem),
				.readReg1(INST[25:21]),
				.readReg2(INST[20:16]),
				.writeReg(muxResDst_reg),
				.writeData(muxMem2Reg_reg),
				.regWrite(REG_WRITE));
	 
	 signext mainSignext(
	         .inst(INST[15:0]),
				.data(signext_pc));
	 
	 alu mainAlu(
				.aluRes(alu_dataMem),
				.zero(alu_pc),
				.aluCtr(aluCtr_alu),
				.input1(reg_alu),
				.input2(muxAlu_alu));
	 
	 data_memory mainData_memory(
	         .reset(reset),
	         .clock_in(clock_in),
	         .writeData(reg_dataMem),
				.address(alu_dataMem),
				.readData(dataMem_muxMem2Reg),
				.memRead(MEM_READ),
				.memWrite(MEM_WRITE));
				
	 aluCtr mainAluCtr(
	         .aluCtr(aluCtr_alu),
				.aluOp(ALU_OP),
				.funct(INST[5:0]));
	 
	 timeDivider maintimeDivider(
	     .clk(clkOld),
		  .clockOut(clock_in)
	 );
	 
	 instMemory maininstMemory(
	     .clk(clock_in),
		  .reset(reset),
		  .address(pc),
		  .readData(INST)
	 );
	 
	 assign muxMem2Reg_reg = MEM_TO_REG ? dataMem_muxMem2Reg : alu_dataMem;
	 
	 assign muxAlu_alu = ALU_SRC ? signext_pc : reg_dataMem;
	 
	 assign muxResDst_reg = REG_DST ? INST[15:11] : INST[20:16];
	 
	 assign muxCtr = (alu_pc && BRANCH) ? (signext_pc<<2 + pc + 4):(pc + 4);
	 
	 assign muxPc = JUMP ? (pc + 4)&32'b11110000000000000000000000000000|(INST[25:0] << 2) : muxCtr;
	 
	 assign reset = switch[3];
	 always
	 begin
	     case (switch[2:0])
		  3'b001:
		      led = reg_alu[7:0];
		  3'b010:
		      led = muxAlu_alu[7:0];
		  3'b011:
		     led = alu_dataMem[7:0];
		  3'b100:
		     led = muxMem2Reg_reg[7:0];
        3'b111:
		  begin
		  case(switch[5:4])
		  2'b00:
           led = INST[31:24];
		  2'b01:
		     led = INST[23:16];
		  2'b10:
		     led = INST[15:8];
		  2'b11:
		     led = INST[7:0];
        endcase
		  end
		  default:
           led = pc[7:0];
        endcase			  
	 end
	
	 
	 always @(posedge clock_in)
	 begin
	     if (reset)
		      pc <= 0;
	     else if (alu_pc && BRANCH)
	         pc <= muxCtr;
		  else if (JUMP)
		      pc <= muxPc;
		  else
		      pc <= pc + 4;
	 end

endmodule
