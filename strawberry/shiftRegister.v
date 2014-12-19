module shiftRegister(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut, peripheralClk8Edge);
parameter width = 8;
input               clk;
input               peripheralClkEdge;
input               peripheralClk8Edge;
input               parallelLoad;
output[width-1:0]   parallelDataOut;
output              serialDataOut;
input[width-1:0]    parallelDataIn;
input               serialDataIn;

reg[width-1:0]      shiftRegisterMem;

assign serialDataOut=shiftRegisterMem[width-1];
assign parallelDataOut=shiftRegisterMem;

always @(posedge peripheralClkEdge) begin
	shiftRegisterMem <= {shiftRegisterMem[width-2:0],serialDataIn};
	#20;
	if(parallelLoad) shiftRegisterMem <= parallelDataIn;
end


endmodule

