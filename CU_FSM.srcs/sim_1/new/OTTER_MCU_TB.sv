`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2023 06:08:36 PM
// Design Name: 
// Module Name: OTTER_MCU_TB
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


module OTTER_MCU_TB();

logic clk, intr, rst, IOBUS_WR;
logic [31:0] IOBUS_IN, IOBUS_OUT, IOBUS_ADDR;

OTTER_MCU UUT(.clk(clk), .rst(rst), .IOBUS_WR(IOBUS_WR), .IOBUS_IN(IOBUS_IN), 
.IOBUS_OUT(IOBUS_OUT), .IOBUS_ADDR(IOBUS_ADDR));
    always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        end
        
initial begin 

intr = 0;
rst = 1;
IOBUS_WR = 0;
IOBUS_IN = 0;
#10
intr = 0;
rst = 0;
IOBUS_WR = 0;
IOBUS_IN = 0;
#10
intr = 0;
rst = 0;
IOBUS_WR = 0;
IOBUS_IN = 0;
#10
intr = 0;
rst = 0;
IOBUS_WR = 0;
IOBUS_IN = 0;
end


        

endmodule
