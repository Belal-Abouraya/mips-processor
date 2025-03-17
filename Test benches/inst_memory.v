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

`define garbage 32'hffffffff

module inst_memory #(parameter PC_SIZE = 8)(
    input [PC_SIZE - 1:0] PCF,
    output [31:0] RD
    );
    
    reg [31:0] mem[(1 << PC_SIZE) - 1:0];
    assign RD = mem[PCF];
        
    integer i;
    // program the instruction memory
    initial begin
        // fill with garbage instructions initially to avoid problems after the actual program
        for(i = 0; i < 1 << PC_SIZE; i = i + 1) begin
            mem[i] = `garbage;
        end
        
        // program 1
//        mem[0][31:26] = `LW_CODE; // lw r1, 0(r0)
//        mem[0][25:21] = 0;
//        mem[0][20:16] = 1;
//        mem[0][15:0] = 0;
        
//        mem[1][31:26] = `LW_CODE; // lw r2, 1(r0)
//        mem[1][25:21] = 0;
//        mem[1][20:16] = 2;
//        mem[1][15:0] = 1;

//        mem[2][31:26] = `R_CODE; // add r3, r1, r2;
//        mem[2][25:21] = 1;
//        mem[2][20:16] = 2;
//        mem[2][15:11] = 3;
//        mem[2][10:6] = 0;
//        mem[2][5:0] = `FUNCT_ADD;

//        mem[3][31:26] = `SW_CODE; // sw r3, 3(r0)
//        mem[3][25:21] = 0;
//        mem[3][20:16] = 3;
//        mem[3][15:0] = 3;
    
        // program 2
        mem[0][31:26] = `LW_CODE; // lw r1, 0(r0)
        mem[0][25:21] = 0;
        mem[0][20:16] = 1;
        mem[0][15:0] = 0;
        
        mem[1][31:26] = `LW_CODE; // lw r2, 1(r0)
        mem[1][25:21] = 0;
        mem[1][20:16] = 2;
        mem[1][15:0] = 1;

        mem[2][31:26] = `LW_CODE; // lw r3, 2(r0)
        mem[2][25:21] = 0;
        mem[2][20:16] = 3;
        mem[2][15:0] = 2;

        mem[3][31:26] = `R_CODE; // wght r3, r1, r2;
        mem[3][25:21] = 1;
        mem[3][20:16] = 2;
        mem[3][15:11] = 3;
        mem[3][10:6] = 0;
        mem[3][5:0] = `FUNCT_WGHT;

        mem[4][31:26] = `R_CODE; // ann r3, r1, r2;
        mem[4][25:21] = 1;
        mem[4][20:16] = 2;
        mem[4][15:11] = 3;
        mem[4][10:6] = 0;
        mem[4][5:0] = `FUNCT_ANN;

        mem[5][31:26] = `SW_CODE; // sw r3, 3(r0)
        mem[5][25:21] = 0;
        mem[5][20:16] = 3;
        mem[5][15:0] = 3;
        
        // program 3
//        mem[0][31:26] = `R_CODE; // add r2, r0, r0;
//        mem[0][25:21] = 0;
//        mem[0][20:16] = 0;
//        mem[0][15:11] = 2;
//        mem[0][10:6] = 0;
//        mem[0][5:0] = `FUNCT_ADD;
        
//        mem[1][31:26] = `LW_CODE; // lw r1, 2(r0)
//        mem[1][25:21] = 0;
//        mem[1][20:16] = 1;
//        mem[1][15:0] = 2;
        
//        mem[2][31:26] = `LW_CODE; // lw r3, 1(r0)
//        mem[2][25:21] = 0;
//        mem[2][20:16] = 3;
//        mem[2][15:0] = 1;
        
//        mem[3][31:29] = `I_CODE; // subi r1, r1, 2;
//        mem[3][28:26] = `SUBI_CODE;
//        mem[3][25:21] = 1;
//        mem[3][20:16] = 1;
//        mem[3][15:0] = 2;
    
//        mem[4][31:26] = `BEQZ_CODE; // beqz r1, 1;
//        mem[4][25:21] = 0;
//        mem[4][20:16] = 1;
//        mem[4][15:0] = 1;
        
//        mem[5][31:26] = `R_CODE; // add r2, r3, r2;
//        mem[5][25:21] = 3;
//        mem[5][20:16] = 2;
//        mem[5][15:11] = 2;
//        mem[5][10:6] = 0;
//        mem[5][5:0] = `FUNCT_ADD;

//        mem[6][31:26] = `SW_CODE; // sw r2, 3(r0)
//        mem[6][25:21] = 0;
//        mem[6][20:16] = 2;
//        mem[6][15:0] = 3;
        
    end
    
endmodule
