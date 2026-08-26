// Result Mux:

module result_mux(Result, ALUResult, ReadData, ResultSrc);
	output logic [31:0] Result;
	input logic [31:0] ALUResult, ReadData;
	input logic ResultSrc;

assign Result = ResultSrc ? ReadData : ALUResult;

endmodule
