`include "serialClock.v"

module programCounter(clk, sclkPosEdge, pcEn, memAddr, next);
parameter addrWidth = 16; // ceil(20480 log 2)
parameter depth = 2**addrWidth; // 40960, at least
parameter numCycles = 8; // wait for SPI to clock out 8 before moving

input clk, sclkPosEdge, pcEn;
output reg[addrWidth-1:0] memAddr;
output reg next;

reg[2:0] count = 0;

initial memAddr = 0;

always @(posedge clk) begin
	next = 0;
	if (sclkPosEdge == 1 && pcEn == 1) begin
		if (count==numCycles-1) begin // if we're done waiting to clock out, move to a new thing
			count <= 0;
			next = 1;
			if (memAddr == depth-1) begin // if the memory got to the end, cycle back around
				memAddr <= 0;
			end else begin // if there's still memory left, increment address by 1
				memAddr <= memAddr + 1;
			end
		end else begin // if we're not done waiting, increment wait by 1
			count <= count + 1;
		end		
	end
end

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
