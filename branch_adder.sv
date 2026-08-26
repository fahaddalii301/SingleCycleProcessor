// Branch address circuit:

module branch_adder(PCTarget, imm_data, PC);
	output logic [31:0] PCTarget;
	input logic [31:0] imm_data, PC;

assign PCTarget = imm_data + PC;

endmodule
