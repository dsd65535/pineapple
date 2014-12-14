`include "ShiftRegister.v"
`include "memory.v"
`include "finiteStateMachine.v"
`include "serialClock.v"

module toplevel(led, gpioBank1, gpioBank2, clk, sw, btn); // possible inputs from fpga
output [7:0] led;
output [3:0] gpioBank1;
input[3:0] gpioBank2;
input clk;
input[7:0] sw;
input[3:0] btn;

memory(clk, writeEnable, addr, dataIn, dataOut);
shiftRegister(clk, sclkNegEdge, parallelLoad, parallelDataIn, serialDataIn, parallelDataOut, serialDataOut);
finiteStateMachine(clk, sclkPosEdge, instr, cs, dc, pcEn, parallelData);
serialClock(clk, sclk, sclkPosEdge, sclkNegEdge);

endmodule
