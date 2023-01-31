// Four way Multiplexer

module four_way_mux_component(clock, in1, in2, in3, in4, op, reset, out);

input clock;
input [15:0] in1;
input [15:0] in2;
input [15:0] in3;
input [15:0] in4;
input [1:0] op;
input reset;

output reg [15:0] out;


always @(posedge clock)
begin
	if (reset) begin
		out <= 0;
	end else
    begin
		case (op)
			2'b00: out <= in1;
			2'b01: out <= in2;
			2'b10: out <= in3;
			2'b11: out <= in4;
		endcase
	end
end

endmodule
