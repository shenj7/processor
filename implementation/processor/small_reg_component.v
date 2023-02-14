// Small Register

module small_reg_component(clk, in, write, reset, out);

input clk;
input [3:0] in;
input write;
input reset;

output reg [3:0] out;


always @(posedge clk)
begin
	if (reset) begin
		out <= 0;
	end else if (write) begin
		out <= in;
	end
end

endmodule

	
