`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 02:24:29 PM
// Design Name: 
// Module Name: IF_DEC_reg
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


module IF_DEC_reg(
    input CLK,
    input logic [31:0] IR, PCF, PCPlus4F,
    output logic [31:0] PCD, InstrD, PCPlus4D

    );
    
    always_ff @(posedge CLK) begin
        PCD <= PCF;
        PCPlus4D <= PCPlus4F;
        InstrD <= IR;
    end
        
endmodule
