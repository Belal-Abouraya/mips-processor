`timescale 1ns / 1ps

module decode_stage #(parameter PC_SIZE = 8)(
    input clk,
    input [31:0] InstrD,
    input [PC_SIZE - 1: 0] PCPlus1D,
    input ForwardAD,
    input ForwardBD,
    input FlushE,
    input [31:0] ALUOutM,
    input [31:0] ResultW,
    input RegWriteW,
    input [4:0] WriteRegW,
    output [31:0] RD1E,
    output [31:0] RD2E,
    output [31:0] RD3E,
    output BranchD,
    output [4:0] RsD,
    output [4:0] RtD,
    output [4:0] RdD,
    output [2:0] ALUControlD,
    output PCSrcD,
    output [PC_SIZE - 1: 0] PCBranchD,
    output reg [4:0] RsE,
    output reg [4:0] RtE,
    output reg [4:0] RdE,
    output reg [31:0] SignImmE,
    output reg RegWriteE = 0,
    output reg MemtoRegE = 0,
    output reg MemWriteE = 0,
    output reg [2:0] ALUControlE = 0,
    output reg ALUSrcE = 0,
    output reg RegDstE = 0
    );

    // control unit signals
    wire RegWriteD;
    wire MemtoRegD;
    wire MemWriteD;
    wire ALUSrcD;
    wire RegDstD;
    // register file signals
    wire [31:0] RD1, RD2, RD3;
    // intermediate results for branch
    wire EqualD;
    wire [31:0] SrcA, SrcB;
    // sign extender signal
    wire [31:0] SignImmD;
    
    assign RsD = InstrD[25:21];
    assign RtD = InstrD[20:16];
    assign RdD = InstrD[15:11];
    
    // instantiate the control unit
    control_unit controller(
        .Op(InstrD[31:26]),
        .Funct(InstrD[5:0]),
        .RegWriteD(RegWriteD),
        .MemtoRegD(MemtoRegD),
        .MemWriteD(MemWriteD),
        .ALUControlD(ALUControlD),
        .ALUSrcD(ALUSrcD),
        .RegDstD(RegDstD),
        .BranchD(BranchD)
        );
    
    // instantiate the regiser file
    register1 reg_file(
        .clk(clk),
        .we3(RegWriteW),
        .ra1(RsD),
        .ra2(RtD),
        .ra3(RdD),
        .wa3(WriteRegW),
        .wd3(ResultW),
        .rd1(RD1),
        .rd2(RD2),
        .rd3(RD3)
        );
    
    // branch signals
    assign SrcA = ForwardAD ? ALUOutM : RD1;
    assign SrcB = ForwardBD ? ALUOutM : RD2;
    assign EqualD = SrcA == SrcB;
    assign PCSrcD = EqualD & BranchD;
    
    // instantiate the sign extender
    sign_extender sgn(
        .in(InstrD[15:0]),
        .out(SignImmD)
    );
    assign PCBranchD = SignImmD + PCPlus1D; // calculate branch target address 
    assign RD1E = RD1;
    assign RD2E = RD2;
    assign RD3E = RD3;

    // pipline registers update
    always @(posedge clk) begin
        if(FlushE) begin // Flush the pipeline registers
            // it is enough to flush the control signals only
            RegWriteE = 0;
            MemtoRegE = 0;
            MemWriteE = 0;
            ALUControlE = 0;
            ALUSrcE = 0;
            RegDstE = 0;
        end
        else begin
            // data path signals
            RsE = RsD;
            RtE = RtD;
            RdE = RdD;
            SignImmE <= SignImmD;
            
            // control signals
            RegWriteE = RegWriteD;
            MemtoRegE = MemtoRegD;
            MemWriteE = MemWriteD;
            ALUControlE = ALUControlD;
            ALUSrcE = ALUSrcD;
            RegDstE = RegDstD;
        end
    end
endmodule    