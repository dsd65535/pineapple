module finiteStateMachine(clk, sclkEdge, instr, cs, dc, pcEn);
input clk, sclkEdge;
input[17:0] instr;
output reg cs, dc pcEn;

reg[1:0] currentState = 0;

//states: write data, write command, idle

always @(posedge clk) begin
	if 
	case(currentState) 
		0 : begin // write command
			misoEn = 1;
			dc = 1;
			cs = 0;
			
		end
		1 : begin // write data
			misoEn = 1;
			dc = 0;
			cs = 0;
		end 
		2 : begin // delay
			misoEn = 0;
			dc = 1; // but we don't actually care
			cs = 1;
		end
	endcase
end
endmodule
