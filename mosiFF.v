`include "serialClock.v"

module mosiFF(clk, sclkNegEdge, d, q);
input clk, sclkNegEdge, d;
output reg q;

always @(posedge clk) begin
	if (sclkNegEdge == 1) begin
		q <= d;
	end
end
endmodule


module testMosiFF;
reg clk, d;
wire q, sclkPosEdge, sclkNegEdge, sclk;

serialClock #(2) sc(clk, sclk, sclkPosEdge, sclkNegEdge);
mosiFF mff(clk, sclkNegEdge, d, q);

initial clk=0;
always #10 clk=!clk;

initial begin
d = 1;
#500
d = 0;
end

endmodule
