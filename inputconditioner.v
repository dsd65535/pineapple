
module inputconditioner(clk, noisysignal, conditioned, positiveedge, negativeedge);
output reg conditioned = 0;
output reg positiveedge = 0;
output reg negativeedge = 0;
input clk, noisysignal;

// variables
parameter counterwidth = 5;
parameter waittime = 10;
reg[counterwidth-1:0] counter = 0;
reg sync0 = 0;
reg sync1 = 0;

always @(posedge clk) begin
	// if last bit of buffer is the same as conditioned, 
	// no need to wait to see if change is consistent
	if (conditioned == sync1) begin
		counter <= 0;
		positiveedge <= 0;
		negativeedge <= 0;
	// otherwise we check the counter
	end else begin 
		// if the counter is at the end point, we approve this input
		if (counter == waittime) begin
			counter <= 0;
			conditioned <= sync1;
			// we know this is an edge--check if rising or falling
			if (sync1 == 1) begin
					positiveedge <= 1;
			end else begin
					negativeedge <= 1;
			end
		// otherwise we increment
		end else begin
			counter <= counter + 1;
		end
	end
	sync1 = sync0;
	sync0 = noisysignal;
	
end

endmodule


module testConditioner;
wire conditioned;
wire rising;
wire falling;
reg pin, clk;
reg ri;
always @(posedge clk) ri=rising;
inputconditioner dut(clk, pin, conditioned, rising, falling);

initial clk=0;
always #10 clk=!clk;    // 50MHz Clock

initial begin
// Your Test Code
// Be sure to test each of the three things the conditioner does:
// Synchronize, Clean, Preprocess (edge finding)

$display("Test Edge Finding");
pin=0; #1010
$display("pin=0; #1010 | expect 0 0 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
pin=1; #20
$display("pin=1; #20 | expect 1 0 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
#240
$display("wait #240 | expect 1 1 1 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
#100
pin=0;
$display("wait #100 pin=0; | expect 0 1 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
#250
$display("wait #250 | expect 0 0 0 1");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
$display("----------------------------------------------------------");
$display("Test Cleaning");
#250
pin=1;
$display("wait #250 pin=1; | expect 1 0 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
#200
$display("wait #200 | expect 1 0 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);
pin=0; #250
$display("pin=0; #250 | expect 0 0 0 0");
$display("pin: %b | conditioned: %b | rising: %b | falling: %b", pin, conditioned, rising, falling);

end

endmodule
