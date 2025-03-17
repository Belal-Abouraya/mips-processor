`timescale 1ns / 1ps
`define PC_SIZE 8

module decode_stage_tb();
    reg clk;
    reg [31:0] InstrD;
    reg [`PC_SIZE - 1: 0] PCPlus1D;
    reg ForwardAD;
    reg ForwardBD;
    reg FlushE;
    reg [31:0] ALUOutM;
    reg [31:0] ResultW;
    reg RegWriteW;
    reg [4:0] WriteRegW;
    wire [31:0] RD1E;
    wire [31:0] RD2E;
    wire [31:0] RD3E;
    wire BranchD;
    wire [4:0] RsD;
    wire [4:0] RtD;
    wire [4:0] RdD;
    wire [2:0] ALUControlD;
    wire PCSrcD;
    wire [`PC_SIZE - 1: 0] PCBranchD;
    wire [4:0] RsE;
    wire [4:0] RtE;
    wire [4:0] RdE;
    wire [31:0] SignImmE;
    wire RegWriteE;
    wire MemtoRegE;
    wire MemWriteE;
    wire [2:0] ALUControlE;
    wire ALUSrcE;
    wire RegDstE;

    decode_stage #(.PC_SIZE(`PC_SIZE)) uut(
     clk,
     InstrD,
     PCPlus1D,
     ForwardAD,
     ForwardBD,
     FlushE,
     ALUOutM,
     ResultW,
     RegWriteW,
     WriteRegW,
     RD1E,
     RD2E,
     RD3E,
     BranchD,
     RsD,
     RtD,
     RdD,
     ALUControlD,
     PCSrcD,
     PCBranchD,
     RsE,
     RtE,
     RdE,
     SignImmE,
     RegWriteE,
     MemtoRegE,
     MemWriteE,
     ALUControlE,
     ALUSrcE,
     RegDstE
    );

    always begin
        #10 clk = ~clk;
    end

    initial begin
        clk = 0;
        // test WGHT
        InstrD[31:26] = 0;
        InstrD[25:21] = 1;
        InstrD[20:16] = 2;
        InstrD[15:11] = 3;
        InstrD[10:6] = 0;
        InstrD[5:0] = 6'b111111;
        PCPlus1D = 7;
        ForwardAD = 0;
        ForwardBD = 0;
        FlushE = 0;
        ALUOutM = 0;
        ResultW = 0;
        RegWriteW = 0;
        WriteRegW = 2;
        #20;
        
        // write to register file
        ResultW = 0;
        RegWriteW = 1;
        WriteRegW = 1;
        #20;
        ResultW = 10;
        RegWriteW = 1;
        WriteRegW = 2;
        #20;
        ResultW = 20;
        RegWriteW = 1;
        WriteRegW = 3;
        #20;
        
        // test the flush
        FlushE = 1;
        #20;
        
        // test branch target
        InstrD[15:0] = -3;
        FlushE = 0;
        #20;
        // test branch instruction
        InstrD[31:26] = 6'b000100;
        InstrD[25:21] = 1;
        InstrD[20:16] = 0;
        InstrD[15:0] = -3;
        #20;
        $finish;
    end

endmodule
