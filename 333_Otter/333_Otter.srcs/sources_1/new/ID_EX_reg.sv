module ID_EX_reg(
    input CLK,
    input logic [4:0] RdD,
    input logic [31:0] PCD, PCPlus4D, de_ex_opA, de_ex_opB,
    output logic [31:0] PCE, PCPlus4E, ex_mem_opA, ex_mem_opA

    );
    
    always_ff @(posedge CLK) begin
        PCE <= PCD;
        PCPlus4E <= PCPlus4D;
        
    end
        
endmodule