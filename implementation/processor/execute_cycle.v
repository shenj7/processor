module execute_cycle(clk, pc, a, b, c, op, rd, imm, rst, aluop, alusrc, aluin1, aluin2, bout, aluout, rdout, zero, pcwrite, execute_pcwrite, pos, regwrite, regwriteout, forwarded_aluout, intermediate_aluout, opout);
//inputs
input clk;
input [15:0] pc;
input [15:0] a;
input [15:0] b;
input [15:0] c;
input [3:0] rd;
input [3:0] op;
input [15:0] imm;

input [15:0] forwarded_aluout;

//controls
input rst;
input aluop;
input [1:0] aluin1;
input [1:0] aluin2;
input [1:0] alusrc;
input regwrite;
input pcwrite;

//outputs
output reg [15:0] bout;
output [15:0] aluout;
output reg [3:0] rdout;
output zero;
output pos;
output reg regwriteout;
output reg execute_pcwrite;
output reg [3:0] opout; 

wire [15:0] aluin1_wire;
wire [15:0] aluin2_wire;

output wire [15:0] intermediate_aluout;

alu_component alu (
    .inst_id(aluop),
    .in0(aluin1_wire),
    .in1(aluin2_wire),
    .reset(rst),
    .out(intermediate_aluout),
    .zero(zero),
    .pos(pos)
);

four_way_mux_component aluin1_mux (
    .in0(pc),
    .in1(a),
    .in2(forwarded_aluout),
    .in3(0),
    .op(aluin1),
    .reset(rst),
    .out(aluin1_wire)
);

four_way_mux_component aluin2_mux (
    .in0(b),
    .in1(16'b0000000000000010),
    .in2(imm),
    .in3(forwarded_aluout),
    .op(aluin2),
    .reset(rst),
    .out(aluin2_wire)
);

four_way_mux_component aluout_mux (
    .in0(intermediate_aluout),
    .in1(imm),
    .in2(pos),
    .in3(zero),
    .op(alusrc),
    .reset(rst),
    .out(aluout)
);

always @(*) //TODO: ask
begin 
    regwriteout <= regwrite;
    rdout <= rd;
    bout <= b;
    execute_pcwrite <= pcwrite;
    opout <= op;
end



endmodule