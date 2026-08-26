# Single-Cycle RISC-V Processor

A modular SystemVerilog/Verilog implementation of a 32-bit single-cycle RISC-V core along with memory components and a top-level verification testbench.

## 📌 Features

- **Single-Cycle Execution:** Processes complete RISC-V integer instructions in one clock cycle.
- **Modular Microarchitecture:** Fully decoupled control logic (`main_decoder`, `ALU_decoder`), datapath multiplexers (`ALUmux`, `PCmux`, `result_mux`), and memory blocks.
- **Instruction & Data Memory:** Includes dedicated `instr_mem` and `data_memory` components.
- **Verification Ready:** Built-in testbench (`riscv_tb.sv`) for simulation and functional validation.

---

## 🏗️ Architecture Overview

The core processor comprises the following sub-modules:

* **`riscv.sv`**: Top-level module connecting the RISC-V core and datapath sub-components.
* **`ALU.sv`**: Executes arithmetic and logic operations.
* **`ALU_decoder.sv`**: Decodes opcode/funct fields into ALU operation control signals.
* **`main_decoder.sv`**: Generates primary control signals for multiplexers, register file writes, and memory access.
* **`control_unit.sv`**: Combines `main_decoder` and `ALU_decoder` to coordinate full core operations.
* **`register_file.sv`**: 32-register integer file supporting concurrent dual-read and single-write operations.
* **`ImmExt.sv`**: Immediate extender for standard instruction formats (I, S, B, J, U-types).
* **`instr_mem.sv`**: Instruction memory holding executable machine code.
* **`data_memory.sv`**: Data memory for load and store operations.
* **`pc.sv`**: Program Counter register.
* **`pc_adder.sv`**: Sequential Program Counter incrementer ($PC + 4$).
* **`branch_adder.sv`**: Calculates target branch/jump addresses.
* **`PCmux.sv`**: Selects between sequential ($PC + 4$) and branch/jump target addresses.
* **`ALUmux.sv`**: Selects register output or sign-extended immediate as ALU operand B.
* **`result_mux.sv`**: Multiplexer selecting ALU result, data memory output, or PC return address for register writeback.

---

## 📁 Directory Structure

```text
.
├── rtl/
│   ├── ALU.sv              # Arithmetic Logic Unit
│   ├── ALU_decoder.sv      # ALU control signal decoder
│   ├── ALUmux.sv           # Multiplexer for ALU second operand selection
│   ├── branch_adder.sv     # Branch address offset adder
│   ├── control_unit.sv     # Central Control Unit logic
│   ├── data_memory.sv      # Data memory (RAM)
│   ├── ImmExt.sv           # Immediate value sign extension logic
│   ├── instr_mem.sv        # Instruction memory (ROM)
│   ├── main_decoder.sv     # Main opcode instruction decoder
│   ├── pc.sv               # Program Counter register
│   ├── pc_adder.sv         # PC + 4 adder
│   ├── PCmux.sv            # Program Counter input selection multiplexer
│   ├── register_file.sv    # 32-entry RISC-V Register File
│   ├── result_mux.sv       # Writeback result multiplexer
│   └── riscv.sv            # Top-level RISC-V processor core
├── tb/
│   └── riscv_tb.sv         # Testbench module for verifying top-level processor
└── README.md

## Bash
# 1. Create working library
vlib work

# 2. Compile RTL files and testbench
vlog -sv rtl/ALU.sv \
         rtl/ALU_decoder.sv \
         rtl/ALUmux.sv \
         rtl/branch_adder.sv \
         rtl/main_decoder.sv \
         rtl/control_unit.sv \
         rtl/data_memory.sv \
         rtl/ImmExt.sv \
         rtl/instr_mem.sv \
         rtl/pc.sv \
         rtl/pc_adder.sv \
         rtl/PCmux.sv \
         rtl/register_file.sv \
         rtl/result_mux.sv \
         rtl/riscv.sv \
         tb/riscv_tb.sv

# 3. Run simulation in Command-Line mode
vsim -c riscv_tb -do "run -all; exit"

# 4. Alternatively, launch simulation in GUI mode
vsim -gui riscv_tb -do "add wave -r /*; run -all"
