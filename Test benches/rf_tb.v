`timescale 1ns / 1ps

module rf_tb();

    reg clk = 0;
    always begin
        #10 clk = ~clk;
    end
    
    reg we3;
    reg [4:0] ra1, ra2,ra3, wa3;
    reg [31:0] wd3;
    wire [31:0] rd1, rd2,rd3;

    register1 rf(
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .ra3(ra3),
        .wa3(wa3),
        .wd3(wd3),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rd3));

    initial begin
        we3 = 1;
        wa3 = 1;
        wd3 = 10;
        ra1 = 1;
        #20;
    end

endmodule
