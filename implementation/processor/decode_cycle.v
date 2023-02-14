module decode_cycle();

input [15:0] inst;
input clk;
input wrt;
input rst;

output [15:0] inst;

ir_component ir (
    .clock(clk),
    .in1(),
    .reset(),
    .rs1(),
    .rs2(),
    .rd()
);

alu_component small_alu (
    .inst_id(),
    .in0(),
    .in1(),
    .reset(rst),
    .out(),
    .zero(),
    .pos()
);

always @(posedge clock)
begin


end


endmodule