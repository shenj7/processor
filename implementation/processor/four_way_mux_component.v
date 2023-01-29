// Four way Multiplexer

module MUX4(clock, in1, in2, in3, in4, op, reset, out);

input clock;
input in1[15:0];
input in2[15:0];
input in3[15:0];
input in4[15:0];
input op[1:0];
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
