`timescale 1ns / 1ps
`define PC_SIZE 3

module fetch_stage_tb();    
    reg clk;
    reg StallF;
    reg StallD;
    reg PCSrcD;
    reg [`PC_SIZE - 1:0] PCBranchD;
    reg [31:0] RD;
    wire [`PC_SIZE - 1:0] PCPlus1D;
    wire [`PC_SIZE - 1:0] PCF;
    wire [31:0] InstrD;
    
    fetch_stage #(.PC_SIZE(`PC_SIZE)) uut (
        clk,
        StallF,
        StallD,
        PCSrcD,
        PCBranchD,
        RD,
        PCPlus1D,
        PCF,
        InstrD
        );
    
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        RD = 3;
        PCBranchD = 4;
        PCSrcD = 0;
        StallF = 0;
        StallD = 0;
        #20;
        PCSrcD = 0;
        StallF = 1;
        StallD = 1;
        #20;
        PCSrcD = 0;
        #20;
        StallF = 0;
        StallD = 0;
        PCSrcD = 1;
        #20;
        $finish;
    end
    
endmodule
