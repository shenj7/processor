module fd_regs(fetch_aluin1, fetch_aluin2, fetch_pc, inst_ir, decode_aluin1, decode_aluin2, decode_pc, decode_ir, clock, stall, rst, branch_taken);
input [1:0] fetch_aluin1;
input [1:0] fetch_aluin2;
input [15:0] fetch_pc;
input [15:0] inst_ir;

input clock;
input stall;
input rst;
input branch_taken;

output [1:0] decode_aluin1;
output [1:0] decode_aluin2;
output [15:0] decode_pc;
output [15:0] decode_ir;

little_reg_component fd_aluin1 (
    .clock(clock),
    .in(fetch_aluin1),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_aluin1)
);

little_reg_component fd_aluin2 (
    .clock(clock),
    .in(fetch_aluin2),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_aluin2)
);

reg_component fd_pc (
    .clock(clock),
    .in(fetch_pc),
    .write(stall),
    .reset(branch_taken | rst),
    .out(decode_pc)
);

reg_component fd_ir (
    .clock(clock),
    .in(inst_ir),
    .write(1),
    .reset(branch_taken | rst),
    .out(decode_ir)
);

always @(posedge clock) begin

end


endmodule