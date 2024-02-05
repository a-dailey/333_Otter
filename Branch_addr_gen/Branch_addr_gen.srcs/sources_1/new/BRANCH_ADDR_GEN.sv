`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal poly
// Engineer: Austin Dailey
// 
// Create Date: 02/08/2023 10:30:22 PM
// Design Name: 
// Module Name: BRANCH_ADDR_GEN
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


module BRANCH_ADDR_GEN(
    input logic [31:0] pc, J_TYPE, B_TYPE, I_TYPE, rs1, 
    output logic [31:0] jalr, branch, jal
    );

    
    always_comb begin
        jalr = rs1 + I_TYPE;
        branch = pc + B_TYPE;
        jal = pc + J_TYPE;
        end
    
endmodule
