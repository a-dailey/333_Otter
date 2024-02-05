`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 04:25:16 PM
// Design Name: 
// Module Name: alu_muxB
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


module alu_muxB(
input logic [2:0] alu_srcB,
input logic [31:0] rs2, i_type, s_type, pc, csr_RD,
output logic [31:0] srcB
    );
    
    always_comb begin
        case(alu_srcB)
            0: srcB = rs2;
            1: srcB = i_type;
            2: srcB = s_type;
            3: srcB = pc;
            4: srcB = csr_RD;
            default: srcB = rs2;
            endcase
        end
endmodule
