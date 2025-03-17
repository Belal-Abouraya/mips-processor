`timescale 1ns / 1ps

module fetch_stage #(parameter PC_SIZE = 8)(
    input clk,
    input StallF,
    input StallD,
    input PCSrcD,
    input [PC_SIZE - 1:0] PCBranchD,
    input [31:0] RD,
    output reg [PC_SIZE - 1:0] PCPlus1D,
    output reg [PC_SIZE - 1:0] PCF = 0,
    output reg [31:0] InstrD = 32'hffffffff // ADD INITIAL VALUE
    );
    
    wire [PC_SIZE - 1:0] PC_dash, PCPlus1F;
    assign PCPlus1F = PCF + 1;
    assign PC_dash = PCSrcD ? PCBranchD : PCPlus1F;
    
    // PC process
    always @ (posedge clk) begin
        if(StallF == 0) begin
            PCF = PC_dash;
        end
    end
    
    // pipeline registers
    always @ (posedge clk) begin
        if(PCSrcD) begin // clear the fetch stage on branch
            InstrD[31:26] = 6'b111111; // garbage opcode not used in control
            InstrD[25:0] = 0;
            PCPlus1D = 0;
        end
        else if(StallD == 0) begin
            PCPlus1D = PCPlus1F;
            InstrD = RD;
        end 
    end
    
endmodule
