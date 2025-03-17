`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2024 10:25:30 PM
// Design Name: 
// Module Name: fulladder
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


module fulladder(
input [31:0] A,
input [31:0] B,
input cin ,
output [31:0]y,
output cout

    );
    wire [31:0] carry;
    genvar i;
    generate 
    for( i =0 ; i<32 ;i=i+1) begin : adder
    if(i==0) begin
    
   adder f1( .A(A[i]),.B(B[i]),.cin(cin), .cout(carry[i]),.y(y[i]));
    
   end else begin
    adder f0( .A(A[i]),.B(B[i]),.cin(carry[i-1]),.cout(carry[i]),.y(y[i]));
    end
    end
    endgenerate
    
    
   assign cout = carry[31];
    
    
    
endmodule
