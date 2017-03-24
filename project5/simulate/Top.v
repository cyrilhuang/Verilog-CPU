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
    input clock_in,
    input reset
    );
	 
	 reg [31:0] INST;
	 reg [31:0] instMem [0:31];
	 reg [31:0] pc;
		 
		 
	 initial
	 begin
	     pc = 0;
		  instMem[0]=32'b00001000000000000000000000000100;//j 4
		  instMem[1]=32'b00000000000000000000000000000000;//noop
		  instMem[2]=32'b00000000000000000000000000000000;//noop
		  instMem[3]=32'b00000000000000000000000000000000;//noop
		  instMem[4]=32'b10101100000011000000000000000000;//sw 0 0(12) 
		  instMem[5]=32'b10101100001011000000000000000000;//sw 1 0(12)
		  instMem[6]=32'b10001100001001100000000000000000;//lw 1 0(6)
		  instMem[7]=32'b00000000000000000000000000000000;//noop
		  instMem[8]=32'b00000000001000100010000000100000;//4=1+2
		  instMem[9]=32'b00000000001000100010000000100010;//4=1-2
		  instMem[10]=32'b00000000001000100010000000100100;//4=1&2
		  instMem[11]=32'b00000000001000100010000000100101;//4=1|2
		  instMem[12]=32'b00000000001000100010000000101010;//4=1slt2
		  instMem[13]=32'b00001000000000000000000000000100;//j 4
		  instMem[14]=32'b00000000000000000000000000000000;//noop
		  instMem[15]=32'b00000000000000000000000000000000;//noop
		  instMem[16]=32'b00000000000000000000000000000000;//noop
	 end
	 
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
	 
	 assign muxMem2Reg_reg = MEM_TO_REG ? dataMem_muxMem2Reg : alu_dataMem;
	 
	 assign muxAlu_alu = ALU_SRC ? signext_pc : reg_dataMem;
	 
	 assign muxResDst_reg = REG_DST ? INST[15:11] : INST[20:16];
	 
	 assign muxCtr = (alu_pc && BRANCH) ? (signext_pc<<2 + pc + 4):(pc + 4);
	 
	 assign muxPc = JUMP ? (pc + 4)&32'b11110000000000000000000000000000|(INST[25:0] << 2) : muxCtr;
	
	 
	 always @(posedge clock_in)
	 begin
	     if (alu_pc && BRANCH)
		  begin
	         pc <= muxCtr;
				INST <= instMem[pc/4];
		  end
		  else if (JUMP)
		  begin
		      pc <= muxPc;
				INST <= instMem[pc/4];
		  end
		  else
		  begin
		      pc <= pc + 4;
				INST <= instMem[pc/4];
		  end
	 end
	 
	 always @(reset)
	 begin
	     if (reset == 1)
		      pc <= 0;
	 end


endmodule
