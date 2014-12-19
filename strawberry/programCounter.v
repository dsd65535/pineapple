module programCounter(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge, reset);
parameter addrWidth = 16; // ceil(20480 log 2)
parameter depth = 41065; // 40960, at least

input clk, sclkPosEdge, pcEn, reset;
output reg[addrWidth-1:0] memAddr;
input sclk8PosEdge;

initial memAddr = 0;

always @(posedge sclk8PosEdge ) begin
	if (pcEn == 1) begin
		if (memAddr == depth - 1) memAddr = 93;
		else memAddr = memAddr + 1;
	end
	if(reset) memAddr=0;
end

endmodule



