`timescale 1ns / 1ps

module memory_stage(
    input clk,
    input [4:0] WriteRegM,
    input [31:0] WriteDataM,
    input [31:0] ALUOutM,
    input RegWriteM,
    input MemtoRegM,
    input MemWriteM,
    input [31:0] DataRD,
    output WE,
    output [31:0] WA,
    output [31:0] WD,
    output reg RegWriteW = 0,
    output reg MemtoRegW = 0,
    output reg [31:0] ReadDataW,
    output reg [31:0] ALUOutW,
    output reg [4:0] WriteRegW
    );
    
    // data memory signals
    assign WE = MemWriteM;
    assign WA = ALUOutM;
    assign WD = WriteDataM;
    
    // pipline register update
    always @(posedge clk) begin
        // control signals
        RegWriteW = RegWriteM;
        MemtoRegW = MemtoRegM;
        
        // data path signals
        ALUOutW = ALUOutM;
        ReadDataW = DataRD;
        WriteRegW = WriteRegM;
    end
    
endmodule
