`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 01/30/2023 04:42:06 PM
// Design Name: 
// Module Name: IMMED_GEN
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


module IMMED_GEN(
    input logic [31:0] instruct,
    output logic [31:0] u_type, i_type, s_type, b_type, j_type
    );
    always_comb begin
    u_type = {instruct[31:12], {12{1'b0}}};
    i_type = {{21{instruct[31]}}, instruct[30:20]};
    s_type = {{21{instruct[31]}}, instruct[30:25], instruct[11:7]};
    b_type = {{20{instruct[31]}}, instruct[7], instruct[30:25], instruct[11:8], 1'b0};
    j_type = {{12{instruct[31]}}, instruct[19:12], instruct[20], instruct[30:21], 1'b0};
    end
endmodule
