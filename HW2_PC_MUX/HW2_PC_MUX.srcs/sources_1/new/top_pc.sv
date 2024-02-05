`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 01/18/2023 08:08:31 PM
// Design Name: 
// Module Name: top_pc
// Project Name: HW2
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


module top_pc #(parameter WIDTH = 32)(
    input logic clk, rst, PC_WRITE,
    input logic [2:0] select,
    input logic [WIDTH-1:0] JALR, BRANCH, JAL, MTVEC, MEPC,
    output logic [WIDTH-1:0] pc_cnt
    
    );
    
    logic [WIDTH-1:0] mux_out;
    
    MUX mux_top(
    .JALR(JALR),
    .BRANCH(BRANCH),
    .JAL(JAL),
    .MTVEC(MTVEC),
    .MEPC(MEPC),
    .PC_CNT(pc_cnt),
    .select(select),
    .out(mux_out)); 
    
    PC pc_top(
    .clk(clk),
    .pc_rst(rst),
    .pc_write(PC_WRITE),
    .pc_din(mux_out),
    .pc_cnt(pc_cnt));
    
    
    
    
    
endmodule
