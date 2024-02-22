`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/13/2024 10:39:50 AM
// Design Name:
// Module Name: pc_src_control
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




module PC_SRC_CONTROL(
    input logic br_eq, br_lt, br_ltu, RESET,
    input [31:0] InstrE,
    output logic [2:0] pcSource
   
    );
    logic [6:0] opcode;
    logic [2:0] funct3;
    assign opcode = InstrE[6:0];
    assign funct3 = InstrE[14:12];
   
    always_comb begin
        pcSource = 0;
       
        case (opcode)
            7'b0110011: begin  //R-type
                pcSource = 0;
            end
            7'b0010011: begin //I-type operators
                pcSource = 0;
            end
            7'b0000011: begin //load instructions
                pcSource = 0;
            end
            7'b0100011: begin //S-type
                pcSource = 0;
            end
            7'b1100011: begin //B-type


           
            case(funct3)
                3'b000: begin
                    if (br_eq == 1) begin
                    pcSource = 2;
                    end
                    else begin
                    pcSource = 0;
                    end
                 end  
                3'b101: begin
                    if (br_lt == 0) begin
                        pcSource = 2;
                        end
                    else begin
                        pcSource = 0;
                        end
                end
                3'b111: begin
                    if (br_ltu == 0) begin
                        pcSource = 2;
                        end
                    else begin
                        pcSource = 0;
                        end
                    end
                3'b100: begin
                    if (br_lt == 1) begin
                        pcSource = 2;
                        end
                    else begin
                        pcSource = 0;
                        end
                end
                3'b110: begin
                    if (br_ltu == 1) begin
                        pcSource = 2;
                        end
                    else begin
                        pcSource = 0;
                        end
                 end
                 3'b001: begin
                    if (br_eq == 0) begin
                        pcSource = 2;
                        end
                    else begin
                        pcSource = 0;
                        end
                  end
                  default: pcSource = 0;
              endcase  
            end
            7'b1100111: begin //jalr
                pcSource = 1;
            end
            7'b0110111: begin //lui
               pcSource = 0;
            end
            7'b0010111: begin //auipc
                pcSource = 0;
            end
            7'b1101111: begin //jal
                pcSource = 3;
            end
            7'b1110011: begin //csr
                case (funct3)
                    3'b000: pcSource = 5; //mret
                    default: begin
                        pcSource = 0;    
                        end
                endcase
              end
                 
             
             
               
               
        endcase
     end                      
endmodule
