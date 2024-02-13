`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 11:13:10 AM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk,
    input logic [4:0] rf_adr1,
    input logic [4:0] rf_adr2,
    input logic rf_we,
    input logic [4:0] rf_wa,
    input logic [31:0] rf_wd,
    output logic [31:0] rf_rs1,
    output logic [31:0] rf_rs2
    );
    logic [31:0] ram [0:31];
    logic [31:0] x5, x8, a0, x12, x13, s0, s1, s2, s3, s4, t0, t1;
    assign x5 = ram[5'b00101];
    assign x8 = ram[5'b01000];
    assign a0 = ram[5'b01010];
    assign x12 = ram[5'b01100];
    assign x13 = ram[5'b01101];
    assign s0 = ram[5'b01000];
    assign s1 = ram[5'b01001];
    assign s2 = ram[5'b10010];
    assign s3 = ram[5'b10011];
    assign s4 = ram[5'b10100];
    assign t0 = ram[5'b00101];
    assign t1 = ram[5'b00110];

// Initialize the memory to be all 0s
initial begin
  int i;
  for (i=0; i<32; i=i+1) 
  begin
    ram[i] = 0;
  end
end


       assign rf_rs1 = ram[rf_adr1];
       assign rf_rs2 = ram[rf_adr2];

    
always_ff @(posedge clk)
    begin
        if (rf_wa != 5'b00000 && rf_we == 1'b1)
        begin
            ram[rf_wa] <= rf_wd;
        end 
    end


endmodule
