
// ALU Mux:

module ALUmux(SrcB, read_data2, imm_data, ALUSrc);
	output logic [31:0] SrcB;
	input logic [31:0] read_data2, imm_data;
	input logic ALUSrc;

assign SrcB = ALUSrc ? imm_data : read_data2;

endmodule

