`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 10:18:33 PM
// Design Name: 
// Module Name: BRANCH_COND_GEN_TB
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


module BRANCH_COND_GEN_TB();
    logic clk;
    logic [31:0] a, b;
    logic br_eq, br_lt, br_gt;
    
    BRANCH_COND_GEN UUT (.a(a), .b(b), .br_eq(br_eq), .br_lt(br_lt), .br_gt(br_gt));
    
    always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        
     end 
     
     initial begin
     a = 32'b00000000000000000000000000001010;
     b = 5;
     
     #10
     a = 5;
     b = 5;
     
     #10
     a = 5;
     b = 10;
     
     #10
     a = 0;
     b = 0;
     
     #10
     a = 0;
     b = 1;
     
     #10
     a = 1;
     b = 0;
     
     end
    
endmodule
