
// Program Counter Mux:

module PCmux(PCNext, PCPlus4, PCTarget, PCSrc);
	output logic [31:0] PCNext;
	input logic [31:0] PCPlus4, PCTarget;
	input logic PCSrc;

assign PCNext = PCSrc ? PCTarget : PCPlus4;
endmodule
