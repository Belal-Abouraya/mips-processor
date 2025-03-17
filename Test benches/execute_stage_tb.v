`timescale 1ns / 1ps

module execute_stage_tb();
    reg clk;
    reg RegWriteE;
    reg MemtoRegE;
    reg MemWriteE;
    reg [2:0] ALUControlE;
    reg ALUSrcE;
    reg RegDstE;
    reg [4:0] RtE;
//    reg [4:0] RsE;
    reg [4:0] RdE;
    reg [31:0] RD1E;
    reg [31:0] RD2E;
    reg [31:0] RD3E;
    reg [2:0] ForwardAE;
    reg [2:0] ForwardBE;
    reg [2:0] ForwardCE;
    reg [31:0] SignImmE;
    reg [31:0] ResultW;
    wire [4:0] WriteRegE;
    wire RegWriteM;
    wire MemtoRegM;
    wire MemWriteM;
    wire [31:0] ALUOutM;
    wire [31:0] WriteDataM;
    wire [4:0] WriteRegM;
    
    execute_stage uut(
        clk,
        RegWriteE,
        MemtoRegE,
        MemWriteE,
        ALUControlE,
        ALUSrcE,
        RegDstE,
        RtE,
//        RsE,
        RdE,
        RD1E,
        RD2E,
        RD3E,
        ForwardAE,
        ForwardBE,
        ForwardCE,
        SignImmE,
        ResultW,
        WriteRegE,
        RegWriteM,
        MemtoRegM,
        MemWriteM,
        ALUOutM,
        WriteDataM,
        WriteRegM
        );
    
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        RegWriteE = 0;
        MemtoRegE = 0;
        MemWriteE = 0;
        ALUControlE = 0;
        ALUSrcE = 0;
        RegDstE = 0;
        RtE = 0;
//        RsE = 0;
        RdE = 0;
        RD1E = 1;
        RD2E = 2;
        RD3E = 3;
        ForwardAE = 0;
        ForwardBE = 0;
        ForwardCE = 0;
        SignImmE = 5;
        ResultW = 13;
        #20;
        ALUSrcE = 1;
        #20;
        ALUSrcE = 0;
        ForwardAE = 0;
        ForwardBE = 1;
        #20;
        ForwardAE = 2'b10;
        ForwardBE = 1;
        #20;
        $finish;
    end

endmodule
