module fd_regs(fetch_pc, inst_ir, decode_pc, decode_ir, clock, stall, rst, branch_taken);
input [15:0] fetch_pc;
input [15:0] inst_ir;

input clock;
input stall;
input rst;
input branch_taken;

output [15:0] decode_pc;
output [15:0] decode_ir;

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


endmodule