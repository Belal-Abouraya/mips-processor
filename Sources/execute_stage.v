`timescale 1ns / 1ps

module execute_stage(
    input clk,
    input RegWriteE,
    input MemtoRegE,
    input MemWriteE,
    input [2:0] ALUControlE,
    input ALUSrcE,
    input RegDstE,
    input [4:0] RtE,
    input [4:0] RdE,
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] RD3E,
    input [1:0] ForwardAE,
    input [1:0] ForwardBE,
    input [1:0] ForwardCE,
    input [31:0] SignImmE,
    input [31:0] ResultW,
    output [4:0] WriteRegE,
    output reg RegWriteM = 0,
    output reg MemtoRegM = 0,
    output reg MemWriteM = 0,
    output reg [31:0] ALUOutM = 0,
    output reg [31:0] WriteDataM = 0,
    output reg [4:0] WriteRegM = 0
    );
    
    // ALU signals
    wire [31:0] SrcAE, SrcBE, SrcCE, ALUOutE;
    // intermediate result
    wire [31:0] WriteDataE;
    
    assign SrcAE = ForwardAE == 2'b00 ? RD1E : (ForwardAE == 2'b01 ? ResultW : ALUOutM);
    assign SrcCE = ForwardCE == 2'b00 ? RD3E : (ForwardCE == 2'b01 ? ResultW : ALUOutM);
    assign WriteDataE = ForwardBE == 2'b00 ? RD2E : (ForwardBE == 2'b01 ? ResultW : ALUOutM);
    assign SrcBE = ALUSrcE ? SignImmE : WriteDataE;
    
    // instantiate the ALU
    ALU alu(
    .clk(clk),
    .A(SrcAE),
    .B(SrcBE),
    .C(SrcCE),
    .ALUSRC(ALUControlE),
    .y(ALUOutE)
    );
    
    assign WriteRegE = RegDstE ? RdE : RtE; 
    
    // pipeline registers update
    always @(posedge clk) begin
        // data path signals
        ALUOutM = ALUOutE;
        WriteDataM = WriteDataE;
        WriteRegM = WriteRegE;
        
        // control signals
        RegWriteM = RegWriteE;
        MemtoRegM = MemtoRegE;
        MemWriteM = MemWriteE;
    end
endmodule
