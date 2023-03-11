module mem_cycle(clk, b, aluout, memwrite, read_in, write_out, rst, memout);
input clk;
input [15:0] b;
input [15:0] aluout;
input memwrite;
input rst;
input [15:0] read_in;

output [15:0] write_out;
output [15:0] memout;

data_mem_component dm (
    .writedata(b),
    .addr(aluout),
    .write(memwrite),
    .read_in(read_in),
    .write_out(write_out),
    .clk(clk),
    .out(memout)
);

endmodule