
// Control Unit:

module control_unit(PCSrc, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite, ALUControl, zero, Opcode, func3);
	
	// Output signals of control unit:
	output logic PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite;
	output logic [1:0] ImmSrc;
	output logic [2:0] ALUControl;
	// Input signals of control unit:
	input logic zero;
	input logic [6:0] Opcode;
	input logic [2:0] func3;
	
	// Internal Branch signal:
	logic Branch;
	// Internal ALUop signal connecting main decoder and ALU decoder:
	logic [1:0] ALUOp;

// Instance of Main Decoder:
main_decoder main_dec(
	.Branch(Branch),
	.ResultSrc(ResultSrc),
	.MemWrite(MemWrite),
	.ALUSrc(ALUSrc),
	.ImmSrc(ImmSrc),
	.RegWrite(RegWrite),
	.ALUOp(ALUOp),
	.Opcode(Opcode)
	);

// Instance of ALU Decoder:
ALU_decoder alu_dec(
	.ALUOp(ALUOp),
	.ALUControl(ALUControl),
	.func3(func3)
	);

// PCSrc signal generation:
assign PCSrc = Branch & zero;

endmodule
