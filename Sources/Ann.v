`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2024 01:19:19 AM
// Design Name: 
// Module Name: Ann
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


module Ann(
input[31:0] A,B,
input [31:0] dw1,dw2,dw3,
output[31:0] y
    );
    
    wire [31:0]x;
    wire  [31:0]z;
    wire  [31:0]g;
    wire  [31:0]u;
  //  wire [31:0] final;
   

     mutliplier m1(.multiplier(A),.multiplicand(dw1),.product(x));
      mutliplier m2 (.multiplier(B),.multiplicand(dw2),.product(z));
      assign g = x+z;
      mutliplier m3 (.multiplier(g),.multiplicand(dw3),.product(u));
      assign y = u + x +z;
    
    
    
    
endmodule
