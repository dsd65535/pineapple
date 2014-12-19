`include "ShiftRegister.v"
`include "memory.v"
`include "finiteStateMachine.v"
`include "programCounter.v"
`include "serialClock.v"
`include "mosiFF.v"
`include "delayCounter.v"

module toplevel(led, gpioBank1, gpioBank2, clk, sw, btn); // possible inputs from fpga
output [7:0] led;
output [3:0] gpioBank1;
output [3:0] gpioBank2;
input clk;
input[7:0] sw;
input[3:0] btn;

parameter memBits = 10;
parameter memAddrWidth = 16;
parameter dataBits = 8;

// serialClock
wire sclk, sclkPosEdge, sclkNegEdge;
wire sclk8PosEdge;

// memory
wire writeEnable;
wire[memAddrWidth-1:0] addr;
wire[memBits-1:0] dataIn, dataOut;

// programCounter
wire[memAddrWidth-1:0] memAddr;
wire reset;
assign addr = memAddr;

// shiftRegister
wire parallelLoad, serialDataIn; //not used
wire[dataBits-1:0] parallelDataOut; // also not used
wire[dataBits-1:0] parallelDataIn;
wire serialDataOut;
assign parallelLoad = sclk8PosEdge;
assign parallelDataIn = dataOut;

// finiteStateMachine
wire[memBits-1:0] instr; // probably change this to reflect envelope diagram
wire cs, dc;
wire[dataBits-1:0] parallelData;
assign instr = dataOut;

// FFs
wire md, mq;
assign md = serialDataOut;
wire cd, cq;
assign cd = cs;
wire dd, dq;
assign dd = dc;

// delayCounter
wire delayEn, pcEn;

// OUTPUTS
assign gpioBank1[0] = mq; // mosi
assign gpioBank1[1] = cq; // chip select
assign gpioBank1[2] = dq; // data/command select
assign gpioBank1[3] = sclkPosEdge; // serialClock (positive edge)
assign led = parallelDataOut[7:0];
assign reset = btn[0];
assign gpioBank2[0] = !btn[1];

// Magic
serialClock #(3) sc(clk, sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge);
memory m(clk, writeEnable, addr, dataIn, dataOut);
programCounter pc(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge, reset);
shiftRegister sr(clk, sclkPosEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut, sclk8PosEdge);
finiteStateMachine fsm(clk, sclkPosEdge, instr, cs, dc, delayEn, parallelData);
mosiFF mff(clk, sclkNegEdge, md, mq);
mosiFF csff(clk, sclkNegEdge, cd, cq);
mosiFF dcff(clk, sclkNegEdge, dd, dq);
delayCounter delC(clk, delayEn, pcEn);

endmodule

module testTopLevel;
wire [7:0] led;
wire [3:0] gpioBank1;
wire[3:0] gpioBank2;
reg clk;
reg[7:0] sw;
reg[3:0] btn;

toplevel tl(led, gpioBank1, gpioBank2, clk, sw, btn);

initial clk=0;
always #10 clk=!clk;

//initial begin
//#7850 btn[0]=1;
//#10 btn[0]=0;
//end

endmodule

