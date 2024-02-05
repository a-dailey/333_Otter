`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 04:20:56 PM
// Design Name: 
// Module Name: alu_muxA
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


module alu_muxA(
input logic [31:0] rs1, u_type,
input logic [1:0] alu_srcA,
output logic [31:0] srcA
    );
    
    always_comb begin
        case(alu_srcA)
            0: srcA = rs1;
            1: srcA = u_type;
            2: srcA = ~rs1;
            default: srcA = rs1;
            endcase
        end
endmodule
