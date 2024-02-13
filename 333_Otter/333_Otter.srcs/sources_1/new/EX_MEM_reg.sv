module EX_MEM_reg(
    input CLK, RESET,
    
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
         if (RESET) begin
            //pc
            PCM <= 32'b0;
            PCPlus4M <= 32'b0;
            
            //Reg File
            rf_waM <= 5'b0;
            rs1M <= 32'b0;
            rs2M <= 32'b0;
            rf_wr_selM <= 2'b0;
            regWriteM <= 1'b0 ;
            
            //ALU
            alu_resM <= 32'b0;
            
            //memory
            memWE2M <= 1'b0;
            InstrM <= 32'b0;      
            
            end
            else begin
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
        
        
    end
        
endmodule