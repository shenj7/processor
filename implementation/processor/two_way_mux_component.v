// 2 Way Multiplexer

module two_way_mux_component(clock, in1, in2, op, reset, out);

input clock;
input [15:0] in1;
input [15:0] in2;
input op;
input reset;

output reg [15:0] out;


always @(posedge clock)
begin
	if (reset) begin
		out <= 0;
	end else if (op == 0) begin
		out <= in1;
	end else begin
		out <= in2;
	end
end

endmodule
