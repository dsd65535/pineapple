`include "serialClock.v"

module programCounter(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge, reset);
parameter addrWidth = 16; // ceil(20480 log 2)
parameter depth = 2**addrWidth; // 40960, at least

input clk, sclkPosEdge, pcEn, reset;
output reg[addrWidth-1:0] memAddr;
input sclk8PosEdge;

initial memAddr = 0;

always @( posedge sclk8PosEdge ) begin
	if (pcEn == 1) begin
		if (memAddr == depth - 1) memAddr <= 93;
		else memAddr <= memAddr + 1;
	end
end
always @( negedge reset ) memAddr <= 0;
endmodule


module testProgramCounter;
reg clk, pcEn;
wire sclk, sclkPosEdge, sclkNegEdge, next;
parameter addrWidth = 16;
wire [addrWidth-1:0] memAddr;

serialClock #(2) sc(clk, sclk, sclkPosEdge, sclkNegEdge);
programCounter pc(clk, sclkPosEdge, pcEn, memAddr, next);

initial clk=0;
always #10 clk=!clk;

initial begin
pcEn=1;
#500
pcEn=0;
#500;
pcEn=1;
end

endmodule
