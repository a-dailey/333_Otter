`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 10:40:55 AM
// Design Name: 
// Module Name: OTTER_MCU
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


module OTTERMCU(
input logic rst, intr, clk,
input logic [31:0] IOBUS_IN,
output logic IOBUS_WR,
output logic [31:0] IOBUS_OUT, IOBUS_ADDR
    );
    
    logic PCWrite, regWrite, memWE2, memRDEN1, memRDEN2, reset, 
    csr_WE, int_taken, mret_exec,
    br_eq, br_lt, br_ltu, mie, interrupt;
    
    logic [3:0] alu_fun;
    logic [2:0] alu_srcB, pcSource;
    logic [1:0] alu_srcA, rf_wr_sel;
    logic [31:0] pc, DOUT2, rs1, rs2, u_type, i_type, s_type, b_type, 
    j_type, srcA, srcB, ir, pc_mux_out, jal, branch, jalr, mtvec, mepc, 
    alu_result, rf_wd, mstatus, csr_rd;
    
    assign IOBUS_OUT = rs2;
    assign IOBUS_ADDR = alu_result;
    
    top_pc programcontrol(.clk(clk), .rst(reset), .PC_WRITE(PCWrite), 
    .select(pcSource), .JALR(jalr), .BRANCH(branch), 
    .JAL(jal), .MTVEC(mtvec), .MEPC(mepc), .pc_cnt(pc));
    
    Memory mem(.MEM_CLK(clk), .MEM_RDEN1(memRDEN1), .MEM_RDEN2(memRDEN2), .MEM_WE2(memWE2), 
    .MEM_ADDR1(pc[15:2]), .MEM_ADDR2(alu_result), .MEM_DIN2(rs2), .MEM_SIZE(ir[13:12]),
    .MEM_SIGN(ir[14]), .IO_IN(IOBUS_IN), .IO_WR(IOBUS_WR), .MEM_DOUT1(ir), 
    .MEM_DOUT2(DOUT2));
    
    
    reg_file reg_file(.clk(clk), .rf_adr1(ir[19:15]), .rf_adr2(ir[24:20]), .rf_we(regWrite), 
    .rf_wa(ir[11:7]), .rf_wd(rf_wd), .rf_rs1(rs1), .rf_rs2(rs2));
    
    IMMED_GEN immed_gen(.instruct(ir), .u_type(u_type), .i_type(i_type),
     .s_type(s_type), .b_type(b_type), .j_type(j_type));
    
    BRANCH_ADDR_GEN branch_addr_gen(.pc(pc), .J_TYPE(j_type), .B_TYPE(b_type), .I_TYPE(i_type), 
    .rs1(rs1), .jalr(jalr), .jal(jal), .branch(branch));
    
   ALU alu(.srcA(srcA), .srcB(srcB), .alu_fun(alu_fun), .result(alu_result));
   
   BRANCH_COND_GEN branch_cond_gen(.a(rs1), .b(rs2), .br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu));
   
   CU_DCDR cu_dcdr(.br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu), .funct3(ir[14:12]),
    .opcode(ir[6:0]), .int_taken(int_taken), .ir30(ir[30]), .rf_wr_sel(rf_wr_sel), 
    .alu_srcA(alu_srcA), .alu_srcB(alu_srcB), .pcSource(pcSource), .alu_fun(alu_fun));
    
   rf_mux rf_mux(.pc4(pc), .csr_RD(csr_rd), .DOUT2(DOUT2), .alu_result(alu_result), 
   .rf_wr_sel(rf_wr_sel), .wd(rf_wd));
   
   alu_muxA alu_muxA(.rs1(rs1), .u_type(u_type), .alu_srcA(alu_srcA), .srcA(srcA)); 
   
   alu_muxB alu_muxB(.alu_srcB(alu_srcB), .rs2(rs2), .i_type(i_type), .s_type(s_type),
    .pc(pc), .csr_RD(csr_rd), .srcB(srcB)); 
    
    CU_FSM cu_fsm(.rst(rst), .intr(interrupt), .clk(clk), .funct3(ir[14:12]), .opcode(ir[6:0]), 
    .PCWrite(PCWrite), .regWrite(regWrite), .memWE2(memWE2), .memRDEN1(memRDEN1), 
    .memRDEN2(memRDEN2), .reset(reset), .csr_WE(csr_WE), .int_taken(int_taken), .mret_exec(mret_exec));
    
    intrpt_and interrupt_and(.intr(intr), .mie(mie), .interrupt(interrupt));
    
    CSR csr(.rst(reset), .clk(clk), .mret_exec(mret_exec), .int_taken(int_taken), 
    .csr_we(csr_WE), .addr(ir[31:20]), .pc(pc), .wd(alu_result), .mstatus(mstatus), .mepc(mepc), .mtvec(mtvec), 
    .rd(csr_rd), .mie(mie));
     
endmodule
