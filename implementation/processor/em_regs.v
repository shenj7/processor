module em_regs(execute_regwriteout, newb, execute_aluout, execute_rd, memory_regwritein, mem_b, mem_aluout, decode_rd, clock, stall, rst);

input execute_regwriteout;
input [15:0] newb;
input [15:0] execute_aluout;
input [3:0] execute_rd;

input clock;
input stall;
input rst;

output memory_regwritein;
output [15:0] mem_b;
output [15:0] mem_aluout;
output [3:0] decode_rd;


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