// ALU of RISC V:

module ALU(ALUResult, zero, ALUControl, SrcA, SrcB);
	output logic [31:0] ALUResult;
	output logic zero;
	input logic [2:0] ALUControl;
	input logic [31:0] SrcA, SrcB;

always_comb begin
	case(ALUControl)
		3'b000: ALUResult = SrcA + SrcB;	// For Addition
		3'b001: ALUResult = SrcA - SrcB;	// For Subtraction
		3'b011: ALUResult = SrcA | SrcB;	// For Or operation
		// Default Case:
		default: ALUResult = 32'bx;
	endcase 
	if(ALUResult == 32'b0) 
		zero = 1'b1;
	else
		zero = 1'b0;
end

endmodule

