module mem_cycle(clk, b, aluout, memwrite, rst, memout, addrout);
input clk;
input [15:0] b;
input [15:0] aluout;
input memwrite;
input rst;

output [15:0] memout;
output reg [15:0] addrout;

data_mem_component dm (
    .writedata(b),
    .addr(aluout),
    .write(memwrite),
    .clk(clk),
    .out(memout)
);

always @(posedge clk)
begin
    addrout <= aluout;
end

endmodule