module execute_cycle(clk, pc, a, b, rd, imm, inst, aluop, aluin1, aluin2, newpc, aluout, rdout, zero, pos);
//inputs
input clk;
input [15:0] pc;
input [15:0] a;
input [15:0] b;
input [3:0] rd;
input [15:0] imm;
input [15:0] inst;

//controls
input aluop;
input aluin1;
input [1:0] aluin2;

//outputs
output [15:0] newpc;
output [15:0] aluout;
output reg rdout;
output zero;
output pos;

wire [15:0] aluin1_wire;
wire [15:0] aluin2_wire;


two_way_mux_component aluin1_mux (
    .in0(pc),
    .in1(a),
    .op(aluin_2),
    .reset(rst),
    .out(aluin1_wire)
);

four_way_mux_component aluin2_mux (
    .in0(b),
    .in1(16'b0000000000000010),
    .in2(imm),
    .in3(0),
    .op(aluin_2),
    .reset(),
    .out(aluin2_wire)
);

always @(posedge clk)
begin
    rdout <= rd;
end



endmodule