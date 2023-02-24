// Four way Multiplexer

module four_way_mux_component(in0, in1, in2, in3, op, reset, out);

input [15:0] in0;
input [15:0] in1;
input [15:0] in2;
input [15:0] in3;
input [1:0] op;
input reset;

output reg [15:0] out;


always @(in0 or in1 or in2 or in3 or op or reset)
begin
	if (reset) begin
		out <= 0;
	end else
    begin
		case (op)
			2'b00: out <= in0;
			2'b01: out <= in1;
			2'b10: out <= in2;
			2'b11: out <= in3;
		endcase
	end
end

endmodule
