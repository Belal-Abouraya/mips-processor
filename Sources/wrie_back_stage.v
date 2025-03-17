`timescale 1ns / 1ps

module wrie_back_stage(
    input MemtoRegW,
    input [31:0] ReadDataW,
    input [31:0] ALUOutW,
    output [31:0] ResultW
    );
    
    assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;
    
endmodule
