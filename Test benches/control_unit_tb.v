`timescale 1ns / 1ps
`define SUBI 6'b001001
`define ADDI 6'b001000
`define BEQZ 6'b000100
`define LW 6'b100011
`define SW 6'b101011

module control_unit_tb();
    reg [5:0] Op;
    reg [5:0] Funct;
    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire RegDstD;
    wire BranchD;

    control_unit uut(
        Op,
        Funct,
        RegWriteD,
        MemtoRegD,
        MemWriteD,
        ALUControlD,
        ALUSrcD,
        RegDstD,
        BranchD
    );
    
    initial begin
        Op = 0;
        Funct = 0;
        // test R-type
        #10 Op = 6'b000000; Funct = 6'b100101;
        // test I-type
        #10 Op = `SUBI;
        // test BEQZ
        #10 Op = `BEQZ;
        // test LW
        #10 Op = `LW;
        // test SW
        #10 Op = `SW;
    end
    
endmodule
