`timescale 1ns / 1ps

module mips # (parameter PC_SIZE = 8)(
    input clk,
    input [31:0] RD,
    input [31:0] DataRD,
    output [PC_SIZE - 1: 0] PCF,
    output [31:0] WA,
    output [31:0] WD,
    output WE
    );
        
    // decode signals
    wire [PC_SIZE - 1: 0] PCPlus1D, PCBranchD;
    wire [4:0] RsD, RtD, RdD;
    wire [31:0] InstrD;
    wire [2:0] ALUControlD;
    wire PCSrcD, BranchD;
    
    // execute signals
    wire RegWriteE, MemtoRegE, MemWriteE, ALUSrcE, RegDstE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1E, RD2E, RD3E, SignImmE;
    wire [4:0] WriteRegE, RsE, RtE, RdE;
    
    // memory stage
    wire RegWriteM, MemtoRegM, MemWriteM;
    wire [31:0] ALUOutM, WriteDataM;
    wire [4:0] WriteRegM;
    
    // write back signals
    wire RegWriteW, MemtoRegW;
    wire [31:0] ResultW, ReadDataW, ALUOutW;
    wire [4:0] WriteRegW;
    
    // hazard unit signals
    wire StallF, StallD, FlushE, ForwardAD, ForwardBD;
    wire [1:0] ForwardAE, ForwardBE, ForwardCE;
    
    fetch_stage #(.PC_SIZE(PC_SIZE)) fetch (
        .clk(clk),
        .StallF(StallF),
        .StallD(StallD),
        .PCSrcD(PCSrcD),
        .PCBranchD(PCBranchD),
        .RD(RD),
        .PCPlus1D(PCPlus1D),
        .PCF(PCF),
        .InstrD(InstrD)
        );
    
    decode_stage #(.PC_SIZE(PC_SIZE)) decode(
        .clk(clk),
        .InstrD(InstrD),
        .PCPlus1D(PCPlus1D),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .FlushE(FlushE),
        .ALUOutM(ALUOutM),
        .ResultW(ResultW),
        .RegWriteW(RegWriteW),
        .WriteRegW(WriteRegW),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .RD3E(RD3E),
        .BranchD(BranchD),
        .RsD(RsD),
        .RtD(RtD),
        .RdD(RdD),
        .ALUControlD(ALUControlD),
        .PCSrcD(PCSrcD),
        .PCBranchD(PCBranchD),
        .RsE(RsE),
        .RtE(RtE),
        .RdE(RdE),
        .SignImmE(SignImmE),
        .RegWriteE(RegWriteE),
        .MemtoRegE(MemtoRegE),
        .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RegDstE(RegDstE)
        );
    
    execute_stage execute(
        .clk(clk),
        .RegWriteE(RegWriteE),
        .MemtoRegE(MemtoRegE),
        .MemWriteE(MemWriteE),
        .ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE),
        .RegDstE(RegDstE),
        .RtE(RtE),
        .RdE(RdE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .RD3E(RD3E),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ForwardCE(ForwardCE),
        .SignImmE(SignImmE),
        .ResultW(ResultW),
        .WriteRegE(WriteRegE),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .MemWriteM(MemWriteM),
        .ALUOutM(ALUOutM),
        .WriteDataM(WriteDataM),
        .WriteRegM(WriteRegM)
        );

    memory_stage memory(
        .clk(clk),
        .WriteRegM(WriteRegM),
        .WriteDataM(WriteDataM),
        .ALUOutM(ALUOutM),
        .RegWriteM(RegWriteM),
        .MemtoRegM(MemtoRegM),
        .MemWriteM(MemWriteM),
        .DataRD(DataRD),
        .WE(WE),
        .WA(WA),
        .WD(WD),
        .RegWriteW(RegWriteW),
        .MemtoRegW(MemtoRegW),
        .ReadDataW(ReadDataW),
        .ALUOutW(ALUOutW),
        .WriteRegW(WriteRegW)
        );

    wrie_back_stage write_back(
        .MemtoRegW(MemtoRegW),
        .ReadDataW(ReadDataW),
        .ALUOutW(ALUOutW),
        .ResultW(ResultW)
        );
    
    hazard_unit hazard(
        .BranchD(BranchD),
        .RsD(RsD),
        .RtD(RtD),
        .RdD(RdD),
        .MemtoRegE(MemtoRegE),
        .MemtoRegM(MemtoRegM),
        .RegWriteE(RegWriteE),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ALUControlD(ALUControlD),
        .RsE(RsE),
        .RtE(RtE),
        .RdE(RdE),
        .ALUControlE(ALUControlE),
        .WriteRegE(WriteRegE),
        .WriteRegM(WriteRegM),
        .WriteRegW(WriteRegW),
        .StallF(StallF),
        .StallD(StallD),
        .FlushE(FlushE),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ForwardCE(ForwardCE)
        );
    
endmodule
