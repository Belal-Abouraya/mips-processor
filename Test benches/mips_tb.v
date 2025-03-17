`timescale 1ns / 1ps

`define PC_SIZE 4
`define SIZE 16

module mips_tb();

    reg clk;
    wire WE;
    wire [31:0] WA, WD, DataRD, RD;
    wire [`PC_SIZE - 1:0] PCF;
    
    data_memory #(.SIZE(`SIZE)) mem(
        .clk(clk),
        .WE(WE),
        .WA(WA),
        .WD(WD),
        .DataRD(DataRD)
        );
        
    inst_memory #(.PC_SIZE(`PC_SIZE)) inst(
        .PCF(PCF),
        .RD(RD)
        );
    
    mips # (.PC_SIZE(`PC_SIZE)) cpu(
        .clk(clk),
        .RD(RD),
        .DataRD(DataRD),
        .PCF(PCF),
        .WA(WA),
        .WD(WD),
        .WE(WE)
        );
            
    
    always begin
        #10 clk = ~clk;
    end
    
    initial begin
        clk = 0;
    end

endmodule
