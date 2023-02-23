//ALU

module alu_component(inst_id, in0, in1, reset, out, zero, pos);

input [3:0] inst_id;
input [15:0] in0;
input [15:0] in1;
input reset;

output reg [15:0] out = 0;
output reg zero;
output reg pos;

always @(inst_id or in0 or in1 or reset)
begin
    if (inst_id == 4'b0000 ||
        inst_id == 4'b0100 ||
        inst_id == 4'b0110 ||
        inst_id == 4'b1000 ||
        inst_id == 4'b1001 ||
        inst_id == 4'b1010 ||
        inst_id == 4'b1011) begin
        //add
        out = in0 + in1;
    end else begin
        //subtract
        out = in0 - in1;
    end

    if (out > 0) begin //zero or positive
        pos <= 1;
        zero <= 0;
    end else if (out == 0) begin
        zero <= 1;
        pos <= 0;
    end
end

endmodule
