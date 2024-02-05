`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2023 03:02:11 PM
// Design Name: 
// Module Name: intrpt_and
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


module intrpt_and(
    input logic intr, mie,
    output logic interrupt
    );
    
    always_comb begin
        interrupt = intr & mie;
        end
endmodule
