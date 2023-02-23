// Register
module tiny_reg_component(clock, in, write, reset, out);

input clock;
input in;
input write;
input reset;

output reg out = 1'b0;


always @(posedge clock)
begin
	if (reset) begin
		out <= 16'b0;
	end else if (write) begin
		out <= in;
	end
end

endmodule