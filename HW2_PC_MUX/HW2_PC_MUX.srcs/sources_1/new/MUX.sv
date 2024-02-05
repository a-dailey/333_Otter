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


module MUX #(parameter WIDTH=32) (
    input  wire [WIDTH-1:0] JALR, BRANCH, JAL, MTVEC, MEPC, PC_CNT,
    input  wire [2:0] select,
    output reg [WIDTH-1:0] out
);

    always_comb begin
        case (select)
        0 : out = PC_CNT + 4;
        1 : out = JALR;
        2 : out = BRANCH;
        3 : out = JAL;
        4 : out = MTVEC;
        5 : out = MEPC;
        default: out = PC_CNT + 4;
        endcase
    end
endmodule
