`include "serialClock.v"

module programCounter(clk, sclkPosEdge, pcEn, memAddr);
parameter depth = 20480; // make this a parameter in an upper level module
parameter addrWidth = 15; // ceil(20480 log 2)

input clk, sclkPosEdge, pcEn;
output reg[addrWidth-1:0] memAddr;

initial memAddr = 0;

always @(posedge clk) begin
	if (sclkPosEdge == 1 && pcEn == 1) begin
		if (memAddr == depth-1) begin
			memAddr <= 0;
		end else begin
			memAddr <= memAddr + 1;
		end
	end
end

endmodule


module testProgramCounter;
reg clk, pcEn;
wire sclk, sclkPosEdge, sclkNegEdge;
parameter addrWidth = 15;
wire [addrWidth-1:0] memAddr;

serialClock #(2) sc(clk, sclk, sclkPosEdge, sclkNegEdge);
programCounter pc(clk, sclkPosEdge, pcEn, memAddr);

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
