module decode_cycle(ir, pc, clk, writedata, regwrite, inst, pcout, a, b, rdout, imm);

input [15:0] ir;
input [15:0] pc;
input clk;
input [15:0] writedata;
input regwrite;

output [15:0] inst;
output [15:0] pcout;
output [15:0] a;
output [15:0] b;
output [3:0] rdout;
output [15:0] imm;


wire [3:0] rs1;
wire [3:0] rs2;
wire [3:0] rd;


ir_component ir (
    .clock(clk),
    .in1(ir),
    .reset(),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
);

reg_file_component rf (
    .clock(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .writedata(writedata),
    .write(regwrite),
    .reset(),
    .reg1(a),
    .reg2(b)
);

imm_gen_component ig (
    .clock(clk),
    .inst(ir),
    .reset(),
    .out(imm)
);

always @(posedge clock)
begin
    pcout = pc;
    rdout = rd;
    inst = ir;


end


endmodule