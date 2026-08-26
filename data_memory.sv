// Data Memory:

module data_memory(ReadData, mem_address, WriteData, MemWrite, clock);
	output logic [31:0] ReadData;
	input logic [31:0] mem_address /* (ALUresult) */, WriteData;  //(read_data2 of rf)
	input logic MemWrite, clock;

// Memory:
logic [7:0] memory [63:0];

integer i;

// Initializing the data memory with arbitrary known values:
initial begin
	for(i=0; i<64; i=i+1) begin
		memory[i] = i;
	end
end

// Reading data from data memory:
assign ReadData = {memory[mem_address+3], memory[mem_address+2], memory[mem_address+1], memory[mem_address+0]};

// Writing data to data memory:
always @(posedge clock) begin
	if(MemWrite)
		{memory[mem_address+3], memory[mem_address+2], memory[mem_address+1], memory[mem_address+0]} <= WriteData;
end
endmodule
