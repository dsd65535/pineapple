module shiftRegister(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
parameter width = 8;
input               clk;
input               peripheralClkEdge;
input               parallelLoad;
output[width-1:0]   parallelDataOut;
output              serialDataOut;
input[width-1:0]    parallelDataIn;
input               serialDataIn;

reg[width-1:0]      shiftRegisterMem;

assign serialDataOut=shiftRegisterMem[0];
assign parallelDataOut=shiftRegisterMem;

always @(posedge peripheralClkEdge) begin
	shiftRegisterMem = {serialDataIn,shiftRegisterMem[width-1:1]};
	if (parallelLoad==1) begin
		shiftRegisterMem = parallelDataIn;
	end
end
endmodule

module testShiftRegister;
parameter width = 8;
reg             clk;
reg             peripheralClkEdge;
reg             parallelLoad;
wire[width-1:0] parallelDataOut;
wire            serialDataOut;
reg[width-1:0]  parallelDataIn;
reg             serialDataIn; 

reg [4:0] sclk_temp;

shiftregister #(width) sr(clk, peripheralClkEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);

initial begin clk=0; sclk_temp=0; end
always #10 clk=!clk;
initial parallelDataIn=16'hA5;

// serial clock
always #10 begin
	sclk_temp=sclk_temp+1;
	sclk_temp=sclk_temp % 10;
	if (sclk_temp==1) peripheralClkEdge=1;
	else peripheralClkEdge=0;
end

initial begin

parallelLoad=0; 

serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1;
parallelLoad=1; #20
parallelLoad=0; #180
serialDataIn=0; #200
serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1; #200
serialDataIn=0; #200
serialDataIn=1;


//parallelLoad=0;
//$display("%b", parallelDataOut);
//serialDataIn=1;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//serialDataIn=1;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//serialDataIn=0;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//serialDataIn=1;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//serialDataIn=1;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//serialDataIn=0;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//$display("%b", parallelDataOut);
//parallelLoad=1;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//parallelLoad=0;
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0; #90
//peripheralClkEdge=1; #10
//peripheralClkEdge=0;
//$display("%b", parallelDataOut);
end

endmodule

