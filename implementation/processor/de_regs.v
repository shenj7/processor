module de_regs(decode_regwriteout, decode_irout, decode_pcout, decode_a, decode_b, decode_aluin1out,
 decode_aluin2out, decode_c, decode_rdout, decode_imm, clock, stall, rst, branch_taken, execute_regwritein,
  execute_ir, execute_pc, execute_a, execute_b, execute_aluin1, execute_aluin2, execute_c, execute_rd, execute_imm);
//inputs
input decode_regwriteout;
input [15:0] decode_irout;
input [15:0] decode_pcout;
input [15:0] decode_a;
input [15:0] decode_b;
input [1:0] decode_aluin1out;
input [1:0] decode_aluin2out;
input [15:0] decode_c;
input [3:0] decode_rdout;
input [15:0] decode_imm;

input clock;
input stall;
input rst;
input branch_taken;

//outputs
output [15:0] execute_regwritein;
output [15:0] execute_ir;
output [15:0] execute_pc;
output [15:0] execute_a;
output [15:0] execute_b;
output [1:0] execute_aluin1;
output [1:0] execute_aluin2;
output [15:0] execute_c;
output [3:0] execute_rd;
output [15:0] execute_imm;

tiny_reg_component de_regwrite (
    .clock(clock),
    .in(decode_regwriteout), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_regwritein)
);

reg_component de_ir (
    .clock(clock),
    .in(decode_irout),
    .write(stall),
    .reset(rst),
    .out(execute_ir)
);

reg_component de_pc (
    .clock(clock),
    .in(decode_pcout),
    .write(stall),
    .reset(rst),
    .out(execute_pc)
);

reg_component de_a (
    .clock(clock),
    .in(decode_a),
    .write(stall),
    .reset(rst),
    .out(execute_a)
);

reg_component de_b (
    .clock(clock),
    .in(decode_b),
    .write(stall),
    .reset(rst),
    .out(execute_b)
);

little_reg_component de_aluin1 (
    .clock(clock),
    .in(decode_aluin1out),
    .reset(rst),
    .write(stall),
    .out(execute_aluin1)
);

little_reg_component de_aluin2 (
    .clock(clock),
    .in(decode_aluin2out),
    .reset(rst),
    .write(stall),
    .out(execute_aluin2)
);

reg_component de_c (
    .clock(clock),
    .in(decode_c),
    .write(stall),
    .reset(rst),
    .out(execute_c)
);

small_reg_component de_rd (
    .clock(clock),
    .in(decode_rdout),
    .write(stall),
    .reset(rst),
    .out(execute_rd)
);

reg_component de_imm (
    .clock(clock),
    .in(decode_imm),
    .write(stall),
    .reset(rst),
    .out(execute_imm)
);



always @(posedge clock) begin

end



endmodule