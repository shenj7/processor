module de_regs(decode_regwriteout, decode_irout, decode_pcout, decode_a, decode_b, decode_aluin1out,
 decode_aluin2out, decode_c, decode_rdout, decode_imm, clock, stall, rst, branch_taken,

 pcwrite_in, mem2reg_in, memwrite_in, alusrc_in, aluin1_in, aluin2_in,
 pcwrite_out, mem2reg_out, memwrite_out, alusrc_out, aluin1_out, aluin2_out,

 execute_regwritein, execute_ir, execute_pc, execute_a, execute_b, execute_aluin1, execute_aluin2, execute_c, execute_rd, execute_imm);
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

//control bits
input pcwrite;
input mem2reg;
input memwrite;
input alusrc;
input aluin1;
input aluin2;

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
    .reset(branch_taken || rst),
    .out(execute_ir)
);

reg_component de_pc (
    .clock(clock),
    .in(decode_pcout),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_pc)
);

reg_component de_a (
    .clock(clock),
    .in(decode_a),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_a)
);

reg_component de_b (
    .clock(clock),
    .in(decode_b),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_b)
);

little_reg_component de_aluin1 (
    .clock(clock),
    .in(decode_aluin1out),
    .reset(branch_taken || rst),
    .write(stall),
    .out(execute_aluin1)
);

little_reg_component de_aluin2 (
    .clock(clock),
    .in(decode_aluin2out),
    .reset(branch_taken || rst),
    .write(stall),
    .out(execute_aluin2)
);

reg_component de_c (
    .clock(clock),
    .in(decode_c),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_c)
);

small_reg_component de_rd (
    .clock(clock),
    .in(decode_rdout),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_rd)
);

reg_component de_imm (
    .clock(clock),
    .in(decode_imm),
    .write(stall),
    .reset(branch_taken || rst),
    .out(execute_imm)
);

tiny_reg_component pcwrite (
    .clock(clock),
    .in(pcwrite_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(pcwrite_out)
);
tiny_reg_component m2r (
    .clock(clock),
    .in(mem2reg_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(mem2reg_out)
);
tiny_reg_component memwrite (
    .clock(clock),
    .in(memwrite_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(memwrite_out)
);
tiny_reg_component alusrc (
    .clock(clock),
    .in(alusrc_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(alusrc_out)
);

tiny_reg_component aluin1 (
    .clock(clock),
    .in(aluin1_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(aluin1_out)
);

tiny_reg_component aluin2 (
    .clock(clock),
    .in(aluin2_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(aluin2_out)
);

always @(posedge clock) begin

end



endmodule