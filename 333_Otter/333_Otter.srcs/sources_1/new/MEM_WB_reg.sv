module MEM_WB_reg(
    input CLK, RESET,
    
    //input data signals
    input logic [4:0] rf_waM,
    input logic [31:0] PCM, PCPlus4M, alu_resM, 
    
    //input control signals
    input logic [1:0] rf_wr_selM,
    input logic regWriteM,
    
    //output data signals 
    output logic [4:0] rf_waW,
    output logic [31:0] PCW, PCPlus4W, alu_resW,
    
    //output control signals
    output logic [1:0] rf_wr_selW,
    output logic regWriteW
    

    );
    
    always_ff @(posedge CLK) begin
    
        if (RESET) begin
            //pc
            PCW <= 32'b0;
            PCPlus4W <= 32'b0;
            
            //Reg File
            rf_waW <= 5'b0;
            rf_wr_selW <= 2'b0;
            regWriteW <= 1'b0;
            
            //ALU
            alu_resW <= 32'b0;
        
        end
        
        else begin
            //pc
            PCW <= PCM;
            PCPlus4W <= PCPlus4M;
            
            //Reg File
            rf_waW <= rf_waM;
            rf_wr_selW <= rf_wr_selM;
            regWriteW <= regWriteM;
            
            //ALU
            alu_resW <= alu_resM;
        end
        



        
        
    end
        
endmodule