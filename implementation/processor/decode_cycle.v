module decode_cycle(rst, ir, pc, rd, clk, writedata, regwrite, pcout, a, b, rdout, imm, irout);
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
output reg [3:0] rdout;
output [15:0] imm;
output [15:0] irout;


wire [3:0] rs1;
wire [3:0] rs2;
wire [3:0] currrd;


ir_component irc (
    .clock(clk),
    .in1(ir),
    .reset(rst),
    .rs1(rs1),
    .rs2(rs2),
    .rd(currrd),
    .op(irout)
);

reg_file_component rf (
    .clock(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .writedata(writedata),
    .write(regwrite),
    .reset(rst),
    .reg1(a),
    .reg2(b)
);

imm_gen_component ig (
    .clock(clk),
    .reset(rst),
    .inst(ir),
    .out(imm)
);

always @(posedge clk)
begin
    pcout <= pc;
    rdout <= currrd;
    //$display("currpc: %d", pc);
    //$display(" decodde! pcout: %d", pcout);
end


endmodule