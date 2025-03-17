`timescale 1ns / 1ps

module data_memory #(parameter SIZE = 1024)(
    input clk,
    input WE,
    input [31:0] WA,
    input [31:0] WD,
    output [31:0] DataRD
    );
    
    reg [31:0] mem[SIZE - 1:0];
    assign DataRD = mem[WA];
    
    always @(posedge clk) begin
        if(WE) begin
            mem[WA] = WD;
        end
    end
    
    integer i;
    // put values inside the memory for testing
    initial begin

        for(i = 0; i < SIZE; i = i + 1) begin
            mem[i] = 0;
        end

        mem[0] = 1;
        mem[1] = 2;
        mem[2] = 3;
    
    end
    
endmodule
