module de_regs(decode_pcout, decode_a, decode_b, decode_rdout, decode_imm, clock, stall, rst, branch_taken,

 pcwrite_in, mem2reg_in, memwrite_in, alusrc_in, aluin1_in, aluin2_in,
 pcwrite_out, mem2reg_out, memwrite_out, alusrc_out, aluin1_out, aluin2_out,

 execute_pc, execute_a, execute_b, execute_rd, execute_imm);
//inputs
input [15:0] decode_pcout;
input [15:0] decode_a;
input [15:0] decode_b;
input [3:0] decode_rdout;
input [15:0] decode_imm;

input clock;
input stall;
input rst;
input branch_taken;

//control bits
input pcwrite_in;
input mem2reg_in;
input memwrite_in;
input alusrc_in;
input [1:0] aluin1_in;
input [1:0] aluin2_in;

//outputs
output [15:0] execute_pc;
output [15:0] execute_a;
output [15:0] execute_b;
output [3:0] execute_rd;
output [15:0] execute_imm;

//output control
output pcwrite_out;
output mem2reg_out;
output memwrite_out;
output alusrc_out;
output [1:0] aluin1_out;
output [1:0] aluin2_out;


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

little_reg_component aluin1 (
    .clock(clock),
    .in(aluin1_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(aluin1_out)
);

little_reg_component aluin2 (
    .clock(clock),
    .in(aluin2_in), 
    .write(stall),
    .reset(branch_taken || rst),
    .out(aluin2_out)
);


endmodule