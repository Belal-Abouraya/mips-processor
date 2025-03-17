`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg clk;
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] C;
    reg [2:0] ALUSRC;

    // Outputs
    wire [31:0] y;

    // Instantiate the ALU
    ALU uut (
        .clk(clk),
        .A(A),
        .B(B),
        .C(C),
        .ALUSRC(ALUSRC),
        .y(y)
    );

    // Clock generation (10ns period)
    always begin
        #5 clk = ~clk;
    end

    // Initialize Inputs
    initial begin
        // Initialize clock and inputs
        clk = 0;
        A = 3;  // Example value for A
        B = 3;  // Example value for B
        C = 3;  // Example value for C
        ALUSRC = 3'b000;  // Default ALUSRC value (Addition)

        // Apply test stimulus
        // Apply ALUSRC = 3'b101 first to trigger the corresponding logic (W1, W2, W3 assignment)
        ALUSRC = 3'b101;
        #10;  // Wait for one clock cycle for W1, W2, W3 to update

        // Check other operations after ALUSRC is set to 3'b101
        ALUSRC = 3'b000;  // Addition
        #10;

        ALUSRC = 3'b001;  // Subtraction
        #10;

        ALUSRC = 3'b100;  // ANN operation
        #10;

        ALUSRC = 3'b011;  // OR operation (A | B)
        #10;

        ALUSRC = 3'b010;  // AND operation (A & B)
        #10;

        // Test with different values for A, B, and C
        A = 32'hFFFFFFFF;  // Test all ones for A
        B = 32'h00000000;  // Test all zeros for B
        C = 32'h00000001;  // Test a small value for C
        #10;

        ALUSRC = 3'b101;  // Update W1, W2, W3 again
        #10;

        // End simulation
        $finish;
    end

    // Monitor the output values at each time step
    initial begin 
        $monitor("Time=%0t ALUSRC=%b, A=%h, B=%h, C=%h => y=%h", 
                 $time, ALUSRC, A, B, C, y);
    end
    endmodule
