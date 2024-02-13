`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 02/21/2023 07:54:23 AM
// Design Name: 
// Module Name: CU_DCDR
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

 
module CU_DCDR(
input logic br_eq, br_lt, br_ltu, int_taken, ir30,
input logic [2:0] funct3,
input logic [6:0] opcode,
output logic [1:0] rf_wr_sel, alu_srcA,
output logic [2:0] alu_srcB, pcSource,
output logic [3:0] alu_fun
    );
    
    always_comb begin

    
    pcSource = 3'b000;
        alu_srcA = 2'b00;
        alu_srcB = 3'b000;
        rf_wr_sel = 3;
        alu_fun = 0;
    case (opcode)
    7'b0110011: begin  //R-type
        pcSource = 3'b000;
        alu_srcA = 2'b00;
        alu_srcB = 3'b000;
        rf_wr_sel = 3;
        case (funct3) 
            3'b000: begin  //add
                case(ir30)
                    1'b0: alu_fun = 4'b0000;
                    1'b1: alu_fun = 4'b1000;
                    default: alu_fun = 4'b0000;
                endcase
            end
             
            3'b111: alu_fun = 4'b0111;
            3'b110: alu_fun = 4'b0110;   //or
            3'b001: alu_fun = 4'b0001; //sll
            3'b010: alu_fun = 4'b0010; //slt    
            3'b011: alu_fun = 4'b0011; //sltu
            3'b101: begin //sra, srl
                case(ir30)
                    1'b1: alu_fun = 4'b1101; //sra
                    1'b0: alu_fun = 4'b0101;
                    default:alu_fun = 4'b0101;
                endcase
             end
            3'b100: alu_fun = 4'b0100;        
            default: alu_fun = 4'b1001;
           endcase 
       end
              
    7'b0010011: begin //I-type operators
        alu_srcA = 0; 
        alu_srcB = 1;
        rf_wr_sel = 3;
        pcSource = 0;
        case (funct3)
            3'b000: alu_fun = 4'b0000;

            3'b111: alu_fun = 4'b0111; //and

            3'b110: alu_fun = 4'b0110;  //or

            3'b001:  alu_fun = 4'b0001; //sll

            3'b010: alu_fun = 4'b0010; //slt    

            3'b011: alu_fun = 4'b0011; //sltu

            3'b101: begin //sra, srl
                case(ir30)
                    1'b1: alu_fun = 4'b1101; //sra
                    1'b0: alu_fun = 4'b0101;
                    default: alu_fun = 4'b0101;
                endcase
            end
            3'b100: alu_fun = 4'b0100;         
            default: alu_fun = 4'b1001;
            endcase
       end
                
         7'b0000011: begin //load instructions
            rf_wr_sel = 2;
            alu_fun = 4'b0000;
            alu_srcA = 0;
            alu_srcB = 1;
            pcSource = 0;
            end
        7'b0100011: begin //S-type
            pcSource = 0;
            alu_fun = 4'b0000;
            alu_srcA = 0;
            alu_srcB = 2;
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
                alu_fun = 4'b0000;
                alu_srcA = 0;
                alu_srcB = 1;
                pcSource = 1;
                rf_wr_sel = 0;
                end
                
           7'b0110111: begin //lui
                alu_srcA = 1;
                alu_fun = 4'b1001;
                rf_wr_sel = 3;
                pcSource = 0;
                end
            7'b0010111: begin //auipc
                alu_fun = 4'b0000;
                alu_srcA = 1;
                alu_srcB = 3;
                rf_wr_sel = 3;
                pcSource = 0;
                end
            7'b1101111: begin //jal
                alu_fun = 4'b0000;
                alu_srcA = 0;
                alu_srcB = 1;
                pcSource = 3;
                rf_wr_sel = 0;
                end
            7'b1110011: begin //csr
                case (funct3) 
                3'b000: pcSource = 5; //mret
                3'b001: begin //csrrw
                    rf_wr_sel = 1;
                    alu_srcA = 0;
                    alu_fun = 4'b1001;
                    end
                3'b010: begin  //csrrs
                    rf_wr_sel = 1;
                    alu_srcB = 4;
                    alu_srcA = 0;
                    alu_fun = 4'b0110;
                    end 
                3'b011: begin //csrrc
                    rf_wr_sel = 1;
                    alu_srcB = 4;
                    alu_srcA = 2;
                    alu_fun = 4'b0111;
                    end                   
                default: begin
                    rf_wr_sel = 1;
                    alu_srcA = 0;
                    alu_srcB = 4;
                    alu_fun = 4'b1001;
                    end
                endcase
              end
                  
            default: begin
                alu_fun = 4'b0000;
                alu_srcA = 0;
                alu_srcB = 0;
                rf_wr_sel = 3;
                pcSource = 0;
                end
            endcase   
            
        if (int_taken == 1) begin
            pcSource = 4;
        end 
                                
end
endmodule
