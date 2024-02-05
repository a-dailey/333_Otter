`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Austin Dailey
// 
// Create Date: 01/18/2023 08:08:31 PM
// Design Name: 
// Module Name: alu
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


module ALU (
    input logic [31:0] srcA, srcB,
    input logic [3:0] alu_fun,
    output logic [31:0] result
    );
    
    always_comb begin
    case (alu_fun) 
        0 : result = $signed(srcA) + $signed(srcB);   //A + B
        1 : result = srcA << srcB[4:0];  //logical shift A B times
        2 : if ($signed(srcA) < $signed(srcB))// set if A less than B(signed)
                result = 32'b1;
            else
                result = 32'b0;
          
        3 : if (srcA < srcB) // set if A less than B(unsigned)
                result = 32'b1;
            else
                result = 32'b0;  
                 
        4 : result = srcA ^ srcB;  // XOR
        5 : result = srcA >> srcB[4:0];  //shift right logical
        6 : result = srcA | srcB;  //A or B
        7 : result = srcA & srcB;  //A and B
        8 : result = $signed(srcA) - $signed(srcB);  //A - B
        9 : result = srcA;        // COPY
        13 : result = $signed(srcA) >>> srcB[4:0]; //shift right arithmetic
        default: result = 0;
        endcase
    end
    
endmodule
        
    