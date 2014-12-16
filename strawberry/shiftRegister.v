module shiftRegister(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
parameter width = 8;
input               clk;
input               peripheralClkEdge;
input               parallelLoad;
output[width-1:0]   parallelDataOut;
output              serialDataOut;
input[width-1:0]    parallelDataIn;
input               serialDataIn;

reg[width-1:0]      shiftRegisterMem;

assign serialDataOut=shiftRegisterMem[width-1];
assign parallelDataOut=shiftRegisterMem;

always @(posedge peripheralClkEdge) begin
	shiftRegisterMem = {shiftRegisterMem[width-2:0],serialDataIn};
	if (parallelLoad==1) begin
		shiftRegisterMem = parallelDataIn;
	end
end
endmodule

