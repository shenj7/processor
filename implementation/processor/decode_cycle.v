module decode_cycle(rst, ir, pc, rd, clk, writedata, regwrite, pcout, a, b, c, rdout, imm, irout);
input rst;
input [15:0] ir;
input [15:0] pc;
input [3:0] rd;
input clk;
input [15:0] writedata;

input regwrite;

output reg [15:0] pcout;
output [15:0] a;
output [15:0] b;
output [15:0] c;
output reg [3:0] rdout;
output [15:0] imm;
output reg [15:0] irout;


wire [3:0] rs1;
wire [3:0] rs2;
wire [3:0] currrd;


ir_component irc (
    .in1(ir),
    .reset(rst),
    .rs1(rs1),
    .rs2(rs2),
    .rd(currrd)
);

reg_file_component rf (
    .clock(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .currrd(currrd),
    .writedata(writedata),
    .write(regwrite),
    .reset(rst),
    .reg1(a),
    .reg2(b),
    .rdout(c)
);

imm_gen_component ig (
    .reset(rst),
    .inst(ir),
    .out(imm)
);

always @(posedge clk)
begin
    pcout <= pc;
    rdout <= currrd;
    irout <= ir;
end


endmodule