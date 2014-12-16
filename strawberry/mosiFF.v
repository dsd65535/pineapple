module mosiFF(clk, sclkNegEdge, d, q);
input clk, sclkNegEdge, d;
output reg q;

always @(posedge sclkNegEdge) begin
	q <= d;

end
endmodule

