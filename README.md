# Single-Cycle RISC-V Processor (RV32I) – Verilog Implementation

This project implements a **single-cycle RISC-V processor** based on the RV32I instruction set architecture. The design executes each instruction in a single clock cycle and is written entirely in **Verilog HDL**.

The project is aimed at understanding processor datapaths, control logic, and instruction execution in a minimal yet complete RISC-V CPU.

The Rtl Design
![image](https://github.com/user-attachments/assets/1455b193-5228-4860-a95f-95c5fd4cbd2c)


## ⚙️ Features

- Supports key RV32I instructions:
  - Arithmetic: `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL`, etc.
  - Immediate: `ADDI`, `ANDI`, `ORI`, `XORI`, etc.
  - Load/Store: `LW`, `SW`
  - Branch: `BEQ`, `BNE`
  - Jump: `JAL`, `JALR`
  - Other: `LUI`, `AUIPC`
- Single clock-cycle per instruction execution
- Modular Verilog design for clarity and reusability

---

## 🗂️ Module Overview

- `program_counter.v` – Holds and updates the PC
- `instr_mem.v` – Instruction memory (read-only)
- `register_file.v` – 32x32-bit register file
- `alu.v` – Performs arithmetic and logic operations
- `control_unit.v` – Generates control signals based on opcode
- `imm_generator.v` – Extracts and sign-extends immediate values
- `data_mem.v` – Simulates memory for `LW`/`SW` instructions
- `top.v` – Top-level module connecting all components

---

## 🧪 Testbench

- `testbench.v` – Runs a program with a sequence of instructions
- `$display` and `$monitor` used to trace register and memory state
- Optionally includes `.hex` or `.mem` file loader for programs

Tools : Intel Quartus Prime 
