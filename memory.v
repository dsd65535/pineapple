module memory(clk, writeEnable, addr, dataIn, dataOut);
// we have 128x160 pixels = 20480 total --> 15 bits for addr, 16 bits per pixel
// BUT we only send 8 bits at a time as per SPI, and we're storing our 2 bit opcodes so width is 10
parameter width = 10;
parameter addrWidth = 16; // ceil(log base 2 of 128*160*2)
parameter depth = 2**addrWidth;

input clk, writeEnable;
input[addrWidth-1:0] addr;
input[width-1:0] dataIn;
output[width-1:0] dataOut;

reg [width-1:0] mem[depth-1:0];
always @(posedge clk) begin
	if (writeEnable) begin
		mem[addr] <= dataIn;
	end
end

initial $readmemh("mem.dat", mem);

assign dataOut = mem[addr];

endmodule

module testMemory;
parameter width = 10;
parameter addrWidth = 16;

reg clk, writeEnable;
reg[addrWidth-1:0] addr;
reg[width-1:0] dataIn;
wire[width-1:0] dataOut;

memory mem(clk, writeEnable, addr, dataIn, dataOut);

initial clk=0;
always #10 clk=!clk; 

initial begin
writeEnable=0;
dataIn=0;
addr = 0;
$display("%d,%h",addr,dataOut); #20
addr = 1;
$display("%d,%h",addr,dataOut); #20
addr = 2;
$display("%d,%h",addr,dataOut); #20
addr = 3;
$display("%d,%h",addr,dataOut); #20
addr = 4;
$display("%d,%h",addr,dataOut);
end

endmodule
