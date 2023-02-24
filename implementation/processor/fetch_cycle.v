module fetch_cycle(pc, aluin1, aluin2, pcwrite, clk, rst, ir, currpc, newpc, aluin1out, aluin2out);

input [15:0] pc;
input pcwrite;
input rst;
input clk;
input [1:0] aluin1;
input [1:0] aluin2;


output [15:0] ir;
output reg [15:0] currpc;
output reg [15:0] newpc;
output reg [1:0] aluin1out;
output reg [1:0] aluin2out;

inst_mem_component im (
    .clock(clk),
    .addr(pc),
    .out(ir),
    .reset(rst)
);

always @(pc)
begin
    //$display("pc coming from pcmain: %d", pc);
    //$display("Inside fetc ir: %d", ir);
    currpc = pc;
    newpc = pc + 2;
    aluin1out <= aluin1;
    aluin2out <= aluin2;
    //$display("now pc should be %d", newpc);
end


endmodule