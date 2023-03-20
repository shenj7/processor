// Small Register

module little_reg_component(clock, in, write, reset, out);

input clock;
input in;
input write;
input reset;

output reg out = 0;


always @(posedge clock)
begin
	if (reset) begin
		out <= 0;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
