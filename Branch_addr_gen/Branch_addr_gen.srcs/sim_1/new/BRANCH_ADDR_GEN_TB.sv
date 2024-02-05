`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal poly
// Engineer: Austin Dailey
// 
// Create Date: 02/09/2023 09:24:29 AM
// Design Name: 
// Module Name: BRANCH_ADDR_GEN_TB
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


module BRANCH_ADDR_GEN_TB();
logic [31:0] pc, J_TYPE, B_TYPE, I_TYPE, branch, jalr, jal, rs1;
logic clk;

BRANCH_ADDR_GEN UUT(.pc(pc), .J_TYPE(J_TYPE), .B_TYPE(B_TYPE), .I_TYPE(I_TYPE), .rs1(rs1),
 .branch(branch), .jalr(jalr), .jal(jal));

always begin
    #5
    clk = 0;
    #5
    clk = 1;

end 

initial begin 
#10
    pc = 0;
    rs1 = 10;
    J_TYPE = 40;
    B_TYPE = 20;
    I_TYPE = 60;
#10
    pc = 80;
    rs1 = 20;
    J_TYPE = 40;
    B_TYPE = 20;
    I_TYPE = 60;
end
endmodule
