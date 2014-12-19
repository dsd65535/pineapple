module memory(clk, writeEnable, addr, dataIn, dataOut);
// we have 128x160 pixels = 20480 total --> 15 bits for addr, 16 bits per pixel
// BUT we only send 8 bits at a time as per SPI, and we're storing our 2 bit opcodes so width is 10
parameter width = 10;
parameter addrWidth = 16; // ceil(log base 2 of 128*160*2)
parameter depth = 43000;

input clk, writeEnable;
input[addrWidth-1:0] addr;
input[width-1:0] dataIn;
output[width-1:0] dataOut;

reg [width-1:0] mem[depth-1:0];
blk_mem_gen_v7_3 memory(
	.addra(addr),
	.clka(clk),
	.douta(dataOut)
);
//always @(*) begin
//	if (writeEnable) begin
//		mem[addr] <= dataIn;
//	end
//end

//initial mem[0] = 10'h200; // this worked before
 

//initial mem = {10'h200, 10'h101, 10'h200, 10'h111, 10'h200, 10'h1B1, 10'h001, 10'h02C, 10'h02D, 10'h1B2};

//initial $readmemh("shortmem.dat", mem);

//assign dataOut = mem[addr];

endmodule


