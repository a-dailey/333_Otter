`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2023 07:47:29 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb();

    logic clk;
    logic rf_we;
    logic [4:0] rf_adr1, rf_adr2, rf_wa;
    logic [31:0] rf_wd, rf_rs1, rf_rs2;
    
    
    reg_file UUT(.clk(clk), .rf_we(rf_we), .rf_adr1(rf_adr1), .rf_adr2(rf_adr2),
    .rf_wa(rf_wa), .rf_rs1(rf_rs1), .rf_rs2(rf_rs2), .rf_wd(rf_wd));
    
    always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        
        
     end
    
    initial begin
    rf_we = 1;
    rf_adr1 = 0;
    rf_adr2 = 2;
    rf_wa = 0;
    rf_wd = 4;
    
    
    #10
    rf_we = 1;
    rf_adr1 = 0;
    rf_adr2 = 2;
    rf_wa = 0;
    rf_wd = 4;
   
    
    #10
    rf_we = 1;
    rf_adr1 = 0;
    rf_adr2 = 2;
    rf_wa = 0;
    rf_wd = 6;
    
    #10
    rf_we = 0;
    rf_adr1 = 3;
    rf_adr2 = 2;
    rf_wa = 3;
    rf_wd = 4;
    
    #10
    rf_we = 0;
    rf_adr1 = 3;
    rf_adr2 = 2;
    rf_wa = 3;
    rf_wd = 4;
    
    #10
    rf_we = 1;
    rf_adr1 = 2;
    rf_adr2 = 3;
    rf_wa = 2;
    rf_wd = 7;
    
    #10
    rf_we = 0;
    rf_adr1 = 2;
    rf_adr2 = 3;
    rf_wa = 3;
    rf_wd = 12;
    
    #10
    rf_we = 0;
    rf_adr1 = 1;
    rf_adr2 = 2;
    rf_wa = 3;
    rf_wd = 9;
   
    
    end
endmodule
