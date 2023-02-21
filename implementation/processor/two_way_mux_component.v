// 2 Way Multiplexer

module two_way_mux_component(in0, in1, op, reset, out);

input [15:0] in0;
input [15:0] in1;
input op;
input reset;

output reg [15:0] out;


always @(in0 or in1 or op)
begin
	// $display("op: %d, in0: %d, in1: %d", op, in0, in1);
	if (reset) begin
		out <= 0;
	end else if (op == 0) begin
		out <= in0;
	end else begin
		out <= in1;
	end
end

endmodule
