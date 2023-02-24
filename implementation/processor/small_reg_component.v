// Small Register

module small_reg_component(clock, in, write, reset, out);

input clock;
input [3:0] in;
input write;
input reset;

output reg [3:0] out = 0;


always @(posedge clock)
begin
	if (reset) begin
		out <= 0;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
