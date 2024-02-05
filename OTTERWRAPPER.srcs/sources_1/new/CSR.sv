`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Austin Dailey
// 
// Create Date: 03/08/2023 08:23:00 PM
// Design Name: 
// Module Name: CSR
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


module CSR(
    input logic rst, clk, mret_exec, int_taken, csr_we,
    input logic [11:0] addr,
    input logic [31:0] pc, wd,
    output logic [31:0] mepc, mtvec, rd, mstatus,
    output logic mie
    );
    
    assign mie = mstatus[3];
    
    always_comb begin
        case(addr)
            12'h300: rd = mstatus;
            12'h305: rd = mtvec;
            12'h341: rd = mepc;
            default: rd = 32'b0;
            endcase
     end
    
    always_ff @(posedge clk) begin
        if (rst == 1) begin
            mstatus <= 0;
            mepc <= 0;
            mtvec <= 0;
            end
        else if (csr_we == 1 & addr == 12'h300) begin
            mstatus <= wd;
            end
        else if (csr_we == 1 & addr == 12'h305) begin
            mtvec <= wd;
            end
        else if (int_taken == 1) begin
            mstatus[7] <= mstatus[3];
            mstatus[3] <= 1'b0;
            mepc <= pc;
            end
        else if (mret_exec == 1) begin
            mstatus[3] <= mstatus[7];
            mstatus[7] <= 1'b0;   
            end
         end
         
//    always_ff @(posedge clk) begin
//        if (rst == 1)
//            mepc <= 0;
//        else if (int_taken == 1)
//            mepc <= pc;
//        end
        
//    always_ff @(posedge clk) begin
//        if (rst == 1)
//            mtvec <= 0;
//        else if (csr_we == 1 & addr == 12'h305)
//            mtvec <= wd;
//        end    
endmodule
