`timescale 1ns/1ps

module riscv_tb;

    // Processor signals:
    logic clock;
    logic reset;
    logic [31:0] Result;
    logic PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
    logic [2:0] ALUControl;
    logic [1:0] ImmSrc;

    // Instantiation of the processor:
    riscv DUT (
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl),
        .Result(Result),
        .clock(clock),
        .reset(reset)
    );

    // Clock generation: 20 ns period.
    initial begin
    clock = 1'b1;
    forever #10 clock = ~clock;
  end

    // Driving the Stimulus:
    initial begin
        // Initialize reset
        reset = 1'b1;
        #20;
        reset = 1'b0;
        #300;
        $finish;
    end

endmodule
