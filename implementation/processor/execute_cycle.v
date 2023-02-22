module execute_cycle(clk, pc, a, b, rd, imm, rst, aluop, aluin1, aluin2, bout, aluout, rdout, zero, pos, regwrite, regwriteout, forwarded_aluout);
//inputs
input clk;
input [15:0] pc;
input [15:0] a;
input [15:0] b;
input [3:0] rd;
input [15:0] imm;

input [15:0] forwarded_aluout;

//controls
input rst;
input aluop;
input [1:0] aluin1;
input [1:0] aluin2;
input regwrite;

//outputs
output reg [15:0] bout;
output [15:0] aluout;
output reg [3:0] rdout;
output zero;
output pos;
output reg regwriteout;

wire [15:0] aluin1_wire;
wire [15:0] aluin2_wire;

alu_component alu (
    .inst_id(aluop),
    .in0(aluin1_wire),
    .in1(aluin2_wire),
    .reset(rst),
    .out(aluout),
    .zero(zero),
    .pos(pos)
);

four_way_mux_component aluin1_mux (
    .in0(pc),
    .in1(a),
    .in2(forwarded_aluout),
    .in3(0),
    .op(aluin2),
    .reset(rst),
    .out(aluin1_wire)
);

four_way_mux_component aluin2_mux (
    .in0(b),
    .in1(16'b0000000000000010),
    .in2(imm),
    .in3(forwarded_aluout),
    .op(aluin2),
    .reset(),
    .out(aluin2_wire)
);

always @(posedge clk)
begin 
    regwriteout <= regwrite;
    rdout <= rd;
    bout <= b;
    //$display("execute rdout: %d", rdout);
    //$display("zero: %d", zero);
end



endmodule