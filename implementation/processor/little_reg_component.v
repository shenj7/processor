// Small Register

module little_reg_component(clock, in, write, reset, out);

input clock;
input [1:0] in;
input write;
input reset;

output reg [1:0] out = 2'b00;


always @(posedge clock)
begin
	if (reset) begin
		out <= 2'b00;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
