`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 09:57:04 PM
// Design Name: 
// Module Name: FORWARD_MUX_A
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


module FORWARD_MUX_A(
    input logic [1:0] forward_sel_A,
    input logic [31:0] rs1E, rs1M, rs1W,
    output logic [31:0] rs1_out
    );
    
    always_comb begin
        case (forward_sel_A)
            2'b00: rs1_out = rs1E;
            2'b01: rs1_out = rs1M;
            2'b10: rs1_out = rs1W;
         endcase
    end
endmodule
