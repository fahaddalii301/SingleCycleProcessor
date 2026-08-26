
// RISC-V Single Cycle Processor: Top Entity File.


module riscv (PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, Result, clock, reset);
 
    output logic [31:0] Result; //write data for register file
    output logic PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
    output logic [2:0] ALUControl;
    output logic [1:0] ImmSrc;
    input logic clock, reset;

    // Internal signals
    logic [31:0] PCNext, PC;              // Program Counter
    logic [31:0] PCPlus4;                 // Adder output (PC + 4)
    logic [31:0] instruction;             // Instruction memory output
    logic [31:0] imm_data;                // Immediate extended data
    logic [31:0] PCTarget;                // Target PC for branch

    // Instruction fields (extracted)
    logic [6:0]  Opcode;            // Opcode
    logic [2:0]  func3;             //function 3
    logic [6:0] func7;              //function 7
    logic [4:0]  RS1, RS2, RD;      // source and destination registers of register file

    logic [31:0] read_data1, read_data2;  // Register file output
    logic [31:0] SrcB;                    // ALU input B
    logic        zero;                    // ALU zero flag
    logic [31:0] ALUResult;               // Result of ALU
    logic [31:0] ReadData; //output of data memory, input to risc v
           

    // Module Instantiations
    
    // --- PC Mux --- //
    PCmux PCM(
        .PCNext(PCNext),
        .PCPlus4(PCPlus4),
        .PCTarget(PCTarget),
        .PCSrc(PCSrc)
    );

    // --- Program Counter Register --- //
    pc PC_reg(
        .PC(PC),
        .PCNext(PCNext),
        .clock(clock),
        .reset(reset)
    );

localparam [31:0] pc_increment = 32'd4;
 // --- PC + 4 Adder --- //
    pc_adder PCA(
        .PCPlus4(PCPlus4),
        .PC(PC),
        .pc_increment(pc_increment)
    );

    // --- Instruction Memory --- //
    instr_mem IM(
        .instruction(instruction),
        .instr_address(PC)
    );

    // --- Control Unit (Main + ALU decoders inside) --- //
    control_unit CU(
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl),
        .zero(zero),
        .Opcode(Opcode),
        .func3(func3)
    );

    // --- Register File --- //
    register_file RF(
        .read_data1(read_data1),
        .read_data2(read_data2),
        .RS1(RS1),
        .RS2(RS2),
        .RD(RD),
        .write_data(Result),
        .RegWrite(RegWrite),
        .clock(clock)
    );

    // --- Immediate Extender --- //
    ImmExt IE(
        .imm_data(imm_data),
        .instruction(instruction),
        .ImmSrc(ImmSrc)
    );

    // --- ALU Source Mux --- //
    ALUmux ALU_MUX(
        .SrcB(SrcB),
        .read_data2(read_data2),
        .imm_data(imm_data),
        .ALUSrc(ALUSrc)
    );

    // --- ALU --- //
    ALU ALU_main(
        .ALUResult(ALUResult),
        .zero(zero),
        .ALUControl(ALUControl),
        .SrcA(read_data1),
        .SrcB(SrcB)
    );

    // --- Data Memory ---
    data_memory DM(
        .ReadData(ReadData),
        .mem_address(ALUResult),
        .WriteData(read_data2),
        .MemWrite(MemWrite),
        .clock(clock)
    );

    // --- Result Mux --- //
    result_mux RM(
        .Result(Result),
        .ALUResult(ALUResult),
        .ReadData(ReadData),
        .ResultSrc(ResultSrc)
    );

    // --- Branch Target Address Adder --- //
    branch_adder BA(
        .PCTarget(PCTarget),
        .imm_data(imm_data),
        .PC(PC)
    );


    // -----------------------
    // Additional wiring / assignments
    // -----------------------

    // Extract instruction fields for decoders and register-file addressing:
    assign func7 = instruction[31:25];
    assign RS2    = instruction[24:20];
    assign RS1    = instruction[19:15];
    assign func3 = instruction[14:12];
    assign RD     = instruction[11:7];
    assign Opcode = instruction[6:0];


endmodule


