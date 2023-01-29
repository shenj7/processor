// 2 Way Multiplexer

module MUX2(clock, in1, in2, op, reset, out);

input clock;
input in1[15:0];
input in2[15:0];
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
