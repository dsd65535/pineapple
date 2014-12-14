module serialClock(clk, sclk, sclkEdge);
input clk;
output reg sclk, sclkEdge;

parameter bits = 5;
parameter counttime = 2**bits-1;
reg[bits-1:0] count;

initial count = 0;
initial sclk = 0;

always @(posedge clk) begin
	if (count == counttime) begin
		if (sclk == 0) begin
			 sclkEdge = 1;
		end
		sclk=!sclk;
		count = 0;
	end else begin
		sclkEdge = 0;
		count = count + 1;
	end
end

endmodule

module testSclk;
reg clk;
wire sclk, sclkEdge;

serialClock sc(clk, sclk, sclkEdge);

initial clk = 0;
always #10 clk=!clk;

endmodule
