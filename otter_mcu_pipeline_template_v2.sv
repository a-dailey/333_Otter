`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  J. Callenes
// 
// Create Date: 01/04/2019 04:32:12 PM
// Design Name: 
// Module Name: PIPELINED_OTTER_CPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

  typedef enum logic [6:0] {
           LUI      = 7'b0110111,
           AUIPC    = 7'b0010111,
           JAL      = 7'b1101111,
           JALR     = 7'b1100111,
           BRANCH   = 7'b1100011,
           LOAD     = 7'b0000011,
           STORE    = 7'b0100011,
           OP_IMM   = 7'b0010011,
           OP       = 7'b0110011,
           SYSTEM   = 7'b1110011
 } opcode_t;
        
typedef struct packed{
    opcode_t opcode;
    logic [4:0] rs1_addr;
    logic [4:0] rs2_addr;
    logic [4:0] rd_addr;
    logic rs1_used;
    logic rs2_used;
    logic rd_used;
    logic [3:0] alu_fun;
    logic memWrite;
    logic memRead2;
    logic regWrite;
    logic [1:0] rf_wr_sel;
    logic [2:0] mem_type;  //sign, size
    logic [31:0] pc;
} instr_t;

module OTTER_MCU(input CLK,
                input INTR,
                input RESET,
                input [31:0] IOBUS_IN,
                output [31:0] IOBUS_OUT,
                output [31:0] IOBUS_ADDR,
                output logic IOBUS_WR 
);           
    wire [6:0] opcode;
    wire [31:0] pc, pc_value, next_pc, jalr_pc, branch_pc, jump_pc, int_pc,A,B,
        I_immed,S_immed,U_immed,aluBin,aluAin,aluResult,rfIn,csr_reg, mem_data, InstrD;
    
    wire [31:0] IR;
    wire memRead1,memRead2;
    
    wire pcWrite,regWrite,memWrite, op1_sel,mem_op,IorD,pcWriteCond,memRead;
    wire [1:0] opB_sel, rf_sel, wb_sel, mSize;
    logic [1:0] pc_sel;
    wire [3:0]alu_fun;
    wire opA_sel;
    
    logic br_lt,br_eq,br_ltu;
              
//==== Instruction Fetch ===========================================

     logic [31:0] if_de_pc;
     always_ff @(posedge CLK) begin
                if_de_pc <= pc;
     end
     
     top_pc programcontrol(.clk(CLK), .rst(RESET), .PC_WRITE(PCWrite), 
    .select(pcSource), .JALR(jalr), .BRANCH(branch), 
    .JAL(jal), .MTVEC(mtvec), .MEPC(mepc), .pc_cnt(pc));
     
     assign pcWrite = 1'b1; 	//Hardwired high, assuming now hazards
     assign memRead1 = 1'b1; 	//Fetch new instruction every cycle
     





     
//==== Instruction Decode ===========================================
    logic [31:0] de_ex_opA;
    logic [31:0] de_ex_opB;
    logic [31:0] de_ex_rs2;

    instr_t de_ex_inst, de_inst;
    
    //register stores PCF, PC+4, Instr from mem
    IF_DEC_reg if_dec_reg (.PCF(if_de_pc), .PCPlus4F(if_De_pc + 4), .IR(IR), .InstrD(InstrD));
    
    Memory mem(.MEM_CLK(clk), .MEM_RDEN1(memRDEN1), .MEM_RDEN2(memRDEN2), .MEM_WE2(memWE2), 
    .MEM_ADDR1(if_de_pc[15:2]), .MEM_ADDR2(alu_result), .MEM_DIN2(rs2), .MEM_SIZE(IR[13:12]),
    .MEM_SIGN(IR[14]), .IO_IN(IOBUS_IN), .IO_WR(IOBUS_WR), .MEM_DOUT1(IR), 
    .MEM_DOUT2(DOUT2));
    
    CU_DCDR cu_dcdr(.br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu), .funct3(InstrD[14:12]),
    .opcode(InstrD[6:0]), .int_taken(int_taken), .ir30(InstrD[30]), .rf_wr_sel(rf_wr_sel), 
    .alu_srcA(alu_srcA), .alu_srcB(alu_srcB), .pcSource(pcSource), .alu_fun(alu_fun));
    
     reg_file reg_file(.clk(clk), .rf_adr1(InstrD[19:15]), .rf_adr2(InstrD[24:20]), .rf_we(regWrite), 
    .rf_wa(InstrD[11:7]), .rf_wd(rf_wd), .rf_rs1(rs1), .rf_rs2(rs2));
    
    alu_muxA alu_muxA(.rs1(rs1), .u_type(u_type), .alu_srcA(alu_srcA), .srcA(srcA)); 
   
    alu_muxB alu_muxB(.alu_srcB(alu_srcB), .rs2(rs2), .i_type(i_type), .s_type(s_type),
    .pc(pc), .csr_RD(csr_rd), .srcB(srcB));
    
    opcode_t OPCODE;
    assign OPCODE_t = opcode_t'(opcode);
    
    assign de_inst.rs1_addr=IR[19:15];
    assign de_inst.rs2_addr=IR[24:20];
    assign de_inst.rd_addr=IR[11:7];
    assign de_inst.opcode=OPCODE;
   
    assign de_inst.rs1_used=    de_inst.rs1 != 0
                                && de_inst.opcode != LUI
                                && de_inst.opcode != AUIPC
                                && de_inst.opcode != JAL;

     
    
	
	
//==== Execute ======================================================
     logic [31:0] ex_mem_rs2;
     logic ex_mem_aluRes = 0;
     instr_t ex_mem_inst;
     logic [31:0] opA_forwarded;
     logic [31:0] opB_forwarded;
     
     // Creates a RISC-V ALU
    OTTER_ALU ALU (de_ex_inst.alu_fun, de_ex_opA, de_ex_opB, aluResult); // the ALU
     




//==== Memory ======================================================
     
     
    assign IOBUS_ADDR = ex_mem_aluRes;
    assign IOBUS_OUT = ex_mem_rs2;
    
 
 
 
     
//==== Write Back ==================================================
     


 
 

       
            
endmodule
