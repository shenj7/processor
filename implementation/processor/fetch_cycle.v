module fetch_cycle(pc, pcwrite, rst, ir, currpc, newpc);

input [15:0] pc;
input pcwrite;
input rst;

output [15:0] ir;
output reg [15:0] currpc;
output reg [15:0] newpc;

inst_mem_component im (
    .addr(pc),
    .clk(clk),
    .out(ir)
);

always @(pc)
begin
    $display("pc coming from pcmain: %d", pc);
    $display("Inside fetc ir: %d", ir);
    currpc = pc;
    newpc = pc + 2;
    $display("now pc should be %d", newpc);
end


endmodule