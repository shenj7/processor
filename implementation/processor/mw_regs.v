module mw_regs(decode_rd, mem_memout, mem_aluout, memory_regwriteout, write_rd, writeback_memout, writeback_alufor, wb_regwrite, clock, stall, rst);

input [3:0] decode_rd;
input [15:0] mem_memout;
input [15:0] mem_aluout;
input memory_regwriteout;

input clock;
input stall;
input rst;

output [3:0] write_rd;
output [15:0] writeback_memout;
output [15:0] writeback_alufor;
output wb_regwrite;


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

tiny_reg_component mw_regwrite (
    .clock(clock),
    .in(memory_regwriteout),
    .write(1),
    .reset(rst),
    .out(wb_regwrite)
);



always @(posedge clock) begin

end


endmodule