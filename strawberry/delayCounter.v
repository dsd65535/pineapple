module delayCounter(clk, delayEn, pcEn);
input clk, delayEn;
output reg pcEn;

parameter delayCycles = 3;
parameter maxDelay = 2**delayCycles-1;

reg[delayCycles-1:0] delayCount;
initial delayCount = 0;

always @(posedge delayEn) begin
//	delayCount = maxDelay;
//	pcEn=0;
//	#500
//	pcEn=1;
end

//always @(posedge clk) begin
//	if (delayCount != 0) begin
//		delayCount = delayCount - 1;
//		pcEn = 0;
//	end else begin
//		pcEn = 1;
//	end
//end

endmodule
