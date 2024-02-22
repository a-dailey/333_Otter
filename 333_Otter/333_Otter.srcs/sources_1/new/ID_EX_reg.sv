module ID_EX_reg(
    input CLK,
   
    //input data signals
    input logic [4:0] rf_waD,
    input logic [31:0] PCD, PCPlus4D, alu_srcAD, alu_srcBD, j_typeD, b_typeD, i_typeD, rs1D, rs2D, InstrD,
   
    //input control signals
    input logic [1:0] rf_wr_selD,
    input logic [3:0] alu_funD,
    input logic regWriteD, memWE2D, memRDEN2D,
   
    //output data signals
   
    output logic [4:0] rf_waE,
    output logic [31:0] PCE, PCPlus4E, alu_srcAE, alu_srcBE, j_typeE, b_typeE, i_typeE, rs1E, rs2E, InstrE,
   
    //output control signals
    output logic [1:0] rf_wr_selE,
    output logic [3:0] alu_funE,
    output logic regWriteE, memWE2E, memRDEN2E
   


    );
   
    always_ff @(posedge CLK) begin
        //pc
        PCE <= PCD;
        PCPlus4E <= PCPlus4D;
       
        //Reg File
        rf_waE <= rf_waD;
        rs1E <= rs1D;
        rs2E <= rs2D;
        rf_wr_selE <= rf_wr_selD;
        regWriteE <= regWriteD;
       
        //ALU
        alu_srcAE <= alu_srcAD;
        alu_srcBE <= alu_srcBD;
        alu_funE <= alu_funD;
       
        //memory
        memWE2E <= memWE2D;
        memRDEN2E <= memRDEN2D;
        InstrE <= InstrD;
       
        //imm gen
        j_typeE <= j_typeD;
        i_typeE <= i_typeD;
        b_typeE <= b_typeD;
       
       
    end
       
endmodule
