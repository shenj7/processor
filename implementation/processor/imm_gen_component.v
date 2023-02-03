// Immediate Generator
module imm_gen_component(clock, reset, inst, out);

input clock;
input [15:0] inst;
input reset;

output reg [15:0] out;


always @(posedge clock)
begin
	 if (inst[3:0] == 4'b0101) begin
			 out <= $signed(inst[8:15]) << 8;
	 end else if(inst[3:0] == 4'b0110) begin
			 out <= $signed(inst[8:15]) <<1;
	 end else if (inst[3:0] == 4'b1000 ||
        inst[3:0] == 4'b1001 ||
        inst[3:0] == 4'b1010 ||
        inst[3:0] == 4'b1011) begin
			 out <= $signed(inst[8:15]);
			 end				
end
