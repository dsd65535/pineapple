`include "serialClock.v"

module finiteStateMachine(clk, sclkPosEdge, instr, cs, dc, pcEn, parallelData);
input clk, sclkPosEdge;
input[9:0] instr;
output reg cs, dc, pcEn;
output[7:0] parallelData;
wire[1:0] code;

parameter delayCycles = 20;
parameter maxDelay = 2**delayCycles;

reg[delayCycles-1:0] delayCount = 0;

assign code = instr[9:8]; // our makeshift opcodes
assign parallelData = instr[7:0]; // what goes to the shift register

//states: write data, write command, delay
always @(posedge clk) begin
	if (sclkPosEdge == 1) begin
		if (delayCount == 0) begin
			if (code == 2'b00) begin // write data
				$display("writing data");
				cs = 0;
				dc = 1; // data is high
				pcEn = 1;
			end
			if (code == 2'b01) begin  // write command
				$display("writing command");
				cs = 0;
				dc = 0; // command is low
				pcEn = 1;
			end
			if (code == 2'b10) begin // delay
				$display("beginning delay");
				cs = 1;
				pcEn = 0;
				// do we care about dc??
				delayCount = delayCount + 1;
			end
		end else begin
			$display("%d", delayCount);
			if (delayCount == maxDelay) begin
				delayCount = 0;
			end else begin
				delayCount = delayCount + 1;
			end
		end
	end
end
endmodule

module testStateMachine;
reg clk;
reg[9:0] instr;
wire cs, dc, pcEn, sclk, sclkPosEdge, sclkNegEdge;
wire[7:0] parallelData;

serialClock #(2) sc(clk, sclk, sclkPosEdge, sclkNegEdge);
finiteStateMachine fsm(clk, sclkPosEdge, instr, cs, dc, pcEn, parallelData);

initial clk = 0;
always #5 clk=!clk;

initial begin
instr = 10'b0010101010;
#600
instr = 10'b0100110011;
#600
instr = 10'b1010110110;
#600
instr = 10'b0010101010;
end
endmodule

