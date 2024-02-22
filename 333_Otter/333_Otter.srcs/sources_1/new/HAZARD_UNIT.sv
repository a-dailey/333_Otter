`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2024 09:48:42 PM
// Design Name: 
// Module Name: HAZARD_UNIT
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


module HAZARD_UNIT(
    input logic [4:0] rs1E, rs2E, rdM, rdW,
    output logic [1:0] forward_sel_A, forward_sel_B
    );
    
    always_comb begin //rs1 hazards
        if (rs1E != rdM && rs1E != rdW) begin
            forward_sel_A = 2'b00;
        end
        
        else if (rs1E == rdM) begin
            forward_sel_A = 2'b01;
        end
        else if (rs1E == rdW) begin
            forward_sel_A = 2'b10; 
        end
    end
    
    always_comb begin //rs1 hazards
        if (rs2E != rdM && rs2E != rdW) begin
            forward_sel_B = 2'b00;
        end
        
        else if (rs2E == rdM) begin
            forward_sel_B = 2'b01;
        end
        else if (rs2E == rdW) begin
            forward_sel_B = 2'b10; 
        end
    end
endmodule
