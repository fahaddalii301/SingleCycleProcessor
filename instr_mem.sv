// Instruction Memory:

module instr_mem(instruction, instr_address);
	output logic [31:0] instruction;
	input logic [31:0] instr_address;

// Memory:
logic [7:0] memory [27:0];

// Instructions:
initial begin
// lw x6, -4(x9)
memory[0] = 8'b00000011;
memory[1] = 8'b10100011;
memory[2] = 8'b11000100;
memory[3] = 8'b11111111;

// sw x6, 8(x9)
memory[4] = 8'b00100011;
memory[5] = 8'b10100100;
memory[6] = 8'b01100100;
memory[7] = 8'b00000000;

// or x4, x5, x6
memory[8] = 8'b00110011;
memory[9] = 8'b11100010;
memory[10] = 8'b01100010;
memory[11] = 8'b00000000;

// beq x4, x4, L1
memory[12] = 8'b11100011;
memory[13] = 8'b00001000;
memory[14] = 8'b01100011;
memory[15] = 8'b11111110;

end

// Fetching instruction from instruction memory:
assign instruction = {memory[instr_address+3], memory[instr_address+2], memory[instr_address+1], memory[instr_address+0]};
endmodule

