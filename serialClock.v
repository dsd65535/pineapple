module serialClock(clk, sclk, sclkPosEdge, sclkNegEdge);
input clk;
output reg sclk, sclkPosEdge, sclkNegEdge;

parameter bits = 5;
parameter counttime = 2**bits-1;
reg[bits-1:0] count;

initial count = 0;
initial sclk = 0;

always @(posedge clk) begin
	if (count == counttime) begin
		if (sclk == 0) begin
			 sclkPosEdge = 1;
		end else begin
			sclkNegEdge = 1;
		end
		sclk=!sclk;
		count = 0;
	end else begin
		sclkPosEdge = 0;
		sclkNegEdge = 0;
		count = count + 1;
	end
end

endmodule

module testSclk;
reg clk;
wire sclk, sclkPosEdge, sclkNegEdge;

serialClock sc(clk, sclk, sclkPosEdge, sclkNegEdge);

initial clk = 0;
always #10 clk=!clk;

endmodule
