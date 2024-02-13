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


module PC #(parameter WIDTH=32) (
    input clk, pc_rst, pc_write, 
    input logic [WIDTH-1:0] pc_din,
    output logic  [WIDTH-1:0] pc_cnt);
    
    always_ff @(posedge clk) begin
        if (pc_rst) //synced reset
            begin
            pc_cnt <= 0; //resets cnt to 0
            end
        else if (pc_write)
           begin
                pc_cnt <= pc_din; //load data in
           end
        
     end
endmodule

