`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 07:17:42 PM
// Design Name: 
// Module Name: IMMED_GEN_TB
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


module IMMED_GEN_TB();
    logic clk;
    logic [31:0] instruct;
    logic [31:0] u_type, i_type, s_type, b_type, j_type;
    
    IMMED_GEN UUT(.instruct(instruct), .u_type(u_type), .i_type(i_type), 
    .s_type(s_type), .b_type(b_type), .j_type(j_type));
    
    always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        
     end
     
     initial begin
     
     instruct = {32{1'b0}};
     
     #10
     
     instruct = 32'b00001111000011110000111100001111;
     
     #10
     
     instruct = {16{2'b01}};
     
     end
     
     
endmodule
