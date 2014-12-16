module finiteStateMachine(clk, sclkPosEdge, instr, cs, dc, delayEn, parallelData);
input clk, sclkPosEdge;
input[9:0] instr;
output reg cs, dc, delayEn;
output[7:0] parallelData;
wire[1:0] code;

assign code = instr[9:8]; // our makeshift opcodes
assign parallelData = instr[7:0]; // what goes to the shift register

//states: write data, write command, delay
always @( * ) begin
	if (code == 2'b00) begin // write data
		$display("writing data");
		cs = 0;
		dc = 1; // data is high
		delayEn = 0;
	end
	if (code == 2'b01) begin  // write command
		$display("writing command");
		cs = 0;
		dc = 0; // command is low
		delayEn = 0;
	end
	if (code == 2'b10) begin // delay
		$display("beginning delay");
		cs = 1;
		delayEn = 1;
	end

end
endmodule

