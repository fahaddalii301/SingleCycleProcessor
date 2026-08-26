module pc(PC, PCNext, clock, reset);
	output logic [31:0] PC;
	input logic [31:0] PCNext;
	input logic clock, reset;                                                                                                                                                              
always_ff @(posedge clock) begin
	if(reset) 
		PC <= 32'b0;
	else
		PC <= PCNext;
end
endmodule
