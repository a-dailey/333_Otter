`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 01/19/2023 09:20:12 PM
// Design Name: 
// Module Name: MUX
// Project Name: HW2
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
    input  logic [WIDTH-1:0] JALR, BRANCH, JAL, MTVEC, MEPC, PC_CNT,
    input  logic [2:0] select,
    output logic [WIDTH-1:0] out
);

    always_comb begin
        if (select == 0)
        out = PC_CNT + 4;
        else if (select == 1)
        out = BRANCH;
        else if (select == 2)
        out = JAL;
        else if (select == 3)
        out = MTVEC;
        else if (select == 4)
        out = MEPC;
        else if (select == 5)
        out = JALR;
        else
        out = 32'hdead;

    end
endmodule
