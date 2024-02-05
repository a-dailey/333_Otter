`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 07:32:33 PM
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB();
    logic clk;
    logic [3:0] alu_fun;
    logic [31:0] srcA, srcB, result;
    
    ALU UUT (.srcA(srcA), .srcB(srcB), .alu_fun(alu_fun), .result(result));
    
        always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        
     end
     
     initial begin
        srcA = 4;
        srcB = 2;
        alu_fun = 0;
        
     #10
        alu_fun = 4'b0001;
        
     #10
        alu_fun = 2;
        
     #10
        alu_fun = 3;
        
     #10
        alu_fun = 4;
        
     #10
        alu_fun = 5;
        
     #10
        alu_fun = 6;
        
     #10
        alu_fun = 7;
        
     #10
        alu_fun = 8;
        
     #10
        alu_fun = 9;
        
     #10
        alu_fun = 13;
        
     end
     
        
endmodule
