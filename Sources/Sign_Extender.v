`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 10:54:48 AM
// Design Name: 
// Module Name: Sign_Extender
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

module sign_extender (
    input wire [15:0] in,      // 16-bit signed input
    output reg [31:0] out     // 32-bit signed output
);

    always @(*) begin
        if (in[15] == 1)                                           // If the sign bit is 1 (negative)
            out = {16'b1111111111111111, in[15:0]};                // Extend with 1s
        else                                                       // If the sign bit is 0 (positive)
            out = {16'b0000000000000000, in[15:0]};                // Extend with 0s
    end

endmodule

