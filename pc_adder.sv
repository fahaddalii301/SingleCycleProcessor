
// PC Adder Circuit:

module pc_adder(PCPlus4, PC, pc_increment);
	output logic [31:0] PCPlus4;
	input logic [31:0] PC, pc_increment;

assign PCPlus4 = PC + pc_increment;
endmodule

