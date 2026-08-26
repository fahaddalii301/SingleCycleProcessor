// Register File:

module register_file(read_data1, read_data2, RS1, RS2, RD, write_data, RegWrite, clock);
	output logic [31:0] read_data1, read_data2;
	input logic [4:0] RS1, RS2, RD;
	input logic [31:0] write_data;
	input logic RegWrite, clock;

integer i;

// 32 registers each of 32-bit:
logic [31:0] registers [31:0];

// Initializing the registers:
initial begin
	for (i=0; i<32; i=i+1) begin
		registers[i] = i;
	end
end

// Read Source Register 1:
assign read_data1 = (RS1 == 5'b00000) ? 32'b0 : registers[RS1];	// if RS1 = x0 ==> read_data1 = 0;

// Read Source Register 2:
assign read_data2 = (RS2 == 5'b00000) ? 32'b0 : registers[RS2];	// if RS2 = x0 ==> read_data2 = 0;

// Write data logic:
always @(posedge clock) begin
	if(RegWrite)
		registers[RD] <= write_data;
end

endmodule

