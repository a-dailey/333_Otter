`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:  Austin Dailey
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


    //pc wires
    wire [2:0] pcSource;
    wire [31:0] pc, PCF, PCD, PCE, PCM, PCW, PCPlus4F, PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W;
   
   
    //reg file wires
    wire regWriteD, regWriteE, regWriteM, regWriteW;
    wire [1:0] rf_wr_selD, rf_wr_selE, rf_wr_selM, rf_wr_selW;
    wire [4:0] rf_waE, rf_waM, rf_waW;
    wire [31:0] rf_wdW, rf_wdM, rs1D, rs2D, rs1E, rs2E, rs1M, rs2M, rs1_out, rs2_out;
   
   
    //memory wires
    wire memWE2D, memWE2E, memWE2M;
    wire memRDEN2D, memRDEN2E, memRDEN2M;
    wire [31:0] IR, InstrD, InstrE, InstrM, DOUT2M, DOUT2W;
    wire memRead1,memRead2;
    //dcdr wires
    wire int_takenD;
   
    //alu wires
    wire [1:0] alu_control_A;
    wire [2:0] alu_control_B;
    wire [3:0] alu_funD, alu_funE;
    wire [31:0] alu_srcAD, alu_srcAE, alu_srcBD, alu_srcBE, alu_resE, alu_resM, alu_resW;
   
    //branch addr gen wires
    wire [31:0] jalr, jal, branch;
   
    //branch cond gen wries
    wire br_lt, br_ltu, br_eq;
   
    //immed gen wries
    wire [31:0] j_typeD, i_typeD, s_typeD, u_typeD, b_typeD, j_typeE, i_typeE, s_typeE, u_typeE, b_typeE;
   
    assign csr_rd = 32'b0;
   
             
//==== Instruction Fetch ===========================================


     logic [31:0] if_de_pc, if_de_pc4;
     
     always_ff @(posedge CLK) begin
                if_de_pc <= pc;
                if_de_pc4 <= pc + 4;
     end
//    PC_REG pc_reg (.CLK(CLK), .PC(pc), .PCF(PCF), .PCPlus4F(PCPlus4F));
     
     assign mtvec = 32'b0;
     assign mepc = 32'b0;
     
     top_pc programcontrol(.clk(CLK), .rst(RESET), .PC_WRITE(pcWrite),
    .select(pcSource), .JALR(jalr), .BRANCH(branch),
    .JAL(jal), .MTVEC(mtvec), .MEPC(mepc), .pc_cnt(pc));
     
     assign pcWrite = 1'b1;     //Hardwired high, assuming no hazards
     assign memRead1 = 1'b1;    //Fetch new instruction every cycle
     


    Memory mem(.MEM_CLK(CLK), .MEM_RDEN1(memRead1), .MEM_RDEN2(memRDEN2M), .MEM_WE2(memWE2M),
    .MEM_ADDR1(if_de_pc[15:2]), .MEM_ADDR2(alu_resM), .MEM_DIN2(rs2M), .MEM_SIZE(InstrM[13:12]),
    .MEM_SIGN(InstrM[14]), .IO_IN(IOBUS_IN), .IO_WR(IOBUS_WR), .MEM_DOUT1(IR),
    .MEM_DOUT2(DOUT2M));






     
//==== Instruction Decode ===========================================
    logic [31:0] de_ex_opA;
    logic [31:0] de_ex_opB;
    logic [31:0] de_ex_rs2;
   
    assign pc4 = pc + 4;


    instr_t de_ex_inst, de_inst;
   
    //register stores PCF, PC+4, Instr from mem
    IF_DEC_reg if_dec_reg (.CLK(CLK), .RESET(RESET), .PCF(if_de_pc), .PCPlus4F(if_de_pc4), .IR(IR),
     .InstrD(InstrD), .PCD(PCD), .PCPlus4D(PCPlus4D));
   
    CU_DCDR_EXTENDED cu_dcdr_extended(.br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu), .funct3(InstrD[14:12]),
    .opcode(InstrD[6:0]), .int_taken(int_takenD), .ir30(InstrD[30]), .rf_wr_sel(rf_wr_selD),
    .alu_srcA(alu_control_A), .alu_srcB(alu_control_B), .alu_fun(alu_funD),
    //added signals from FSM
    .regWrite(regWriteD), .memWE2(memWE2D), .memRDEN2(memRDEN2D)
    ); //removed .pcSource(pcSource)
   
//     CU_FSM cu_fsm(.rst(rst), .intr(interrupt), .clk(CLK), .funct3(InstrD[14:12]), .opcode(InstrD[6:0]),
//    .PCWrite(PCWrite), .regWrite(regWriteD), .memWE2(memWE2D), .memRDEN1(memRDEN1),
//    .memRDEN2(memRDEN2D), .reset(reset), .csr_WE(csr_WE), .int_taken(int_taken), .mret_exec(mret_exec));
   
     reg_file reg_file(.clk(CLK), .rf_adr1(InstrD[19:15]), .rf_adr2(InstrD[24:20]), .rf_we(regWriteM),
    .rf_wa(rf_waM), .rf_wd(rf_wdM), .rf_rs1(rs1D), .rf_rs2(rs2D));
    
    FORWARD_MUX_A forward_mux_a(.rs1E(rs1E), .rs1M(rs1M), .rs1W(rs1W), .forward_sel_A(forward_sel_A), .rs1_out(rs1_out));
   
//    alu_muxA alu_muxA(.rs1(rs1D), .u_type(u_typeD), .alu_srcA(alu_control_A), .srcA(alu_srcAD));
    alu_muxA alu_muxA(.rs1(rs1_out), .u_type(u_typeD), .alu_srcA(alu_control_A), .srcA(alu_srcAD));
     
    
//    alu_muxB alu_muxB(.alu_srcB(alu_control_B), .rs2(rs2D), .i_type(i_typeD), .s_type(s_typeD),
//    .pc(PCD), .csr_RD(csr_rd), .srcB(alu_srcBD));
    FORWARD_MUX_B forward_mux_b (.rs2E(rs2E), .rs2M(rs2M), .rs2W(rs2W), .forward_sel_B(forward_sel_B), .rs2_out(rs2_out));

    alu_muxB alu_muxB(.alu_srcB(alu_control_B), .rs2(rs2_out), .i_type(i_typeD), .s_type(s_typeD),
    .pc(PCD), .csr_RD(csr_rd), .srcB(alu_srcBD));
    
    HAZARD_UNIT hazard_unit (.rs1E(rs1D), .rs2E(rs2D), .rdM(rf_waE), .rdW(rf_waM), .forward_sel_A(forward_sel_A), .forward_sel_B(forward_Sel_B));
   
    IMMED_GEN immed_gen(.instruct(InstrD), .u_type(u_typeD), .i_type(i_typeD),
     .s_type(s_typeD), .b_type(b_typeD), .j_type(j_typeD));
   
//    opcode_t OPCODE;
//    assign OPCODE_t = opcode_t'(opcode);
   
//    assign de_inst.rs1_addr=IR[19:15];
//    assign de_inst.rs2_addr=IR[24:20];
//    assign de_inst.rd_addr=IR[11:7];
//    assign de_inst.opcode=OPCODE;
   
//    assign de_inst.rs1_used=    de_inst.rs1 != 0
//                                && de_inst.opcode != LUI
//                                && de_inst.opcode != AUIPC
//                                && de_inst.opcode != JAL;


     
   
   
   
//==== Execute ======================================================
//     logic [31:0] ex_mem_rs2;
//     logic [31:0] ex_mem_aluRes;
//     instr_t ex_mem_inst;
//     logic [31:0] opA_forwarded;
//     logic [31:0] opB_forwarded;
     
     ID_EX_reg id_ex_reg(
     .CLK(CLK),
     //inputs
     .InstrD(InstrD),
     .rf_waD(InstrD[11:7]), .rf_wr_selD(rf_wr_selD), .rs1D(rs1D), .rs2D(rs2D), .regWriteD(regWriteD),
     .PCD(PCD), .PCPlus4D(PCPlus4D),
     .alu_srcAD(alu_srcAD), .alu_srcBD(alu_srcBD), .alu_funD(alu_funD),
     .j_typeD(j_typeD), .b_typeD(b_typeD), .i_typeD(i_typeD),
     .memRDEN2D(memRDEN2D), .memWE2D(memWE2D),
     
     //outputs
     .InstrE(InstrE),
     .rf_waE(rf_waE), .rf_wr_selE(rf_wr_selE), .rs1E(rs1E), .rs2E(rs2E), .regWriteE(regWriteE),
     .PCE(PCE), .PCPlus4E(PCPlus4E),
     .alu_srcAE(alu_srcAE), .alu_srcBE(alu_srcBE), .alu_funE(alu_funE),
     .j_typeE(j_typeE), .b_typeE(b_typeE), .i_typeE(i_typeE),
     .memRDEN2E(memRDEN2E), .memWE2E(memWE2E)
     );
     
     BRANCH_ADDR_GEN branch_addr_gen (.pc(PCE), .J_TYPE(j_typeE), .B_TYPE(b_typeE), .I_TYPE(i_typeE),
    .rs1(rs1D), .jalr(jalr), .jal(jal), .branch(branch));
   
     BRANCH_COND_GEN branch_cond_gen(.a(rs1E), .b(rs2E), .br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu));
     
     PC_SRC_CONTROL pc_src_control(.br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu), .InstrE(InstrE), .pcSource(pcSource));
     
     // Creates a RISC-V ALU
     ALU alu(.srcA(alu_srcAE), .srcB(alu_srcBE), .alu_fun(alu_funE), .result(alu_resE));
     








//==== Memory ======================================================
     EX_MEM_reg ex_mem_reg(
     .CLK(CLK),
     //inputs
     .rf_waE(rf_waE), .PCE(PCE), .PCPlus4E(PCPlus4E), .alu_resE(alu_resE), .rs1E(rs1E), .rs2E(rs2E), .rf_wr_selE(rf_wr_selE), .regWriteE(regWriteE), .memWE2E(memWE2E), .InstrE(InstrE), .memRDEN2E(memRDEN2E),
   
     //outputs
     .rf_waM(rf_waM), .PCM(PCM), .PCPlus4M(PCPlus4M), .alu_resM(alu_resM), .rs1M(rs1M), .rs2M(rs2M), .rf_wr_selM(rf_wr_selM), .regWriteM(regWriteM), .memWE2M(memWE2M), .InstrM(InstrM), .memRDEN2M(memRDEN2M)
     );
     
     
         
    assign IOBUS_ADDR = alu_resM;
    assign IOBUS_OUT = rs2M;
   
 
 
 
     
//==== Write Back ==================================================


    MEM_WB_reg mem_wb_reg(
    .CLK(CLK),
    //inputs
    .rf_waM(rf_waM), .PCM(PCM), .PCPlus4M(PCPlus4M), .alu_resM(alu_resM), .rf_wr_selM(rf_wr_selM), .regWriteM(regWriteM), .DOUT2M(DOUT2M),
   
    //outputs
    .rf_waW(rf_waW), .PCW(PCW), .PCPlus4W(PCPlus4W), .alu_resW(alu_resW), .rf_wr_selW(rf_wr_selW), .regWriteW(regWriteW), .DOUT2W(DOUT2W)
    );
   
//    rf_mux rf_mux(.pc4(PCPlus4), .csr_RD(csr_rd), .DOUT2(DOUT2W), .alu_result(alu_resW),
//   .rf_wr_sel(rf_wr_selW), .wd(rf_wdW));
   
   rf_mux rf_mux(.pc4(PCPlus4M), .csr_RD(csr_rd), .DOUT2(DOUT2M), .alu_result(alu_resM),
   .rf_wr_sel(rf_wr_selM), .wd(rf_wdM));    
endmodule
