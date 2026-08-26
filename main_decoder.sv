// Main Decoder:

module main_decoder(RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Opcode);
	output logic RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;
	output logic [1:0] ImmSrc, ALUOp;
	input logic [6:0] Opcode;
	logic [8:0] controls;

// Concatenating the output signals:
assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = controls;

always_comb begin
	case(Opcode)
		// For lw instruction:
		7'b0000011: controls = 9'b1_00_1_0_1_0_00;
		// For sw instruction:
		7'b0100011: controls = 9'b0_01_1_1_x_0_00;
		// For R-type instructions:
		7'b0110011: controls = 9'b1_xx_0_0_0_0_10;
		// For beq instruction:
		7'b1100011: controls = 9'b0_10_0_0_x_1_01;
		// For addi instruction:
		7'b0010011: controls = 9'b1_00_1_0_0_0_10;
		// Default case:
		default: controls = 9'bx_xx_x_x_x_x_xx;
	endcase
end
endmodule
