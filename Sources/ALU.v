`timescale 1ns / 1ps

module ALU(
input clk,
input [31:0] A,
input[31:0] B,
input [31:0] C,
input[2:0] ALUSRC,
output[31:0] y

    );
    reg[31:0] W1 = 32'b0;
    reg[31:0]W2=32'b0;
    reg[31:0]W3=32'b0;
    wire f;
    wire [31:0] addresult;
    wire [31:0] subresult;
    wire[31:0] annresult;
   
    
    fulladder fa1 (.A(A),.B(B),.cin(0),.cout(f),.y(addresult));
    fulladder fa2 (.A(A),.B(~B),.cin(1),.cout(f),.y(subresult));
    Ann A1(.A(A),.B(B),.dw1(W1),.dw2(W2),.dw3(W3),.y(annresult));
  
    
   
    always @ (posedge clk) begin
    if ( ALUSRC == 3'b101) begin
     
    W1<=A ;
    W2<=B;
    W3<=C;
    end
    end
   
   assign y = (ALUSRC == 3'b0) ? addresult:
             (ALUSRC == 3'b001) ? subresult:
             (ALUSRC==3'b100)? annresult:
             (ALUSRC == 3'b011)? A|B :
             A&B;
   
endmodule
