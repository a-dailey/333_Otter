`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal poly
// Engineer: Austin Dailey
// 
// Create Date: 02/08/2023 10:11:23 PM
// Design Name: 
// Module Name: BRANCH_COND_GEN
// Project Name: 
// Target Devices: Basys 3
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


module BRANCH_COND_GEN(
    input logic [31:0] a, b, 
    output logic br_eq, br_lt, br_ltu
    );
    
    always_comb begin
    if (a == b) begin
        br_eq = 1;
        br_lt = 0;
        br_ltu = 0;
    end
    else if($signed(a) < $signed(b)) begin
        if (a < b) begin
        br_eq = 0;
        br_lt = 1;
        br_ltu = 1;
        end
        else begin 
        br_eq = 0;
        br_lt = 1;
        br_ltu = 0;
        end
   end
            
    else if(a < b) begin
        br_eq = 0;
        br_lt = 0;
        br_ltu = 1;
      end  
      else begin
      br_eq = 0;
        br_lt = 0;
        br_ltu = 0;
        end
    end
endmodule
