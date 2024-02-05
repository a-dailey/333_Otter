`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2023 09:49:46 PM
// Design Name: 
// Module Name: OTTER_WRAPPER_TB
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


module OTTER_WRAPPER_TB(
    );
logic clk, btnc, btnl;
logic [15:0] switches, leds;
logic [7:0] cathodes;
logic [3:0] anodes;

OTTER_Wrapper UUT(.CLK(clk), .BTNC(btnc), .SWITCHES(switches),
.LEDS(leds), .CATHODES(cathodes), .ANODES(anodes), .BTNL(btnl));

always begin
    
        #5; 
        clk = 1;
        #5;
        clk = 0;
        end

initial begin 
btnc = 0;
switches = 0;
#10
btnc = 0;
btnl = 0;
switches = 0;
#1000
btnc = 0;
btnl = 0;
switches = 0;
#10
btnl = 0;

end

endmodule
