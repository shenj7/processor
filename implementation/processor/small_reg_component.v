// Small Register

module REG(clock, in, write, reset, out);

input clock;
input in[3:0];
input write;
input reset;

output reg [3:0] out;


always @(posedge clock)
begin
	if (reset) begin
		out <= 0;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
