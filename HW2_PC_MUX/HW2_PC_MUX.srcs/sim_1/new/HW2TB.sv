`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2023 09:20:12 PM
// Design Name: 
// Module Name: MUX
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


module HW2TB();
    logic clk, rst, pc_write;
    logic [31:0] JALR, BRANCH, JAL, MTVEC, MEPC, PC_CNT;
    logic [2:0] select;
    
    
    top_pc UUT (.clk(clk), .rst(rst), .PC_WRITE(pc_write),
     .select(select), .JALR(JALR), .BRANCH(BRANCH), .JAL(JAL), 
     .MTVEC(MTVEC), .MEPC(MEPC), .pc_cnt(PC_CNT)); 
     
     always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        
        
     end
     
     initial begin
    rst = 1;
    pc_write = 0;
    select = 0;
    
    #10
    rst = 0;
    pc_write = 0;
    select = 0;
   
    
    #10
    rst = 0;
    pc_write = 0;
    select = 0;
    
    #10
    rst = 0;
    pc_write = 0;
    select = 0;
    
    #10
    rst = 0;
    pc_write = 0;
    select = 0;
    
    #10
    rst = 0;
    pc_write = 0;
    JALR = 12;
    select = 5;
    
    #10
    rst = 1;
    pc_write = 0;
    select = 0;
    
    
    #10
    rst = 0;
    pc_write = 0;
    select = 0;
    
    #10
    rst = 0;
    pc_write = 1;
    select = 5;
    
    #10
    rst = 0;
    pc_write = 1;
    JALR = 12;
    select = 5;
    
    #10
    rst = 0;
    pc_write = 1;
    select = 5;
    
    end
endmodule