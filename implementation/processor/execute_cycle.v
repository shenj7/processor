module execute_cycle();
//inputs


//forwarded components

//controls
input rst;
input [15:0] forward_a;
input [15:0] forward_b;
input [1:0] aluin1;
input [1:0] aluin2;
input [1:0] alusrc;

//outputs

alu_component alu (
    .inst_id(),
    .in0(aluin1_wire),
    .in1(aluin2_wire),
    .reset(rst),
    .out(intermediate_aluout),
    .zero(zero),
    .pos(pos)
);

four_way_mux_component aluin1_mux (
    .in0(pc),
    .in1(used_a),
    .in2(forward_a),
    .in3(0),
    .op(aluin1),
    .reset(rst),
    .out(aluin1_wire)
);

four_way_mux_component aluin2_mux (
    .in0(used_b),
    .in1(16'b0000000000000010),
    .in2(imm),
    .in3(forward_b),
    .op(aluin2),
    .reset(rst),
    .out(aluin2_wire)
);

four_way_mux_component aluout_mux (
    .in0(intermediate_aluout),
    .in1(),
    .in2(),
    .in3(),
    .op(),
    .reset(rst),
    .out(aluout)
);

always @(*) //TODO: ask
begin 
end



endmodule