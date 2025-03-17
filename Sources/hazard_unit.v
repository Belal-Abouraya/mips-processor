`timescale 1ns / 1ps
`define WGHT_CODE 3'b101

module hazard_unit(
    input BranchD,
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RdD,
    input MemtoRegE,
    input MemtoRegM,
    input RegWriteE,
    input RegWriteM,
    input RegWriteW,
    input [2:0] ALUControlD,
    input [4:0] RsE,
    input [4:0] RtE,
    input [4:0] RdE,
    input [2:0] ALUControlE,
    input [4:0] WriteRegE,
    input [4:0] WriteRegM,
    input [4:0] WriteRegW,
    output StallF,
    output StallD,
    output FlushE,
    output ForwardAD,
    output ForwardBD,
    output [1:0] ForwardAE,
    output [1:0] ForwardBE,
    output [1:0] ForwardCE
    );

    wire isWGHTD, isWGHTE, lwStall, branchstall, isStall;
    reg [1:0] FAE = 0, FBE = 0, FCE = 0;
     
    assign isWGHTD = ALUControlD == `WGHT_CODE;
    assign isWGHTE = ALUControlE == `WGHT_CODE;
    
    assign isStall = lwStall | branchstall;
    
    assign StallF = isStall;
    assign StallD = isStall;
    assign FlushE = isStall;

    // branch signals
    assign branchstall = BranchD && (RegWriteE && (WriteRegE == RsD || WriteRegE == RtD) 
                           || MemtoRegM && (WriteRegM == RsD || WriteRegM == RtD));

    assign ForwardAD = RsD != 0 && RsD == WriteRegM && RegWriteM;
    assign ForwardBD = RtD != 0 && RtD == WriteRegM && RegWriteM;
 
    assign ForwardAE = FAE;
    assign ForwardBE = FBE;
    assign ForwardCE = FCE;

    // load stall signal
    assign lwStall = MemtoRegE && (RsD == RtE || RtD == RtE || isWGHTD && RdD == RtE);

always @(*) begin
    if (RsE != 0 && RsE == WriteRegM && RegWriteM) begin
        FAE = 2'b10;
    end
    else if(RsE != 0 && RsE == WriteRegW && RegWriteW) begin
        FAE = 2'b01;
    end
    else begin
        FAE = 2'b00;
    end
    
    if (RtE != 0 && RtE == WriteRegM && RegWriteM) begin
        FBE = 2'b10;
    end
    else if(RtE != 0 && RtE == WriteRegW && RegWriteW) begin
        FBE = 2'b01;
    end
    else begin
        FBE = 2'b00;
    end
    
    if (isWGHTE) begin
        if (RdE != 0 && RdE == WriteRegM && RegWriteM) begin
            FCE = 2'b10;
        end
        else if(RdE != 0 && RdE == WriteRegW && RegWriteW) begin
            FCE = 2'b01;
        end
        else begin
            FCE = 2'b00;
        end
    end
end

endmodule
