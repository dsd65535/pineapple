module programCounter(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge);
parameter addrWidth = 4; // ceil(20480 log 2)
parameter depth = 2**addrWidth; // 40960, at least

input clk, sclkPosEdge, pcEn;
output reg[addrWidth-1:0] memAddr;
input sclk8PosEdge;

initial memAddr = 0;

always @(posedge clk ) begin
	if (sclk8PosEdge == 1 && pcEn == 1) begin
		if (memAddr == depth - 1) memAddr <= 93;
		else memAddr <= memAddr + 1;
	end
end
endmodule



