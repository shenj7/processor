// Register
module reg_component(clock, in, write, reset, out);

input clock;
input [15:0] in;
input write;
input reset;

output reg [15:0] out = 16'b0000000000000000;


always @(posedge clock)
begin
	if (reset) begin
		out <= 16'b0000000000000000;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
