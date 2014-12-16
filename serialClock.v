module serialClock(clk, sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge);
input clk;
output reg sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge;

parameter bits = 5;
parameter counttime = 2**bits-1;
reg[bits-1:0] count;
reg[2:0] count8;

initial count = 0;
initial count8 = 0;
initial sclk = 0;

always @(posedge clk) begin
	if (count == 0) begin
		if (sclk == 0) begin
			sclkPosEdge = 1;
			count8=(count8+1)%8;
			if (count8==0) sclk8PosEdge = 1;
		end else begin
			sclkNegEdge = 1;
		end
		sclk=!sclk;
	end else begin
		sclkPosEdge = 0;
		sclkNegEdge = 0;
		sclk8PosEdge = 0;
	end
	count = (count + 1) % counttime;
end

endmodule

module testSclk;
reg clk;
wire sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge;

serialClock sc(clk, sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge);

initial clk = 0;
always #10 clk=!clk;

endmodule
