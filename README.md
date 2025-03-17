# MIPS Implementation with ANN Support

This repository contains a Verilog implementation of a 5-stage pipelined MIPS processor that supports a custom set of instructions, including an Artificial Neural Network (ANN) instruction. The processor is designed to handle data and structural hazards automatically using a hazards unit, which resolves conflicts via forwarding or stalls.

## Supported Instructions

The processor implements the following instructions:

- **Arithmetic Instructions**:
  - `ADD`: Add two registers.
  - `SUB`: Subtract two registers.
  - `ADDI`: Add an immediate value to a register.
  - `SUBI`: Subtract an immediate value from a register.

- **Logical Instructions**:
  - `AND`: Bitwise AND of two registers.
  - `OR`: Bitwise OR of two registers.

- **Memory Access Instructions**:
  - `LW`: Load word from memory into a register.
  - `SW`: Store word from a register into memory.

- **Control Flow Instruction**:
  - `BEQZ`: Branch if a register is equal to zero.

- **Custom ANN Instructions**:
  - `ANN`: Implements a single-node Artificial Neural Network.
  - `WGHT`: Sets weights for the ANN operation.

## Processor Architecture

### 5-Stage Pipeline
The processor follows a 5-stage pipeline architecture:
1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execution (EX)**
4. **Memory Access (MEM)**
5. **Write Back (WB)**

### Key Features
- **32 General-Purpose Registers**: Each register is 32 bits wide.
- **Dedicated Weight Registers**: Three extra registers (`W1`, `W2`, `W3`) are used for the ANN operation, where `W3` is the feedback weight.
- **Hazard Handling**: Data and structural hazards are resolved automatically using a hazards unit, which employs forwarding or stalls as needed.
- **Memory Access**: Only `LW` and `SW` instructions interact with memory. Memory access is assumed to complete in one clock cycle and operates synchronously with the CPU.

### ANN Instruction
The `ANN` instruction implements a single-node Artificial Neural Network. It computes the weighted sum of inputs and produces an output, which is fed back as input in a single-node feedback system. The weighted sum is calculated as:

Y = W1 × I1 + W2 × I2 + ... + Wn × In


Where:
- **I** = { I1, I2, I3, ..., In } are the input values.
- **W** = { W1, W2, W3, ..., Wn } are the weights associated with each input.

### WGHT Instruction
The `WGHT` instruction sets the weights for the ANN operation. For example:
- `WGHT R1, R2, R3` sets W1 = R1, W2 = R2, and W3 = R3 (where W3 is the feedback weight).
