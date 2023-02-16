// Instruction register

module ir_component(clock, in1, reset, rs1, rs2, rd);

input clock;
input [15:0] in1;
input reset;

output reg [3:0] rs1;
output reg [3:0] rs2;
output reg [3:0] rd;


always @(posedge clock)
begin
        if (reset == 1) begin
                rs1 <= 4'b0000;
		rs2 <= 4'b0000;
		rd <= 4'b0000;
        end else begin
                rs1 <= in1[11:8];
		rs2 <= in1[15:12];
		rd <= in1[7:4];
        end
end

endmodule
