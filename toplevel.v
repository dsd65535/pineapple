`include "ShiftRegister.v"
`include "memory.v"
`include "finiteStateMachine.v"
`include "programCounter.v"
`include "serialClock.v"
`include "mosiFF.v"

module toplevel(led, gpioBank1, gpioBank2, clk, sw, btn); // possible inputs from fpga
output [7:0] led;
output [3:0] gpioBank1;
input[3:0] gpioBank2;
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
wire cs, dc, pcEn;
wire[dataBits-1:0] parallelData;
assign instr = dataOut;

// mosiFF
wire d, q;
assign d = serialDataOut;

// OUTPUTS
assign gpioBank1[0] = q; // mosi
assign gpioBank1[1] = sclk; // mosi again because why not
assign gpioBank1[2] = sclk8PosEdge; // chip select
assign gpioBank1[3] = sclkPosEdge; // data/command
assign led = parallelDataOut[7:0];

// Magic
serialClock #(3) sc(clk, sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge);
memory m(clk, writeEnable, addr, dataIn, dataOut);
programCounter pc(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge);
shiftRegister sr(clk, sclkPosEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
finiteStateMachine fsm(clk, sclkPosEdge, instr, cs, dc, pcEn, parallelData);
mosiFF mff(clk, sclkNegEdge, d, q);

endmodule

module testTopLevel;
wire [7:0] led;
wire [3:0] gpioBank1;
reg[3:0] gpioBank2;
reg clk;
reg[7:0] sw;
reg[3:0] btn;

toplevel tl(led, gpioBank1, gpioBank2, clk, sw, btn);

initial clk=0;
always #10 clk=!clk;

endmodule

