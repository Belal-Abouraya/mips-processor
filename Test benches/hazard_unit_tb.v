`timescale 1ns / 1ps
`define WGHT_CODE 3'b101

module hazard_unit_tb();
    reg BranchD;
    reg [4:0] RsD;
    reg [4:0] RtD;
    reg [4:0] RdD;
    reg MemtoRegE;
    reg MemtoRegM;
    reg RegWriteE;
    reg RegWriteM;
    reg RegWriteW;
    reg [2:0] ALUControlD;
    reg [4:0] RsE;
    reg [4:0] RtE;
    reg [4:0] RdE;
    reg [2:0] ALUControlE;
    reg [4:0] WriteRegE;
    reg [4:0] WriteRegM;
    reg [4:0] WriteRegW;
    wire StallF;
    wire StallD;
    wire FlushE;
    wire ForwardAD;
    wire ForwardBD;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;
    wire [1:0] ForwardCE;
   
    hazard_unit uut(
        BranchD,
        RsD,
        RtD,
        RdD,
        MemtoRegE,
        MemtoRegM,
        RegWriteE,
        RegWriteM,
        RegWriteW,
        ALUControlD,
        RsE,
        RtE,
        RdE,
        ALUControlE,
        WriteRegE,
        WriteRegM,
        WriteRegW,
        StallF,
        StallD,
        FlushE,
        ForwardAD,
        ForwardBD,
        ForwardAE,
        ForwardBE,
        ForwardCE
        );
    
    initial begin
        BranchD = 0;
        RsD = 1;
        RtD = 2;
        RdD = 3;
        MemtoRegE = 0;
        MemtoRegM = 0;
        RegWriteE = 0;
        RegWriteM = 0;
        RegWriteW = 0;
        ALUControlD = 0;
        RsE = 1;
        RtE = 2;
        RdE = 3;
        ALUControlE = 0;
        WriteRegE = 0;
        WriteRegM = 0;
        WriteRegW = 0;
        
        // test branch forwarding
        #10 RegWriteM = 1; WriteRegM = 2;
        #10 RegWriteM = 1; WriteRegM = 4;
        #10 RegWriteM = 1; WriteRegM = 3;
        #10 RegWriteM = 1; WriteRegM = 2;
        #10 RegWriteM = 1; WriteRegM = 4;
        #10 RegWriteM = 1; WriteRegM = 1;
        // test branch stall
        BranchD = 1;
        #10 RegWriteE = 1; WriteRegE = 2;
        #10 RegWriteE = 1; WriteRegE = 4;
        #10 RegWriteE = 1; WriteRegE = 1;
        #10 RegWriteE = 1; WriteRegE = 3;
        
        #10 MemtoRegM = 1; WriteRegM = 2;
        #10 MemtoRegM = 1; WriteRegM = 3;
        #10 MemtoRegM = 1; WriteRegM = 4;
        #10 MemtoRegM = 1; WriteRegM = 1;

        // test execute forwarding
        #10 RegWriteM = 1; WriteRegM = 2; RegWriteW = 1;
        #10 RegWriteM = 1; WriteRegM = 3; RegWriteW = 1;
        #10 RegWriteM = 1; WriteRegM = 1; RegWriteW = 1;
        
        #10 RegWriteM = 0; WriteRegW = 2; RegWriteW = 1;
        #10 RegWriteM = 0; WriteRegW = 3; RegWriteW = 1;
        #10 RegWriteM = 0; WriteRegW = 1; RegWriteW = 1;
        
        // test WGHT instruction
        #10 RegWriteM = 1; WriteRegM = 1;ALUControlE = `WGHT_CODE; RegWriteW = 1;
        #10 RegWriteM = 1; WriteRegM = 2;ALUControlE = `WGHT_CODE; RegWriteW = 1;
        #10 RegWriteM = 1; WriteRegM = 3;ALUControlE = `WGHT_CODE; RegWriteW = 1;

        #10 RegWriteM = 0; WriteRegW = 1;ALUControlE = `WGHT_CODE; RegWriteW = 1;
        #10 RegWriteM = 0; WriteRegW = 2;ALUControlE = `WGHT_CODE; RegWriteW = 1;
        #10 RegWriteM = 0; WriteRegW = 3;ALUControlE = `WGHT_CODE; RegWriteW = 1;

        // test execute stalls
        #10 MemtoRegE = 1; RtE = 3;
        #10 MemtoRegE = 1; RtE = 1;
        #10 MemtoRegE = 1; RtE = 2;
        
        // test WGHT instruction
        #10 MemtoRegE = 1; RtE = 3; ALUControlD = `WGHT_CODE;
        #10 MemtoRegE = 1; RtE = 1; ALUControlD = `WGHT_CODE;
        #10 MemtoRegE = 1; RtE = 2; ALUControlD = `WGHT_CODE;


    end
    
endmodule
