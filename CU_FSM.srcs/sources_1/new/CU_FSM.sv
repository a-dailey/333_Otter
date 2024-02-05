`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 02/21/2023 07:39:26 AM
// Design Name: 
// Module Name: CU_FSM
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


module CU_FSM(
input logic rst, intr, clk,
input logic [2:0] funct3,
input logic [6:0] opcode,
output logic PCWrite, regWrite, memWE2, memRDEN1,
 memRDEN2, reset, csr_WE, int_taken, mret_exec
    );
typedef enum{ST_INIT, ST_FETCH, ST_EXEC, ST_WB, ST_INTRPT} state_type;
state_type PS, NS;

always_ff @(posedge clk) begin
    if (rst == 1) begin
    PS <= ST_INIT;
    end 
    else begin
    PS <= NS;
    end
end

always_comb begin
    PCWrite = 0;
    regWrite = 0;
    memWE2 = 0;
    memRDEN1 = 0;
    memRDEN2 = 0;
    reset = 0;
    csr_WE = 0;
    int_taken = 0;
    mret_exec = 0;
    NS = ST_INIT;
    case(PS)
    ST_INIT: begin
        reset = 1;
        NS = ST_FETCH;
        PCWrite = 0;
        end 
    ST_FETCH: begin
        reset = 0;
        memRDEN1 = 1;
        PCWrite = 0;
        NS = ST_EXEC;
        end  
    ST_EXEC: begin
        reset = 0;
        memRDEN1 = 0;

        case(opcode) 
        7'b0110011: begin //R-type
            regWrite = 1;
            PCWrite = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            
            end
        7'b0010011: begin //I-type
            regWrite = 1;
            PCWrite = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
        7'b0100011: begin //S-type
            regWrite = 0;
            PCWrite = 1;
            memWE2 = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end 
        7'b0000011: begin //I-type load instructions
            regWrite = 0;
            PCWrite = 0;
            memRDEN2 = 1;
            NS = ST_WB;
            end 
       7'b1100011: begin //B-type
            regWrite = 0;
            PCWrite = 1;
            memWE2 = 0;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
       7'b0110111: begin //lui
            regWrite = 1;
            PCWrite = 1;
            memWE2 = 0;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
       7'b0010111: begin //auipc
            regWrite = 1;
            PCWrite = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
       7'b1100111: begin //jalr
            regWrite = 1;
            PCWrite = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
       7'b1101111: begin //jal
            regWrite = 1;
            PCWrite = 1;
            if (intr) NS = ST_INTRPT;
            else NS = ST_FETCH;
            end
            
        7'b1110011: begin
            if (funct3 == 3'b000) begin  //mret
                    mret_exec = 1;
                    PCWrite = 1;
                    NS = ST_FETCH;
                    end
                else begin
                    csr_WE = 1;
                    PCWrite = 1;
                    regWrite = 1;
                    if (intr)
                        NS = ST_INTRPT;
                    else
                        NS = ST_FETCH;
                end

            end
        default: NS = ST_INIT;
                     
        endcase   //end opcode case    
    end // end exec st
    ST_WB: begin
        regWrite = 1;
        PCWrite = 1;
        if (intr) 
            NS = ST_INTRPT;
        else 
            NS = ST_FETCH;
        end
    ST_INTRPT: begin
        int_taken =  1;
        PCWrite = 1;
        NS = ST_FETCH;    
        end
endcase // end ps case
end  //end always_comb                  
endmodule
