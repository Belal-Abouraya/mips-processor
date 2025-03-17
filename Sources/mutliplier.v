`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2024 09:26:25 PM
// Design Name: 
// Module Name: mutliplier
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


module mutliplier(
input[31:0] multiplier,
input[31:0] multiplicand,
output [31:0] product);
reg[31:0]mplier;
reg[63:0]mpcand ;
reg[63:0] producti;
integer i;
 always @* begin
        // Initialize product and temporary variables
        producti = 0;
        mplier = multiplier;
        mpcand = {32'b0, multiplicand};  // Concatenate 32 bits of zeros to the multiplicand

        // Perform shift-and-add multiplication
        for (i = 0; i < 32; i = i + 1) begin
            if (mplier[0] == 1'b1) begin
                producti = producti + mpcand;  // Add shifted multiplicand to product
            end
            mplier = mplier >> 1;            // Shift multiplier right
            mpcand = mpcand << 1;            // Shift multiplicand left
        end
    end

assign product=producti[31:0];
   
endmodule
