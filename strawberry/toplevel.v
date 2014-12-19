`include "shiftRegister.v"
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

// mosiFF
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
assign gpioBank1[1] = cq; // mosi again because why not
assign gpioBank1[2] = dq; // chip select
assign gpioBank1[3] = sclkPosEdge; // data/command
//assign led[7:0] = parallelDataOut[7:0];
assign led[3:0] = memAddr[3:0];
assign led[4] = sclk;
assign led[5] = mq;
assign led[6] = cs;
assign led[7] = dc;
assign reset = sw[0];
assign gpioBank2[0] = !btn[1];
assign gpioBank2[1] = !btn[1];
assign gpioBank2[2] = !btn[1];
assign gpioBank2[3] = !btn[1];


// Magic
serialClock #(19) sc(clk, sclk, sclkPosEdge, sclkNegEdge, sclk8PosEdge);
memory m(clk, writeEnable, addr, dataIn, dataOut);
programCounter pc(clk, sclkPosEdge, pcEn, memAddr, sclk8PosEdge, reset);
shiftRegister sr(clk, sclkPosEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut, sclk8PosEdge);
finiteStateMachine fsm(clk, sclkPosEdge, instr, cs, dc, delayEn, parallelData);
mosiFF mff(clk, sclkNegEdge, md, mq);
mosiFF csff(clk, sclkNegEdge, cd, cq);
mosiFF dcff(clk, sclkNegEdge, dd, dq);
delayCounter delC(clk, delayEn, pcEn);

endmodule

