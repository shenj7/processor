module em_regs(pcwrite_in, pcwrite_out, mem2reg_in, mem2reg_out, memwrite_in, memwrite_out, execute_regwriteout, newb, execute_aluout, execute_rd, memory_regwritein, mem_b, mem_aluout, decode_rd, clock, stall, rst);

input execute_regwriteout;
input [15:0] newb;
input [15:0] execute_aluout;
input [3:0] execute_rd;

input pcwrite_in;
input mem2reg_in;
input memwrite_in;

input clock;
input stall;
input rst;

output memory_regwritein;
output [15:0] mem_b;
output [15:0] mem_aluout;
output [3:0] decode_rd;

output pcwrite_out;
output mem2reg_out;
output memwrite_out;

tiny_reg_component em_pcwrite (
    .clock(clock),
    .in(pcwrite_in),
    .write(stall),
    .reset(rst),
    .out(pcwrite_out)
);

tiny_reg_component em_mem2reg (
    .clock(clock),
    .in(mem2reg_in),
    .write(stall),
    .reset(rst),
    .out(mem2reg_out)
);

tiny_reg_component em_memwrite (
    .clock(clock),
    .in(memwrite_in),
    .write(stall),
    .reset(rst),
    .out(memwrite_out)
);

tiny_reg_component em_regwrite (
    .clock(clock),
    .in(execute_regwriteout),
    .write(stall),
    .reset(rst),
    .out(memory_regwritein)
);


reg_component em_b (
    .clock(clock),
    .in(newb),
    .write(stall),
    .reset(rst),
    .out(mem_b)
);

reg_component em_aluout (
    .clock(clock),
    .in(execute_aluout),
    .write(stall),
    .reset(rst),
    .out(mem_aluout)
);

small_reg_component em_rd (
    .clock(clock),
    .in(execute_rd),
    .write(stall),
    .reset(rst),
    .out(decode_rd)
);

always @(posedge clock) begin

end


endmodule