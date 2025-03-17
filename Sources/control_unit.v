`timescale 1ns / 1ps
// Op codes
`define R_CODE 6'b000000
`define I_CODE 3'b001
`define LW_CODE 6'b100011
`define SW_CODE 6'b101011
`define BEQZ_CODE 6'b000100
`define SUBI_CODE 3'b001
// Funct codes
`define FUNCT_ADD 6'b100000
`define FUNCT_SUB 6'b100010
`define FUNCT_AND 6'b100100
`define FUNCT_OR 6'b100101
`define FUNCT_ANN 6'b000000
`define FUNCT_WGHT 6'b111111
// ALU function codes
`define ADD 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define ANN 3'b100
`define WGHT 3'b101

module control_unit(
    input [5:0] Op,
    input [5:0] Funct,
    output reg RegWriteD,
    output reg MemtoRegD,
    output reg MemWriteD,
    output reg [2:0] ALUControlD,
    output reg ALUSrcD,
    output reg RegDstD,
    output reg BranchD
    );
    
    always @(*) begin
        RegWriteD = 0;
        MemtoRegD = 0;
        MemWriteD = 0;
        ALUControlD = 0;
        ALUSrcD = 0;
        RegDstD = 0;
        BranchD = 0;
        if (Op == `R_CODE) begin
            if(Funct != `FUNCT_WGHT) begin
                RegWriteD = 1;
            end
            RegDstD = 1;
            case(Funct)
                `FUNCT_ADD: ALUControlD = `ADD;
                `FUNCT_SUB: ALUControlD = `SUB;
                `FUNCT_AND: ALUControlD = `AND;
                `FUNCT_OR: ALUControlD = `OR;
                `FUNCT_ANN: ALUControlD = `ANN;
                `FUNCT_WGHT: ALUControlD = `WGHT;
            endcase
        end
        else if (Op == `LW_CODE) begin
            RegWriteD = 1;
            ALUSrcD = 1;
            MemtoRegD = 1;
        end
        else if (Op == `SW_CODE) begin
            ALUSrcD = 1;
            MemWriteD = 1;
        end
        else if (Op == `BEQZ_CODE) begin
            BranchD = 1;
        end
        else if(Op[5:3] == `I_CODE) begin // I-type
            RegWriteD = 1;
            ALUSrcD = 1;
            if(Op[2:0] == `SUBI_CODE) begin // subi
                ALUControlD = `SUB;
            end
        end
    end

endmodule