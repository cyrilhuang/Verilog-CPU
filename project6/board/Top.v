`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:44:35 03/17/2016 
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
	 input [5:0]switch,
	 input pause,
	 output reg[7:0]led
    );
	 
	 //for io
	 wire clk;
	 wire reset;
	 //assign clk = clock_in;
	 
	 //pc
	 reg [31:0] pc;
	 
	 //IF/ID
	 //wire
	 wire [31:0]IF_addPc;
	 wire [31:0]INST;
	 wire [31:0]nextPc;
	 //reg
	 reg [31:0]IF_ID_pcAdd4;
	 reg [31:0]IF_ID_inst;
	 
	 //ID/EX
	 //wire
	 wire ID_regWrite;
	 wire ID_mem2Reg;
	 wire ID_branch;
	 wire ID_memRead;
	 wire ID_memWrite;
	 wire ID_regDst;
	 wire [1:0]ID_aluOp;
	 wire ID_aluSrc;
	 wire [31:0]reg_ID1;
	 wire [31:0]reg_ID2;
	 wire [31:0]signext_ID;
	 //reg
	 reg ID_EX_regWrite;
	 reg ID_EX_mem2Reg;
	 reg ID_EX_branch;
	 reg ID_EX_memRead;
	 reg ID_EX_memWrite;
	 reg ID_EX_regDst;
	 reg [1:0]ID_EX_aluOp;
	 reg ID_EX_aluSrc;
	 reg [31:0]ID_EX_pcAdd4;
	 reg [31:0]ID_EX_readData1;
	 reg [31:0]ID_EX_readData2;
	 reg [31:0]ID_EX_signext;
	 reg [20:16]ID_EX_instHigh;
	 reg [15:11]ID_EX_instLow;
	 
	 //EX/MEM
	 //wire
	 wire [31:0]EX_addRes;
	 wire EX_zero;
	 wire [31:0]alu_EX;
	 wire [3:0]aluCtr_alu;
	 wire [31:0]muxAlu_alu;
	 wire [5:0]muxInst_EX;
	 //reg
	 reg EX_MEM_regWrite;
	 reg EX_MEM_mem2Reg;
	 reg EX_MEM_branch;
	 reg EX_MEM_memRead;
	 reg EX_MEM_memWrite;
	 reg [31:0]EX_MEM_addRes;
	 reg EX_MEM_zero;
	 reg [31:0]EX_MEM_readData2;
	 reg [4:0]EX_MEM_writeRes;
	 reg [31:0]EX_MEM_aluRes;
	 
	 //MEM/WB
	 //wire
	 wire MEM_pcSrc;
	 wire [31:0]dataMemory_WB;
	 //reg
	 reg MEM_WB_regWrite;
	 reg MEM_WB_mem2Reg;
	 reg [31:0]MEM_WB_readData;
	 reg [31:0]MEM_WB_aluRes;
	 reg [4:0]MEM_WB_writeRes;
	 
	 //WB/IF
	 wire [31:0]WB_writeData;
	 
	 //pc
	 assign IF_addPc = pc+4;
	 assign EX_addRes = ID_EX_pcAdd4 + (ID_EX_signext<<2);
	 assign MEM_pcSrc = EX_MEM_branch & EX_MEM_zero;
	 //mux
	 assign nextPc = MEM_pcSrc ? EX_MEM_addRes : IF_addPc;
	 assign muxAlu_alu = ID_EX_aluSrc ? ID_EX_signext : ID_EX_readData2;
	 assign muxInst_EX = ID_EX_regDst ? ID_EX_instLow : ID_EX_instHigh;
	 assign WB_writeData = MEM_WB_mem2Reg ? MEM_WB_readData : MEM_WB_aluRes;
	 
	 //board
	 reg p_flag;
	 assign reset = switch[3];
	  
	 always
	 begin
	 case (switch[2:0])
	     3'b001: led = dataMemory_WB[7:0];
		  3'b010: led = reg_ID1[7:0];
		  3'b011: led = alu_EX[7:0];
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
		  default: led = pc[9:2];
	 endcase
	 end
	 
	 always @(posedge pause)
	     p_flag = ~p_flag;
	 
	 
	 initial
	 begin
	     pc = 0;
		  IF_ID_pcAdd4 = 0;
	     IF_ID_inst = 0;
	     ID_EX_regWrite = 0;
	     ID_EX_mem2Reg = 0;
	     ID_EX_branch = 0;
	     ID_EX_memRead = 0;
	     ID_EX_memWrite = 0;
	     ID_EX_regDst = 0;
	     ID_EX_aluOp = 0;
	     ID_EX_aluSrc = 0;
	     ID_EX_pcAdd4 = 0;
	     ID_EX_readData1 = 0;
	     ID_EX_readData2 = 0;
	     ID_EX_signext = 0;
	     ID_EX_instHigh = 0;
	     ID_EX_instLow = 0;
	     EX_MEM_regWrite = 0;
	     EX_MEM_mem2Reg = 0;
	     EX_MEM_branch = 0;
	     EX_MEM_memRead = 0;
	     EX_MEM_memWrite = 0;
	     EX_MEM_addRes = 0;
	     EX_MEM_zero = 0;
	     EX_MEM_readData2 = 0;
	     EX_MEM_writeRes = 0;
	     EX_MEM_aluRes = 0;
	     MEM_WB_regWrite = 0;
	     MEM_WB_mem2Reg = 0;
	     MEM_WB_readData = 0;
	     MEM_WB_aluRes = 0;
	     MEM_WB_writeRes = 0;
	 end
	 
	 
	 timeDivider maintimeDivider(
	     .clk(clock_in),
		  .pause(p_flag),
		  .clockOut(clk)
	 );
	 
	 Ctr mainctr(
	     .opCode(IF_ID_inst[31:26]),
		  .regDst(ID_regDst),
		  .aluSrc(ID_aluSrc),
		  .memToReg(ID_mem2Reg),
		  .regWrite(ID_regWrite),
		  .memRead(ID_memRead),
		  .memWrite(ID_memWrite),
		  .branch(ID_branch),
		  .aluOp(ID_aluOp)
	 );
	 
	 alu mainalu(
	     .input1(ID_EX_readData1),
		  .input2(muxAlu_alu),
		  .aluCtr(aluCtr_alu),
		  .zero(EX_zero),
		  .aluRes(alu_EX)
	 );
	 
	 aluCtr mainaluCtr(
	     .aluOp(ID_EX_aluOp),
		  .funct(ID_EX_signext[5:0]),
		  .aluCtr(aluCtr_alu)
	 );
	 
	 data_memory maindataMemory(
	     .reset(reset),
	     .clock_in(clk),
		  .address(EX_MEM_aluRes),
		  .writeData(EX_MEM_readData2),
		  .memWrite(EX_MEM_memWrite),
		  .memRead(EX_MEM_memRead),
		  .readData(dataMemory_WB)
	 );
	 
	 instMemory maininstMem(
	     .address(pc),
		  .clk(clk),
		  .reset(reset),
		  .readData(INST)
	 );
	 
	 register mainregister(
	     .reset(reset),
	     .clock_in(clk),
		  .readReg1(IF_ID_inst[25:21]),
		  .readReg2(IF_ID_inst[20:16]),
		  .writeReg(MEM_WB_writeRes),
		  .writeData(WB_writeData),
		  .regWrite(MEM_WB_regWrite),
		  .readData1(reg_ID1),
		  .readData2(reg_ID2)
	 );
	 
	 signext mainsignext(
	     .inst(IF_ID_inst[15:0]),
		  .data(signext_ID)
	 );
	 
	 always @(posedge clk)
	 begin
	     if (reset == 1) pc <= 0;
		  else if (!p_flag)
		  begin
		      pc <= nextPc;
				//IF/ID
				IF_ID_pcAdd4 <= IF_addPc;
	         IF_ID_inst <= INST;
	         //ID/EX
				ID_EX_regWrite <= ID_regWrite;
	         ID_EX_mem2Reg <= ID_mem2Reg;
	         ID_EX_branch <= ID_branch;
	         ID_EX_memRead <= ID_memRead;
	         ID_EX_memWrite <= ID_memWrite;
	         ID_EX_regDst <= ID_regDst;
	         ID_EX_aluOp <= ID_aluOp;
	         ID_EX_aluSrc <= ID_aluSrc;
	         ID_EX_pcAdd4 <= IF_addPc;
	         ID_EX_readData1 <= reg_ID1;
	         ID_EX_readData2 <= reg_ID2;
	         ID_EX_signext <= signext_ID[5:0];
	         ID_EX_instHigh <= IF_ID_inst[20:16];
	         ID_EX_instLow <= IF_ID_inst[15:11];
	         //EX/MEM
				EX_MEM_regWrite <= ID_EX_regWrite;
	         EX_MEM_mem2Reg <= ID_EX_mem2Reg;
	         EX_MEM_branch <= ID_EX_branch;
	         EX_MEM_memRead <= ID_EX_memRead;
	         EX_MEM_memWrite <= ID_EX_memWrite;
	         EX_MEM_addRes <= EX_addRes;
	         EX_MEM_zero <= EX_zero;
	         EX_MEM_readData2 <= ID_EX_readData2;
	         EX_MEM_writeRes <= muxInst_EX;
	         EX_MEM_aluRes <= alu_EX;
	         //MEM/WB
				MEM_WB_regWrite <= EX_MEM_regWrite;
	         MEM_WB_mem2Reg <= EX_MEM_mem2Reg;
	         MEM_WB_readData <= dataMemory_WB;
	         MEM_WB_aluRes <= EX_MEM_aluRes;
	         MEM_WB_writeRes <= EX_MEM_writeRes;
		  end
	 end


endmodule
