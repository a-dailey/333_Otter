`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 04:14:59 PM
// Design Name: 
// Module Name: rf_mux
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


module rf_mux(
input logic [1:0] rf_wr_sel,
input logic [31:0] pc4, csr_RD, DOUT2, alu_result,
output logic [31:0] wd
    );
    
    always_comb begin
        case(rf_wr_sel)
            0: wd = pc4 + 4;
            1: wd = csr_RD;
            2: wd = DOUT2;
            3: wd = alu_result;
            default: wd = pc4;
        endcase
    end
endmodule
