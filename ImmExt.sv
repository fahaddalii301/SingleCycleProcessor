// Immediate Extender:

module ImmExt(imm_data, instruction, ImmSrc);
	output logic [31:0] imm_data;
	input logic [31:0] instruction;
	input logic [1:0] ImmSrc;

always_comb begin
	case(ImmSrc)
		// For I-type instructions:
		2'b00: imm_data = {{20{instruction[31]}}, instruction[31:20]};	
		// For S-type instructions:	
		2'b01: imm_data = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};		
		// For B-type instructions:
		2'b10: imm_data = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};	
		// Default case:
		default: imm_data = 32'bx;
	endcase
end

endmodule
