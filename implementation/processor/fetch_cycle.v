module fetch_cycle();

input [15:0] addr;
input clk;
input wrt;
input rst;

output [15:0] inst;

inst_mem_component im (
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