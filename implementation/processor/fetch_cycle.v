module fetch_cycle(pc, pcwrite, clk, rst, ir, currpc, newpc);

input [15:0] pc;
input pcwrite;
input clk;
input rst;

output [15:0] ir;
output reg [15:0] currpc;
output [15:0] newpc;

inst_mem_component im (
    .addr(pc),
    .clk(clk),
    .out(ir)
);

alu_component small_alu (
    .inst_id(4'b0000),
    .in0(pc),
    .in1(2'b10),
    .reset(rst),
    .out(newpc),
    .zero(), // should be empty
    .pos()
);

always @(posedge clk)
begin
    currpc = pc;
end


endmodule