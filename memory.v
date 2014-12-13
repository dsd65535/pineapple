module memory(clk, writeEnable, addr, dataIn, dataOut);
// we have 128x160 pixels = 20480 total --> 15 bits for addr, 16 bits per pixel
input clk, writeEnable;
input[14:0] addr;
input[15:0] dataIn;
output[15:0] dataOut;

reg [15:0] mem[20479:0];
always @(posedge clk)
	if (writeEnable) mem[addr] <= dataIn;
initial $readmemb("memb.dat", mem);

assign DataOut = mem[addr];

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
