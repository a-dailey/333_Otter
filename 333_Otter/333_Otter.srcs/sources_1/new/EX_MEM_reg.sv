module EX_MEM_reg(
    input CLK,
    
    //input data signals
    input logic [4:0] rf_waE,
    input logic [31:0] PCE, PCPlus4E, alu_resE, rs1E, rs2E, InstrE,
    
    //input control signals
    input logic [1:0] rf_wr_selE,
    input logic regWriteE, memWE2E,
    
    //output data signals 
    output logic [4:0] rf_waM,
    output logic [31:0] PCM, PCPlus4M, alu_resM, rs1M, rs2M, InstrM,
    
    //output control signals
    output logic [1:0] rf_wr_selM,
    output logic regWriteM, memWE2M
    

    );
    
    always_ff @(posedge CLK) begin
        //pc
        PCM <= PCE;
        PCPlus4M <= PCPlus4E;
        
        //Reg File
        rf_waM <= rf_waE;
        rs1M <= rs1E;
        rs2M <= rs2E;
        rf_wr_selM <= rf_wr_selE;
        regWriteM <= regWriteE;
        
        //ALU
        alu_resM <= alu_resE;
        
        //memory
        memWE2M <= memWE2E;
        InstrM <= InstrE;

        
        
    end
        
endmodule