`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2023 03:01:45 PM
// Design Name: 
// Module Name: otterMCU_TB
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


module otterMCU_TB();
    
logic clk, rst, intr, IOBUS_WR;
logic [31:0] IOBUS_IN, IOBUS_OUT, IOBUS_ADDR;

OTTERMCU UUT(.clk(clk), .rst(rst), .intr(intr), .IOBUS_WR(IOBUS_WR), .IOBUS_IN(IOBUS_IN), .IOBUS_OUT(IOBUS_OUT),
 .IOBUS_ADDR(IOBUS_ADDR));

always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        end

initial begin 
    rst = 1;
    intr = 0;
    IOBUS_WR = 0;
    IOBUS_IN = 2;
    IOBUS_ADDR = 0;
    #10
    rst = 0;
    intr = 0;
    IOBUS_WR = 0;
    IOBUS_IN = 0;
    IOBUS_ADDR = 0;
    #5000
    IOBUS_IN = 0;
    intr = 0;
    #80
    intr = 0;
    
    
    end
    
endmodule
