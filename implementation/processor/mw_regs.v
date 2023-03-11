module mw_regs(mem2reg_in, mem2reg_out, pcwrite_in, pcwrite_out, decode_rd, mem_memout, mem_aluout, write_rd, writeback_memout, writeback_alufor, clock, stall, rst);

input [3:0] decode_rd;
input [15:0] mem_memout;
input [15:0] mem_aluout;

input mem2reg_in,
input pcwrite_in,

input clock;
input stall;
input rst;

output [3:0] write_rd;
output [15:0] writeback_memout;
output [15:0] writeback_alufor;

output mem2reg_out,
output pcwrite_out

tiny_reg_component mw_mem2reg (
    .clock(clock),
    .in(mem2reg_in),
    .write(1),
    .reset(rst),
    .out(mem2reg_out)
);

tiny_reg_component mw_pcwrite (
    .clock(clock),
    .in(pcwrite_in),
    .write(1),
    .reset(rst),
    .out(pcwrite_out)
);


small_reg_component mw_rd (
    .clock(clock),
    .in(decode_rd),
    .write(1),
    .reset(rst),
    .out(write_rd)
);

reg_component mw_mem (
    .clock(clock),
    .in(mem_memout),
    .write(1),
    .reset(rst),
    .out(writeback_memout)
);

reg_component mw_alufor (
    .clock(clock),
    .in(mem_aluout),
    .write(1),
    .reset(rst),
    .out(writeback_alufor)
);


endmodule