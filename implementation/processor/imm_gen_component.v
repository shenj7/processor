// Immediate Generator
module imm_gen_component(reset, inst, out);

input [15:0] inst;
input reset;

output reg [15:0] out;


always @(inst, reset)
begin
    if (inst[3:0] == 4'b0101) begin
        out <= {{8{inst[15]}},inst[15:8]} << 8;
    end else if(inst[3:0] == 4'b0110) begin
        out <= {{8{inst[15]}},inst[15:8]} << 1;
    end else if (inst[3:0] == 4'b1000 ||
        inst[3:0] == 4'b1001 ||
        inst[3:0] == 4'b1010) begin
        out <= {{12{inst[7]}},inst[7:4]};
	end else if (inst[3:0] == 4'b1111) begin
		out <={{8{0}}, inst[15:8]};
    end
end
endmodule
