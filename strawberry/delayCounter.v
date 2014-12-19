module delayCounter(clk, delayEn, pcEn);
input clk, delayEn;
output reg pcEn;

parameter delayCycles = 4;
parameter maxDelay = 2**delayCycles-1;

reg[delayCycles-1:0] delayCount;
initial delayCount = 0;

always @(posedge delayEn) begin
//	delayCount = maxDelay;
<<<<<<< HEAD
	pcEn=0;
	#5000000000
	pcEn=1;
=======
//	pcEn=0;
//	#500
//	pcEn=1;
>>>>>>> 54038b48aeabe34939b5221cabfc1667e8339c65
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
