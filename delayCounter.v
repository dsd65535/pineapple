module delayCounter(clk, delayEn, pcEn);
input clk, delayEn;
output reg pcEn;

parameter delayCycles = 4;
parameter maxDelay = 2**delayCycles-1;

reg[delayCycles-1:0] delayCount;
initial delayCount = 0;

always @(posedge delayEn) begin
//	delayCount = maxDelay;
//	pcEn=0;
	pcEn=0;
	#5120
	pcEn=1;
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

module testDelayCounter;
reg clk, delayEn;
wire pcEn;

delayCounter del(clk, delayEn, pcEn);

initial clk=0;
always #10 clk=!clk;

initial begin
delayEn=0; #100
delayEn=1;
end

endmodule
