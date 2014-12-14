module memory(clk, writeEnable, addr, dataIn, dataOut);
// we have 128x160 pixels = 20480 total --> 15 bits for addr, 16 bits per pixel
parameter width = 16;
parameter depth = 20480;

input clk, writeEnable;
input[14:0] addr;
input[width-1:0] dataIn;
output[width-1:0] dataOut;

reg [width-1:0] mem[depth-1:0];
always @(posedge clk) begin
	if (writeEnable) begin
		mem[addr] <= dataIn;
	end
end
initial $readmemb("memb.dat", mem);

assign dataOut = mem[addr];

endmodule

module testMemory;
reg clk, writeEnable;
reg[14:0] addr;
reg[15:0] dataIn;
wire[15:0] dataOut;

memory mem(clk, writeEnable, addr, dataIn, dataOut);

initial clk=0;
always #10 clk=!clk; 

initial begin
writeEnable=0;
addr = 0;
end

endmodule
