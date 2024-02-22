`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 09:57:04 PM
// Design Name: 
// Module Name: FORWARD_MUX_B
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


module FORWARD_MUX_B(
    input logic [1:0] forward_sel_B,
    input logic [31:0] rs2E, rs2M, rs2W,
    output logic [31:0] rs2_out
    );
    
    always_comb begin
        case (forward_sel_B)
            2'b00: rs2_out = rs2E;
            2'b01: rs2_out = rs2M;
            2'b10: rs2_out = rs2W;
            default: rs2_out = rs2E;
         endcase
    end

endmodule
