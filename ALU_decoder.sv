// ALU Decoder:

module ALU_decoder(ALUControl, ALUOp, func3);
	output logic [2:0] ALUControl;
	input logic [1:0] ALUOp;
	input logic [2:0] func3;

always_comb begin
	case(ALUOp)
		2'b00: ALUControl = 3'b000; // (ADD) For lw, sw instruction
		2'b01: ALUControl = 3'b001; // (SUB) For branch instruction
		2'b10: begin
			if(func3 == 3'b000)
				ALUControl = 3'b000; // (ADD) For addi instruction
			else if(func3 == 3'b110)
				ALUControl = 3'b011; // (OR) For OR operation
			else 
				ALUControl = 3'bxxx;
		end
		default: ALUControl = 3'bxxx;
	endcase
end

endmodule

