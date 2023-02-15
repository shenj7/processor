module fetch_cycle(pc, pcwrite, clk, rst, ir, currpc);

input [15:0] pc;
input pcwrite;
input clk;
input rst;

output reg [15:0] ir;
output reg [15:0] currpc;

wire [15:0] ir;
wire [15:0] newpc;

inst_mem_component im (
    .addr(pc),
    .clk(clk),
    .out(ir)
);

alu_component small_alu (
    .inst_id(1'b0),
    .in0(pc),
    .in1(2'b01),
    .reset(rst),
    .out(newpc),
    .zero(), // should be empty
    .pos()
);

always @(posedge clk)
begin
    currpc = pc;
    if (pcwrite == 1) begin
        pc = newpc;
    end

end


endmodule